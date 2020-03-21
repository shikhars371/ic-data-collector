import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:catcher/catcher_plugin.dart';
import 'package:dio/dio.dart';

import '../configs/configuration.dart';
import '../utils/db_helper.dart';
import '../models/reworkassignment.dart';
import '../utils/appstate.dart';
import './auth.dart';
import '../models/localpropertydata.dart';

class ReworkTask with ChangeNotifier {
  AppState _state = AppState.Idle;
  AppState get state => _state;
  void setState(AppState appState) {
    _state = appState;
    notifyListeners();
  }

  List<ReworkAssignment> _reworkAssignments = [];
  List<ReworkAssignment> get reworkAssignments => _reworkAssignments;

  Future<List<ReworkAssignment>> getReworkAssignments() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      setState(AppState.Busy);
      _reworkAssignments = [];
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var responce = await http.get(
            Configuration.apiurl +
                'taskreassignment?\$or[0][surveyor1]=${preferences.getString('userid')}&\$or[1][surveyor2]=${preferences.getString('userid')}',
            headers: {
              "Content-Type": "application/json",
              "Authorization": preferences.getString("accesstoken")
            });
        if (responce.statusCode == 200) {
          Map responseJson = json.decode(responce.body);
          Iterable i = responseJson['data'];
          if ((i != null) || (i.isNotEmpty)) {
            _reworkAssignments =
                i.map((model) => ReworkAssignment.fromJson(model)).toList();
          }
        } else if (responce.statusCode == 401) {
          var email = preferences.getString('email');
          if (!(email?.isEmpty ?? true)) {
            AuthModel().generateRefreshToken().then((_) {
              getReworkAssignments();
            });
          }
        }
        //reworkAssignments have data
        if (!(_reworkAssignments?.isEmpty ?? true)) {
          //insert data to local database
          await DBHelper()
              .addReworkSurvey(reworkassignments: _reworkAssignments);
        }
      }
      _reworkAssignments = await DBHelper().getReworkSurvey();
    } catch (error, stackTrace) {
      setState(AppState.Idle);
      Catcher.reportCheckedError(error, stackTrace);
    }
    setState(AppState.Idle);
    return _reworkAssignments;
  }

  Future<bool> downLoadPropertyData({String propertyid}) async {
    bool result = false;
    setState(AppState.Busy);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      if (!(propertyid?.isEmpty ?? true)) {
        var responce = await http.get(
            Configuration.apiurl + 'propertyinformation/$propertyid',
            headers: {
              "Content-Type": "application/json",
              "Authorization": preferences.getString("accesstoken")
            });
        if (responce.statusCode == 200) {
          LocalPropertySurvey property =
              jsonToProperty(responseJson: json.decode(responce.body));
          var isinsertedintodb = await DBHelper().addPropertySurvey(property);
          if (isinsertedintodb != 0) {
            var isupdatedintodb = await DBHelper()
                .updatePropertySurvey(property, property.local_property_key);
            if (isupdatedintodb != 0) {}
          }
        }
      }
    } catch (error, stackTrace) {
      setState(AppState.Idle);
      Catcher.reportCheckedError(error, stackTrace);
    }
    setState(AppState.Idle);
    return result;
  }

  Future<bool> downloadFile() async {
    bool result = false;
    try {
      var dio = Dio();
      //var responce = await dio.download(urlPath, savePath);
    } catch (error, stackTrace) {
      setState(AppState.Idle);
      Catcher.reportCheckedError(error, stackTrace);
    }
    return result;
  }

  LocalPropertySurvey jsonToProperty({Map responseJson}) {
    LocalPropertySurvey _localproperty = new LocalPropertySurvey();
    _localproperty.id = responseJson[''];
    _localproperty.taskid = responseJson[''];
    _localproperty.local_created_on = responseJson[''];
    _localproperty.local_property_key = responseJson[''];
    _localproperty.other_key = responseJson[''];
    _localproperty.first_surveyor_name =
        responseJson['surveyors_info']['surveyor_1'];
    _localproperty.senond_surveyor_name =
        responseJson['surveyors_info']['surveyor_2'];
    _localproperty.technical_support_name =
        responseJson['surveyors_info']['supporting_surveyor'];
    _localproperty.property_dispte_subject_to =
        responseJson['arguments_1']['property_argument'];
    _localproperty.real_person_status =
        responseJson['arguments_1']['human_argument'];
    _localproperty.cityzenship_notice =
        responseJson['arguments_1']['tazkira_argument'];
    _localproperty.issue_regarding_property =
        responseJson['arguments_2']['property_note'];
    _localproperty.municipality_ref_number =
        responseJson['arguments_2']['municipality_reg_no'];
    _localproperty.natural_threaten =
        responseJson['arguments_2']['property_endangerment'];
    _localproperty.status_of_area_plan =
        responseJson['property_physical_condition']['planned_unplanned'];
    _localproperty.status_of_area_official =
        responseJson['property_physical_condition']['formal_informal'];
    _localproperty.status_of_area_regular =
        responseJson['property_physical_condition']['regular_irregular'];
    _localproperty.slope_of_area =
        responseJson['property_physical_condition']['slope'];
    _localproperty.province =
        responseJson['property_physical_location']['province_id'];
    _localproperty.city =
        responseJson['property_physical_location']['municipality_id'];
    _localproperty.area =
        responseJson['property_physical_location']['nahia_id'];
    _localproperty.pass =
        responseJson['property_physical_location']['guzar_id'];
    _localproperty.block =
        responseJson['property_physical_location']['block_id'];
    _localproperty.part_number =
        responseJson['property_physical_location']['parcel_no'];
    _localproperty.unit_number =
        responseJson['property_physical_location']['unit_no'];
    _localproperty.unit_in_parcel =
        responseJson['property_physical_location']['no_unit_in_parcel'];
    _localproperty.street_name =
        responseJson['property_physical_location']['road_name'];
    _localproperty.historic_site_area =
        responseJson['property_physical_location']['historical_value'];
    _localproperty.land_area =
        responseJson['property_physical_location']['parcel_area'];
    _localproperty.property_type =
        responseJson['property_physical_location']['ownership_type'];
    _localproperty.location_of_land_area = responseJson['zones'];
    _localproperty.property_have_document = responseJson['doc_presence_state'];
    _localproperty.document_type = responseJson['document_type_info'];
    _localproperty.issued_on =
        responseJson['govermental_doc_specification']['doc_issue_date'];
    _localproperty.place_of_issue =
        responseJson['govermental_doc_specification']['doc_issue_place'];
    _localproperty.property_number =
        responseJson['govermental_doc_specification']['property_reg_no'];
    _localproperty.document_cover =
        responseJson['govermental_doc_specification']['doc_volume_no'];
    _localproperty.document_page =
        responseJson['govermental_doc_specification']['doc_page_no'];
    _localproperty.doc_reg_number =
        responseJson['govermental_doc_specification']['doc_reg_no'];
    _localproperty.land_area_qawwala =
        responseJson['govermental_doc_specification']['doc_property_area'];
    _localproperty.property_doc_photo_1 =
        responseJson['govermental_doc_specification']['doc_img_1'];
    _localproperty.property_doc_photo_2 =
        responseJson['govermental_doc_specification']['doc_img_2'];
    _localproperty.property_doc_photo_3 =
        responseJson['govermental_doc_specification']['doc_img_3'];
    _localproperty.property_doc_photo_4 =
        responseJson['govermental_doc_specification']['doc_img_4'];
    _localproperty.odinary_doc_photo1 =
        responseJson['local_doc_specification']['local_doc_img_1'];
    _localproperty.odinary_doc_photo6 =
        responseJson['local_doc_specification']['local_doc_img_2'];
    _localproperty.use_in_property_doc =
        responseJson['property_given_usage_type'];
    _localproperty.current_use_of_property =
        responseJson['property_current_usage_type'];
    _localproperty.type_of_use_other =
        responseJson['property_other_usage_type'];
    _localproperty.redeemable_property = responseJson['usage_rental'];
    _localproperty.proprietary_properties = responseJson['usage_business'];
    _localproperty.govt_property = responseJson['usage_govermental'];
    _localproperty.specified_current_use = responseJson['usage_other'];
    _localproperty.unspecified_current_use_type =
        responseJson['business_other_type'];
    _localproperty.number_of_business_unit =
        responseJson['business_licence']['units_with_licence'];
    _localproperty.business_unit_have_no_license =
        responseJson['business_licence']['units_without_licence'];
    _localproperty.business_license_another =
        responseJson['business_licence']['other'];
    _localproperty.first_partner_name =
        responseJson['owner_or_first_partner_info']['name'];
    _localproperty.first_partner_surname =
        responseJson['owner_or_first_partner_info']['surname'];
    _localproperty.first_partner_boy =
        responseJson['owner_or_first_partner_info']['father_name'];
    _localproperty.first_partner__father =
        responseJson['owner_or_first_partner_info']['grand_father_name'];
    _localproperty.first_partner_name_gender =
        responseJson['owner_or_first_partner_info']['gender'];
    _localproperty.first_partner_name_phone =
        responseJson['owner_or_first_partner_info']['phone_no'];
    _localproperty.first_partner_name_email =
        responseJson['owner_or_first_partner_info']['emal'];
    _localproperty.first_partner_name_property_owner =
        responseJson['owner_or_first_partner_info']['photo_person'];
    _localproperty.first_partner_name_mere_individuals =
        responseJson['owner_or_first_partner_info']['note_person'];
    _localproperty.info_photo_hint_sukuk_number = responseJson[''];
    _localproperty.info_photo_hint_cover_note = responseJson[''];
    _localproperty.info_photo_hint_note_page = responseJson[''];
    _localproperty.info_photo_hint_reg_no = responseJson[''];
    _localproperty.info_photo_hint_photo_note1 = responseJson[''];
    _localproperty.info_photo_hint_photo_tips1 = responseJson[''];
    _localproperty.info_photo_hint_photo_tips2 = responseJson[''];
    _localproperty.fore_limits_east = responseJson[''];
    _localproperty.fore_limits_west = responseJson[''];
    _localproperty.fore_limits_south = responseJson[''];
    _localproperty.fore_limits_north = responseJson[''];
    _localproperty.lightning_meter_no = responseJson[''];
    _localproperty.lightning_common_name = responseJson[''];
    _localproperty.lightning_father_name = responseJson[''];
    _localproperty.lightning_picture_bell_power = responseJson[''];
    _localproperty.safari_booklet_common_name = responseJson[''];
    _localproperty.safari_booklet_father_name = responseJson[''];
    _localproperty.safari_booklet_machinegun_no = responseJson[''];
    _localproperty.safari_booklet_issue_date = responseJson[''];
    _localproperty.safari_booklet_picture = responseJson[''];
    _localproperty.property_user_owner = responseJson[''];
    _localproperty.property_user_master_rent = responseJson[''];
    _localproperty.property_user_recipient_group = responseJson[''];
    _localproperty.property_user_no_longer = responseJson[''];
    _localproperty.property_user_type_of_misconduct = responseJson[''];
    _localproperty.fst_have_building = responseJson[''];
    _localproperty.fst_building_use = responseJson[''];
    _localproperty.fst_building_category = responseJson[''];
    _localproperty.fst_specifyif_other = responseJson[''];
    _localproperty.fst_no_of_floors = responseJson[''];
    _localproperty.fst_cubie_meter = responseJson[''];
    _localproperty.snd_have_building = responseJson[''];
    _localproperty.snd_building_use = responseJson[''];
    _localproperty.snd_building_category = responseJson[''];
    _localproperty.snd_specifyif_other = responseJson[''];
    _localproperty.snd_no_of_floors = responseJson[''];
    _localproperty.snd_cubie_meter = responseJson[''];
    _localproperty.trd_have_building = responseJson[''];
    _localproperty.trd_building_use = responseJson[''];
    _localproperty.trd_building_category = responseJson[''];
    _localproperty.trd_specifyif_other = responseJson[''];
    _localproperty.trd_no_of_floors = responseJson[''];
    _localproperty.trd_cubie_meter = responseJson[''];
    _localproperty.forth_have_building = responseJson[''];
    _localproperty.forth_building_use = responseJson[''];
    _localproperty.forth_building_category = responseJson[''];
    _localproperty.forth_specifyif_other = responseJson[''];
    _localproperty.forth_no_of_floors = responseJson[''];
    _localproperty.forth_cubie_meter = responseJson[''];
    _localproperty.fth_have_building = responseJson[''];
    _localproperty.fth_building_use = responseJson[''];
    _localproperty.fth_building_category = responseJson[''];
    _localproperty.fth_specifyif_other = responseJson[''];
    _localproperty.fth_no_of_floors = responseJson[''];
    _localproperty.fth_cubie_meter = responseJson[''];
    _localproperty.home_map = responseJson[''];
    _localproperty.home_photo = responseJson[''];
    _localproperty.reg_property_fertilizer = responseJson[''];
    _localproperty.area_unit_release_area = responseJson[''];
    _localproperty.area_unit_business_area = responseJson[''];
    _localproperty.area_unit_total_no_unit = responseJson[''];
    _localproperty.area_unit_business_units = responseJson[''];
    _localproperty.second_partner_name = responseJson[''];
    _localproperty.second_partner_surname = responseJson[''];
    _localproperty.second_partner_boy = responseJson[''];
    _localproperty.second_partner_father = responseJson[''];
    _localproperty.second_partner_gender = responseJson[''];
    _localproperty.second_partner_phone = responseJson[''];
    _localproperty.second_partner_email = responseJson[''];
    _localproperty.second_partner_image = responseJson[''];
    _localproperty.second_partner_machinegun_no = responseJson[''];
    _localproperty.second_partner_cover_note = responseJson[''];
    _localproperty.second_partner_note_page = responseJson[''];
    _localproperty.second_partner_reg_no = responseJson[''];
    _localproperty.second_partner_phote_note1 = responseJson[''];
    _localproperty.second_partner_photo_tips1 = responseJson[''];
    _localproperty.second_partner_photo_tips2 = responseJson[''];
    _localproperty.third_partner_name = responseJson[''];
    _localproperty.third_partner_surname = responseJson[''];
    _localproperty.third_partner_boy = responseJson[''];
    _localproperty.third_partner_father = responseJson[''];
    _localproperty.third_partner_gender = responseJson[''];
    _localproperty.third_partner_phone = responseJson[''];
    _localproperty.third_partner_email = responseJson[''];
    _localproperty.third_partner_image = responseJson[''];
    _localproperty.third_partner_machinegun_no = responseJson[''];
    _localproperty.third_partner_cover_note = responseJson[''];
    _localproperty.third_partner_note_page = responseJson[''];
    _localproperty.third_partner_reg_no = responseJson[''];
    _localproperty.third_partner_phote_note1 = responseJson[''];
    _localproperty.third_partner_photo_tips1 = responseJson[''];
    _localproperty.third_partner_photo_tips2 = responseJson[''];
    _localproperty.fourth_partner_name = responseJson[''];
    _localproperty.fourth_partner_surname = responseJson[''];
    _localproperty.fourth_partner_boy = responseJson[''];
    _localproperty.fourth_partner_father = responseJson[''];
    _localproperty.fourth_partner_gender = responseJson[''];
    _localproperty.fourth_partner_phone = responseJson[''];
    _localproperty.fourth_partner_email = responseJson[''];
    _localproperty.fourth_partner_image = responseJson[''];
    _localproperty.fourth_partner_machinegun_no = responseJson[''];
    _localproperty.fourth_partner_cover_note = responseJson[''];
    _localproperty.fourth_partner_note_page = responseJson[''];
    _localproperty.fourth_partner_reg_no = responseJson[''];
    _localproperty.fourth_partner_phote_note1 = responseJson[''];
    _localproperty.fourth_partner_photo_tips1 = responseJson[''];
    _localproperty.fourth_partner_photo_tips2 = responseJson[''];
    _localproperty.fifth_partner_name = responseJson[''];
    _localproperty.fifth_partner_surname = responseJson[''];
    _localproperty.fifth_partner_boy = responseJson[''];
    _localproperty.fifth_partner_father = responseJson[''];
    _localproperty.fifth_partner_gender = responseJson[''];
    _localproperty.fifth_partner_phone = responseJson[''];
    _localproperty.fifth_partner_email = responseJson[''];
    _localproperty.fifth_partner_image = responseJson[''];
    _localproperty.fifth_partner_machinegun_no = responseJson[''];
    _localproperty.fifth_partner_cover_note = responseJson[''];
    _localproperty.fifth_partner_note_page = responseJson[''];
    _localproperty.fifth_partner_reg_no = responseJson[''];
    _localproperty.fifth_partner_phote_note1 = responseJson[''];
    _localproperty.fifth_partner_photo_tips1 = responseJson[''];
    _localproperty.fifth_partner_photo_tips2 = responseJson[''];
    _localproperty.formval = responseJson[''];
    _localproperty.editmode = responseJson[''];
    _localproperty.isdrafted = responseJson[''];
    _localproperty.boundaryinfonote = responseJson[''];
    _localproperty.surveyenddate = responseJson[''];
    _localproperty.surveyoroneid = responseJson[''];
    _localproperty.surveyortwoid = responseJson[''];
    _localproperty.surveyleadid = responseJson[''];
    _localproperty.isreldocphoto1 = responseJson[''];
    _localproperty.isreldocphoto2 = responseJson[''];
    _localproperty.isreldocphoto3 = responseJson[''];
    _localproperty.isreldocphoto4 = responseJson[''];
    _localproperty.isoddocphoto1 = responseJson[''];
    _localproperty.isoddocphoto6 = responseJson[''];
    _localproperty.isfirstpartner_photo = responseJson[''];
    _localproperty.isinfophotonote1 = responseJson[''];
    _localproperty.isinfophototips1 = responseJson[''];
    _localproperty.isinfophototips2 = responseJson[''];
    _localproperty.issecond_partner_photo = responseJson[''];
    _localproperty.issecond_partner_photo_note1 = responseJson[''];
    _localproperty.issecond_partner_photo_tips1 = responseJson[''];
    _localproperty.issecond_partner_photo_tips2 = responseJson[''];
    _localproperty.isthird_partner_photo = responseJson[''];
    _localproperty.isthird_partner_photo_note1 = responseJson[''];
    _localproperty.isthird_partner_photo_tips1 = responseJson[''];
    _localproperty.isthird_partner_photo_tips2 = responseJson[''];
    _localproperty.isfourth_partner_photo = responseJson[''];
    _localproperty.isfourth_partner_photo_note1 = responseJson[''];
    _localproperty.isfourth_partner_photo_tips1 = responseJson[''];
    _localproperty.isfourth_partner_photo_tips2 = responseJson[''];
    _localproperty.isfifth_partner_photo = responseJson[''];
    _localproperty.isfifth_partner_photo_note1 = responseJson[''];
    _localproperty.isfifth_partner_photo_tips1 = responseJson[''];
    _localproperty.isfifth_partner_photo_tips2 = responseJson[''];
    _localproperty.ismeter_pic_bill_power = responseJson[''];
    _localproperty.issafari_booklet_pic = responseJson[''];
    _localproperty.ishome_sketch_map = responseJson[''];
    _localproperty.ishome_photo = responseJson[''];
    return _localproperty;
  }
}
