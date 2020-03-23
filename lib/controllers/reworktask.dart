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
    _localproperty.info_photo_hint_sukuk_number =
        responseJson['tazkira_information']['tazkira_serial_no'];
    _localproperty.info_photo_hint_cover_note =
        responseJson['tazkira_information']['tazkira_volume_no'];
    _localproperty.info_photo_hint_note_page =
        responseJson['tazkira_information']['tazkira_page_no'];
    _localproperty.info_photo_hint_reg_no =
        responseJson['tazkira_information']['tazkira_reg_no'];
    _localproperty.info_photo_hint_photo_note1 =
        responseJson['tazkira_information']['tazkira_image_1'];
    _localproperty.info_photo_hint_photo_tips1 =
        responseJson['tazkira_information']['tazkira_image_2'];
    _localproperty.info_photo_hint_photo_tips2 =
        responseJson['tazkira_information']['tazkira_image_3'];
    _localproperty.fore_limits_east =
        responseJson['property_boundaries_info']['East'];
    _localproperty.fore_limits_west =
        responseJson['property_boundaries_info']['West'];
    _localproperty.fore_limits_south =
        responseJson['property_boundaries_info']['South'];
    _localproperty.fore_limits_north =
        responseJson['property_boundaries_info']['North'];
    _localproperty.lightning_meter_no =
        responseJson['electricity_bill_info']['meter_no'];
    _localproperty.lightning_common_name =
        responseJson['electricity_bill_info']['customer_name'];
    _localproperty.lightning_father_name =
        responseJson['electricity_bill_info']['cuntomer_father_name'];
    _localproperty.lightning_picture_bell_power =
        responseJson['electricity_bill_info']['ebill_img'];
    _localproperty.safari_booklet_common_name =
        responseJson['sanitation_booklet_info']['cust_name'];
    _localproperty.safari_booklet_father_name =
        responseJson['sanitation_booklet_info']['cust_father_name'];
    _localproperty.safari_booklet_machinegun_no =
        responseJson['sanitation_booklet_info']['sanitation_booklet_serial_no'];
    _localproperty.safari_booklet_issue_date =
        responseJson['sanitation_booklet_info']['issue_date'];
    _localproperty.safari_booklet_picture =
        responseJson['sanitation_booklet_info']['sanitation_booklet_img'];
    _localproperty.property_user_owner =
        responseJson['property_user_info']['owner_occupier'];
    _localproperty.property_user_master_rent =
        responseJson['property_user_info']['rental_occupier'];
    _localproperty.property_user_recipient_group =
        responseJson['property_user_info']['mortagage_occupier'];
    _localproperty.property_user_no_longer =
        responseJson['property_user_info']['other_occupier'];
    _localproperty.property_user_type_of_misconduct =
        responseJson['other_occupier_type'];
    _localproperty.fst_have_building = responseJson['building_structure_info']
        ['building_structure_1']['building_structure_1_presence'];
    _localproperty.fst_building_use = responseJson['building_structure_info']
        ['building_structure_1']['building_1_usage_type'];
    _localproperty.fst_building_category =
        responseJson['building_structure_info']['building_structure_1']
            ['building_1_category'];
    _localproperty.fst_specifyif_other = responseJson['building_structure_info']
        ['building_structure_1']['building_1_cat_other'];
    _localproperty.fst_no_of_floors = responseJson['building_structure_info']
        ['building_structure_1']['building_1_floor_count'];
    _localproperty.fst_cubie_meter = responseJson['building_structure_info']
        ['building_structure_1']['building_1_volume'];
    _localproperty.snd_have_building = responseJson['building_structure_info']
        ['building_structure_2']['building_structure_2_presence'];
    _localproperty.snd_building_use = responseJson['building_structure_info']
        ['building_structure_2']['building_2_usage_type'];
    _localproperty.snd_building_category =
        responseJson['building_structure_info']['building_structure_2']
            ['building_2_category'];
    _localproperty.snd_specifyif_other = responseJson['building_structure_info']
        ['building_structure_2']['building_2_cat_other'];
    _localproperty.snd_no_of_floors = responseJson['building_structure_info']
        ['building_structure_2']['building_2_floor_count'];
    _localproperty.snd_cubie_meter = responseJson['building_structure_info']
        ['building_structure_2']['building_2_volume'];
    _localproperty.trd_have_building = responseJson['building_structure_info']
        ['building_structure_3']['building_structure_3_presence'];
    _localproperty.trd_building_use = responseJson['building_structure_info']
        ['building_structure_3']['building_3_usage_type'];
    _localproperty.trd_building_category =
        responseJson['building_structure_info']['building_structure_3']
            ['building_3_category'];
    _localproperty.trd_specifyif_other = responseJson['building_structure_info']
        ['building_structure_3']['building_3_cat_other'];
    _localproperty.trd_no_of_floors = responseJson['building_structure_info']
        ['building_structure_3']['building_3_floor_count'];
    _localproperty.trd_cubie_meter = responseJson['building_structure_info']
        ['building_structure_3']['building_3_volume'];
    _localproperty.forth_have_building = responseJson['building_structure_info']
        ['building_structure_4']['building_structure_4_presence'];
    _localproperty.forth_building_use = responseJson['building_structure_info']
        ['building_structure_4']['building_4_usage_type'];
    _localproperty.forth_building_category =
        responseJson['building_structure_info']['building_structure_4']
            ['building_4_category'];
    _localproperty.forth_specifyif_other =
        responseJson['building_structure_info']['building_structure_4']
            ['building_4_cat_other'];
    _localproperty.forth_no_of_floors = responseJson['building_structure_info']
        ['building_structure_4']['building_4_floor_count'];
    _localproperty.forth_cubie_meter = responseJson['building_structure_info']
        ['building_structure_4']['building_4_volume'];
    _localproperty.fth_have_building = responseJson['building_structure_info']
        ['building_structure_5']['building_structure_5_presence'];
    _localproperty.fth_building_use = responseJson['building_structure_info']
        ['building_structure_5']['building_5_usage_type'];
    _localproperty.fth_building_category =
        responseJson['building_structure_info']['building_structure_5']
            ['building_5_category'];
    _localproperty.fth_specifyif_other = responseJson['building_structure_info']
        ['building_structure_5']['building_5_cat_other'];
    _localproperty.fth_no_of_floors = responseJson['building_structure_info']
        ['building_structure_5']['building_5_floor_count'];
    _localproperty.fth_cubie_meter = responseJson['building_structure_info']
        ['building_structure_5']['building_5_volume'];
    _localproperty.home_map = responseJson['Sketch'];
    _localproperty.home_photo = responseJson['HouseImage'];
    _localproperty.reg_property_fertilizer = responseJson['code'];
    _localproperty.area_unit_release_area =
        responseJson['Units_Info']['Residential_Area'];
    _localproperty.area_unit_business_area =
        responseJson['Units_Info']['Commercial_Area'];
    _localproperty.area_unit_total_no_unit =
        responseJson['Units_Info']['Total_Residential_Units'];
    _localproperty.area_unit_business_units =
        responseJson['Units_Info']['Total_Commercial_Units'];
    _localproperty.second_partner_name =
        responseJson['property_partners_information']['p2_name'];
    _localproperty.second_partner_surname =
        responseJson['property_partners_information']['p2_surname'];
    _localproperty.second_partner_boy =
        responseJson['property_partners_information']['p2_father_name'];
    _localproperty.second_partner_father =
        responseJson['property_partners_information']['p2_grand_father_name'];
    _localproperty.second_partner_gender =
        responseJson['property_partners_information']['p2_gender'];
    _localproperty.second_partner_phone =
        responseJson['property_partners_information']['p2_phone_no'];
    _localproperty.second_partner_email =
        responseJson['property_partners_information']['p2_email'];
    _localproperty.second_partner_image =
        responseJson['property_partners_information']['p2_photo'];
    _localproperty.second_partner_machinegun_no =
        responseJson['property_partners_information']['p2_tazkira_serial_no'];
    _localproperty.second_partner_cover_note =
        responseJson['property_partners_information']['p2_tazkira_volume_no'];
    _localproperty.second_partner_note_page =
        responseJson['property_partners_information']['p2_tazkira_page_no'];
    _localproperty.second_partner_reg_no =
        responseJson['property_partners_information']['p2_tazkira_reg_no'];
    _localproperty.second_partner_phote_note1 =
        responseJson['property_partners_information']['p2_tazkira_image_1'];
    _localproperty.second_partner_photo_tips1 =
        responseJson['property_partners_information']['p2_tazkira_image_2'];
    _localproperty.second_partner_photo_tips2 =
        responseJson['property_partners_information']['p2_tazkira_image_3'];
    _localproperty.third_partner_name =
        responseJson['property_partners_information'][''];
    _localproperty.third_partner_surname =
        responseJson['property_partners_information'][''];
    _localproperty.third_partner_boy =
        responseJson['property_partners_information'][''];
    _localproperty.third_partner_father =
        responseJson['property_partners_information'][''];
    _localproperty.third_partner_gender =
        responseJson['property_partners_information'][''];
    _localproperty.third_partner_phone =
        responseJson['property_partners_information'][''];
    _localproperty.third_partner_email =
        responseJson['property_partners_information'][''];
    _localproperty.third_partner_image =
        responseJson['property_partners_information'][''];
    _localproperty.third_partner_machinegun_no =
        responseJson['property_partners_information'][''];
    _localproperty.third_partner_cover_note =
        responseJson['property_partners_information'][''];
    _localproperty.third_partner_note_page =
        responseJson['property_partners_information'][''];
    _localproperty.third_partner_reg_no =
        responseJson['property_partners_information'][''];
    _localproperty.third_partner_phote_note1 =
        responseJson['property_partners_information'][''];
    _localproperty.third_partner_photo_tips1 =
        responseJson['property_partners_information'][''];
    _localproperty.third_partner_photo_tips2 =
        responseJson['property_partners_information'][''];
    _localproperty.fourth_partner_name =
        responseJson['property_partners_information'][''];
    _localproperty.fourth_partner_surname =
        responseJson['property_partners_information'][''];
    _localproperty.fourth_partner_boy =
        responseJson['property_partners_information'][''];
    _localproperty.fourth_partner_father =
        responseJson['property_partners_information'][''];
    _localproperty.fourth_partner_gender =
        responseJson['property_partners_information'][''];
    _localproperty.fourth_partner_phone =
        responseJson['property_partners_information'][''];
    _localproperty.fourth_partner_email =
        responseJson['property_partners_information'][''];
    _localproperty.fourth_partner_image =
        responseJson['property_partners_information'][''];
    _localproperty.fourth_partner_machinegun_no =
        responseJson['property_partners_information'][''];
    _localproperty.fourth_partner_cover_note =
        responseJson['property_partners_information'][''];
    _localproperty.fourth_partner_note_page =
        responseJson['property_partners_information'][''];
    _localproperty.fourth_partner_reg_no =
        responseJson['property_partners_information'][''];
    _localproperty.fourth_partner_phote_note1 =
        responseJson['property_partners_information'][''];
    _localproperty.fourth_partner_photo_tips1 =
        responseJson['property_partners_information'][''];
    _localproperty.fourth_partner_photo_tips2 =
        responseJson['property_partners_information'][''];
    _localproperty.fifth_partner_name =
        responseJson['property_partners_information'][''];
    _localproperty.fifth_partner_surname =
        responseJson['property_partners_information'][''];
    _localproperty.fifth_partner_boy =
        responseJson['property_partners_information'][''];
    _localproperty.fifth_partner_father =
        responseJson['property_partners_information'][''];
    _localproperty.fifth_partner_gender =
        responseJson['property_partners_information'][''];
    _localproperty.fifth_partner_phone =
        responseJson['property_partners_information'][''];
    _localproperty.fifth_partner_email =
        responseJson['property_partners_information'][''];
    _localproperty.fifth_partner_image =
        responseJson['property_partners_information'][''];
    _localproperty.fifth_partner_machinegun_no =
        responseJson['property_partners_information'][''];
    _localproperty.fifth_partner_cover_note =
        responseJson['property_partners_information'][''];
    _localproperty.fifth_partner_note_page =
        responseJson['property_partners_information'][''];
    _localproperty.fifth_partner_reg_no =
        responseJson['property_partners_information'][''];
    _localproperty.fifth_partner_phote_note1 =
        responseJson['property_partners_information'][''];
    _localproperty.fifth_partner_photo_tips1 =
        responseJson['property_partners_information'][''];
    _localproperty.fifth_partner_photo_tips2 =
        responseJson['property_partners_information'][''];
    _localproperty.formval = responseJson[''][''];
    _localproperty.editmode = responseJson[''][''];
    _localproperty.isdrafted = responseJson[''][''];
    _localproperty.boundaryinfonote =
        responseJson['property_boundaries_info']['boundary_note'];
    _localproperty.surveyenddate = responseJson[''][''];
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
