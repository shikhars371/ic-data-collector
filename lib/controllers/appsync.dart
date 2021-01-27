import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:catcher/catcher_plugin.dart';

import './auth.dart';
import '../models/localpropertydata.dart';
import '../configs/configuration.dart';
import '../utils/db_helper.dart';
import '../utils/appstate.dart';

typedef void OnUploadProgressCallback(int sentBytes, int totalBytes);

class AppSync with ChangeNotifier {
  bool isPropertyDataExistInOnlineDb = false;
  AppState _state = AppState.Idle;
  AppState get state => _state;
  void setState(AppState appState) {
    _state = appState;
    notifyListeners();
  }

  Future<bool> syncData({LocalPropertySurvey propertydata}) async {
    setState(AppState.Busy);
    bool result = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceuniqueid = "";
    try {
      var responce;
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceuniqueid = androidInfo.androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceuniqueid = iosInfo.identifierForVendor;
      }
      Map<String, dynamic> inputdata() => {
            "surveyors_info": {
              "surveyor_1": propertydata.first_surveyor_name,
              "surveyor_2": propertydata.senond_surveyor_name,
              "supporting_surveyor": propertydata.technical_support_name
            },
            "arguments_1": {
              "property_argument": propertydata.property_dispte_subject_to,
              "human_argument": propertydata.real_person_status,
              "tazkira_argument": propertydata.cityzenship_notice
            },
            "arguments_2": {
              "property_note": propertydata.issue_regarding_property,
              "municipality_reg_no": propertydata.municipality_ref_number,
              "property_endangerment": propertydata.natural_threaten
            },
            "property_physical_condition": {
              "planned_unplanned": propertydata.status_of_area_plan,
              "formal_informal": propertydata.status_of_area_official,
              "regular_irregular": propertydata.status_of_area_regular,
              "slope": propertydata.slope_of_area
            },
            "property_physical_location": {
              "province_id": propertydata.province,
              "municipality_id": propertydata.city,
              "nahia_id": propertydata.area,
              "guzar_id": propertydata.pass,
              "block_id": propertydata.block,
              "parcel_no": propertydata.part_number,
              "unit_no": propertydata.unit_number,
              "no_unit_in_parcel": propertydata.unit_in_parcel,
              "road_name": propertydata.street_name,
              "historical_value": propertydata.historic_site_area,
              "parcel_area": propertydata.land_area,
              "ownership_type": propertydata.property_type
            },
            "zones": propertydata.location_of_land_area,
            "doc_presence_state": propertydata.property_have_document,
            "document_type_info": propertydata.document_type,
            "govermental_doc_specification": {
              "doc_issue_date": propertydata.issued_on,
              "doc_issue_place": propertydata.place_of_issue,
              "property_reg_no": propertydata.property_number,
              "doc_volume_no": propertydata.document_cover,
              "doc_page_no": propertydata.document_page,
              "doc_reg_no": propertydata.doc_reg_number,
              "doc_property_area": propertydata.land_area_qawwala,
              "doc_img_1": propertydata.property_doc_photo_1?.isEmpty ?? true
                  ? ""
                  : (propertydata.property_doc_photo_1),
              "doc_img_2": propertydata.property_doc_photo_2?.isEmpty ?? true
                  ? ""
                  : basename(propertydata.property_doc_photo_2),
              "doc_img_3": propertydata.property_doc_photo_3?.isEmpty ?? true
                  ? ""
                  : basename(propertydata.property_doc_photo_3),
              "doc_img_4": propertydata.property_doc_photo_4?.isEmpty ?? true
                  ? ""
                  : basename(propertydata.property_doc_photo_4)
            },
            "local_doc_specification": {
              "local_doc_img_1":
                  propertydata.odinary_doc_photo1?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.odinary_doc_photo1),
              "local_doc_img_2":
                  propertydata.odinary_doc_photo6?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.odinary_doc_photo6)
            },
            "property_given_usage_type": propertydata.use_in_property_doc,
            "property_other_usage_type": propertydata.type_of_use_other,
            "property_current_usage_type": propertydata.current_use_of_property,
            "usage_rental": propertydata.redeemable_property,
            "usage_business": propertydata.proprietary_properties,
            "usage_govermental": propertydata.govt_property,
            "usage_other": propertydata.specified_current_use,
            "business_other_type": propertydata.unspecified_current_use_type,
            "business_licence": {
              "units_with_licence": propertydata.number_of_business_unit,
              "units_without_licence":
                  propertydata.business_unit_have_no_license,
              "other": propertydata.business_license_another
            },
            "owner_or_first_partner_info": {
              "name": propertydata.first_partner_name,
              "surname": propertydata.first_partner_surname,
              "father_name": propertydata.first_partner_boy,
              "grand_father_name": propertydata.first_partner__father,
              "gender": propertydata.first_partner_name_gender,
              "phone_no": propertydata.first_partner_name_phone,
              "emal": propertydata.first_partner_name_email,
              "photo_person": propertydata
                          .first_partner_name_property_owner?.isEmpty ??
                      true
                  ? ""
                  : basename(propertydata.first_partner_name_property_owner),
              "note_person": propertydata.first_partner_name_mere_individuals
            },
            "tazkira_information": {
              "tazkira_serial_no": propertydata.info_photo_hint_sukuk_number,
              "tazkira_volume_no": propertydata.info_photo_hint_cover_note,
              "tazkira_page_no": propertydata.info_photo_hint_note_page,
              "tazkira_reg_no": propertydata.info_photo_hint_reg_no,
              "tazkira_image_1":
                  propertydata.info_photo_hint_photo_note1?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.info_photo_hint_photo_note1),
              "tazkira_image_2":
                  propertydata.info_photo_hint_photo_tips1?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.info_photo_hint_photo_tips1),
              "tazkira_image_3":
                  propertydata.info_photo_hint_photo_tips2?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.info_photo_hint_photo_tips2)
            },
            "property_partners_information": {
              "second_partner_info": "",
              "p2_name": propertydata.second_partner_name,
              "p2_surname": propertydata.second_partner_surname,
              "p2_father_name": propertydata.second_partner_boy,
              "p2_grand_father_name": propertydata.second_partner_father,
              "p2_gender": propertydata.second_partner_gender,
              "p2_phone_no": propertydata.second_partner_phone,
              "p2_email": propertydata.second_partner_email,
              "p2_photo": propertydata.second_partner_image?.isEmpty ?? true
                  ? ""
                  : basename(propertydata.second_partner_image),
              "p2_tazkira_info": "",
              "p2_tazkira_serial_no": propertydata.second_partner_machinegun_no,
              "p2_tazkira_volume_no": propertydata.second_partner_cover_note,
              "p2_tazkira_page_no": propertydata.second_partner_note_page,
              "p2_tazkira_reg_no": propertydata.second_partner_reg_no,
              "p2_tazkira_image_1":
                  propertydata.second_partner_phote_note1?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.second_partner_phote_note1),
              "p2_tazkira_image_2":
                  propertydata.second_partner_photo_tips1?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.second_partner_photo_tips1),
              "p2_tazkira_image_3":
                  propertydata.second_partner_photo_tips2?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.second_partner_photo_tips2),
              "third_partner_info": "",
              "p3_name": propertydata.third_partner_name,
              "p3_surname": propertydata.third_partner_surname,
              "p3_father_name": propertydata.third_partner_boy,
              "p3_grand_father_name": propertydata.third_partner_father,
              "p3_gender": propertydata.third_partner_gender,
              "p3_phone_no": propertydata.third_partner_phone,
              "p3_email": propertydata.third_partner_email,
              "p3_photo": propertydata.third_partner_image?.isEmpty ?? true
                  ? ""
                  : basename(propertydata.third_partner_image),
              "p3_tazkira_info": "",
              "p3_tazkira_serial_no": propertydata.third_partner_machinegun_no,
              "p3_tazkira_volume_no": propertydata.third_partner_cover_note,
              "p3_tazkira_page_no": propertydata.third_partner_note_page,
              "p3_tazkira_reg_no": propertydata.third_partner_reg_no,
              "p3_tazkira_image_1":
                  propertydata.third_partner_phote_note1?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.third_partner_phote_note1),
              "p3_tazkira_image_2":
                  propertydata.third_partner_photo_tips1?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.third_partner_photo_tips1),
              "p3_tazkira_image_3":
                  propertydata.third_partner_photo_tips2?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.third_partner_photo_tips2),
              "fourth_partner_info": "",
              "p4_name": propertydata.fourth_partner_name,
              "p4_surname": propertydata.fourth_partner_surname,
              "p4_father_name": propertydata.fourth_partner_boy,
              "p4_grand_father_name": propertydata.fourth_partner_father,
              "p4_gender": propertydata.fourth_partner_gender,
              "p4_phone_no": propertydata.fourth_partner_phone,
              "p4_email": propertydata.fourth_partner_email,
              "p4_photo": propertydata.fourth_partner_image?.isEmpty ?? true
                  ? ""
                  : basename(propertydata.fourth_partner_image),
              "p4_tazkira_info": "",
              "p4_tazkira_serial_no": propertydata.fourth_partner_machinegun_no,
              "p4_tazkira_volume_no": propertydata.fourth_partner_cover_note,
              "p4_tazkira_page_no": propertydata.fourth_partner_note_page,
              "p4_tazkira_reg_no": propertydata.fourth_partner_reg_no,
              "p4_tazkira_image_1":
                  propertydata.fourth_partner_phote_note1?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.fourth_partner_phote_note1),
              "p4_tazkira_image_2":
                  propertydata.fourth_partner_photo_tips1?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.fourth_partner_photo_tips1),
              "p4_tazkira_image_3":
                  propertydata.fourth_partner_photo_tips2?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.fourth_partner_photo_tips2),
              "fifth_partner_info": "",
              "p5_name": propertydata.fifth_partner_name,
              "p5_surname": propertydata.fifth_partner_surname,
              "p5_father_name": propertydata.fifth_partner_boy,
              "p5_grand_father_name": propertydata.fifth_partner_father,
              "p5_gender": propertydata.fifth_partner_gender,
              "p5_phone_no": propertydata.fifth_partner_phone,
              "p5_email": propertydata.fifth_partner_email,
              "p5_photo": propertydata.fifth_partner_image?.isEmpty ?? true
                  ? ""
                  : basename(propertydata.fifth_partner_image),
              "p5_tazkira_info": "",
              "p5_tazkira_serial_no": propertydata.fifth_partner_machinegun_no,
              "p5_tazkira_volume_no": propertydata.fifth_partner_cover_note,
              "p5_tazkira_page_no": propertydata.fifth_partner_note_page,
              "p5_tazkira_reg_no": propertydata.fifth_partner_reg_no,
              "p5_tazkira_image_1":
                  propertydata.fifth_partner_phote_note1?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.fifth_partner_phote_note1),
              "p5_tazkira_image_2":
                  propertydata.fifth_partner_photo_tips1?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.fifth_partner_photo_tips1),
              "p5_tazkira_image_3":
                  propertydata.fifth_partner_photo_tips2?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.fifth_partner_photo_tips2),
              "partners_note": ""
            },
            "property_boundaries_info": {
              "boundary_note": propertydata.boundaryinfonote,
              "East": propertydata.fore_limits_east,
              "West": propertydata.fore_limits_west,
              "South": propertydata.fore_limits_south,
              "North": propertydata.fore_limits_north
            },
            "electricity_bill_info": {
              "meter_no": propertydata.lightning_meter_no,
              "customer_name": propertydata.lightning_common_name,
              "cuntomer_father_name": propertydata.lightning_father_name,
              "ebill_img":
                  propertydata.lightning_picture_bell_power?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.lightning_picture_bell_power)
            },
            "sanitation_booklet_info": {
              "cust_name": propertydata.safari_booklet_common_name,
              "cust_father_name": propertydata.safari_booklet_father_name,
              "sanitation_booklet_serial_no":
                  propertydata.safari_booklet_machinegun_no,
              "issue_date": propertydata.safari_booklet_issue_date,
              "sanitation_booklet_img":
                  propertydata.safari_booklet_picture?.isEmpty ?? true
                      ? ""
                      : basename(propertydata.safari_booklet_picture)
            },
            "property_user_info": {
              "owner_occupier": propertydata.property_user_owner,
              "rental_occupier": propertydata.property_user_master_rent,
              "mortagage_occupier": propertydata.property_user_recipient_group,
              "other_occupier": propertydata.property_user_no_longer
            },
            "other_occupier_type":
                propertydata.property_user_type_of_misconduct,
            "building_structure_info": {
              "building_structure_1": {
                "building_structure_1_presence": propertydata.fst_have_building,
                "building_1_usage_type": propertydata.fst_building_use,
                "building_1_category": propertydata.fst_building_category,
                "building_1_cat_other": propertydata.fst_specifyif_other,
                "building_1_floor_count": propertydata.fst_no_of_floors,
                "building_1_volume": propertydata.fst_cubie_meter
              },
              "building_structure_2": {
                "building_structure_2_presence": propertydata.snd_have_building,
                "building_2_usage_type": propertydata.snd_building_use,
                "building_2_category": propertydata.snd_building_category,
                "building_2_cat_other": propertydata.snd_specifyif_other,
                "building_2_floor_count": propertydata.snd_no_of_floors,
                "building_2_volume": propertydata.snd_cubie_meter
              },
              "building_structure_3": {
                "building_structure_3_presence": propertydata.trd_have_building,
                "building_3_usage_type": propertydata.trd_building_use,
                "building_3_category": propertydata.trd_building_category,
                "building_3_cat_other": propertydata.trd_specifyif_other,
                "building_3_floor_count": propertydata.trd_no_of_floors,
                "building_3_volume": propertydata.trd_cubie_meter
              },
              "building_structure_4": {
                "building_structure_4_presence":
                    propertydata.forth_have_building,
                "building_4_usage_type": propertydata.forth_building_use,
                "building_4_category": propertydata.forth_building_category,
                "building_4_cat_other": propertydata.forth_specifyif_other,
                "building_4_floor_count": propertydata.forth_no_of_floors,
                "building_4_volume": propertydata.forth_cubie_meter
              },
              "building_structure_5": {
                "building_structure_5_presence": propertydata.fth_have_building,
                "building_5_usage_type": propertydata.fth_building_use,
                "building_5_category": propertydata.fth_building_category,
                "building_5_cat_other": propertydata.fth_specifyif_other,
                "building_5_floor_count": propertydata.fth_no_of_floors,
                "building_5_volume": propertydata.fth_cubie_meter
              }
            },
            "Sketch": propertydata.home_map?.isEmpty ?? true
                ? ""
                : basename(propertydata.home_map),
            "HouseImage": propertydata.home_photo?.isEmpty ?? true
                ? ""
                : basename(propertydata.home_photo),
            "code": propertydata.reg_property_fertilizer,
            "Units_Info": {
              "Residential_Area": propertydata.area_unit_release_area,
              "Commercial_Area": propertydata.area_unit_business_area,
              "Total_Residential_Units": propertydata.area_unit_total_no_unit,
              "Total_Commercial_Units": propertydata.area_unit_business_units
            },
            "start": propertydata.local_created_on,
            "end": propertydata.surveyenddate,
            "Today": DateTime.now().toString(),
            "deviceid": deviceuniqueid,
            "meta": {
              "instanceID": "",
              "_id": propertydata.taskid,
              "_uuid": "",
              "_submission_time": "",
              "_index": "",
              "_parent_table_name": "",
              "_parent_index": "",
              "_tags": "",
              "_notes": ""
            },
            "importDate": "",
            "badHI": false,
            "badSK": false,
            "otherNote": "",
            "IsCompleted": false,
            "IsValidated": true,
            "IsFinalized": true,
            "Flag": false,
            "KMarea": false,
            "GISmap": "",
            "lan": "",
            "lon": "",
            "checker": "",
            "extra2": "SENT",
            "region": "",
            "key": "",
            "status": propertydata.other_key,
            "upin": propertydata.province +
                "-" +
                propertydata.area +
                "-" +
                propertydata.pass +
                "-" +
                propertydata.block +
                "-" +
                propertydata.part_number +
                "-" +
                propertydata.unit_number,
            "surveyor1_id": propertydata.surveyoroneid,
            "surveyor2_id": propertydata.surveyortwoid,
            "supporting_surveyor_id": propertydata.surveyleadid,
            "authority": "Survey Lead"
          };
      isPropertyDataExistInOnlineDb = await isPropertyExistInDataBase(
        propertyid: propertydata.province +
            "-" +
            propertydata.area +
            "-" +
            propertydata.pass +
            "-" +
            propertydata.block +
            "-" +
            propertydata.part_number +
            "-" +
            propertydata.unit_number,
      );
      //if data exist then patch otherwise insert
      if (isPropertyDataExistInOnlineDb) {
        ///if property survey assignment already exist
        ///isdrafted should be 3
        ///disable edit
        if ((propertydata.isrework == 0) || ((propertydata.isrework == null))) {
          propertydata.isdrafted = 3;
          await DBHelper().updatePropertySurvey(
              propertydata, propertydata.local_property_key);
          result = true;
        }

        ///if rework
        ///patch or update the property
        else {
          var propertyid = await getPropertyId(
            propertyid: propertydata.province +
                "-" +
                propertydata.area +
                "-" +
                propertydata.pass +
                "-" +
                propertydata.block +
                "-" +
                propertydata.part_number +
                "-" +
                propertydata.unit_number,
          );
          if (!(propertyid?.isEmpty ?? true)) {
            responce = await http.patch(
              Configuration.apiurl + "propertyinformation/$propertyid",
              body: json.encode(inputdata()),
              headers: {
                "Content-Type": "application/json",
                "Authorization": preferences.getString("accesstoken")
              },
            );
            await http.patch(
              Configuration.apiurl + "taskreassignment/${propertydata.taskid}",
              body: {"surveystatus": "close"},
              headers: {
                "Content-Type": "application/json",
                "Authorization": preferences.getString("accesstoken")
              },
            );
          }
        }
      } else {
        responce = await http.post(Configuration.apiurl + "propertyinformation",
            body: json.encode(inputdata()),
            headers: {
              "Content-Type": "application/json",
              "Authorization": preferences.getString("accesstoken")
            });
      }
      if (responce.statusCode == 201 ||
          responce.statusCode == 200 ||
          responce.statusCode == 202) {
        //success
        result = true;
        var res = await http.post(
            Configuration.apiurl + "propertyinformationlog",
            body: json.encode(inputdata()),
            headers: {
              "Content-Type": "application/json",
              "Authorization": preferences.getString("accesstoken")
            });
      } else if (responce.statusCode == 401) {
        AuthModel().generateRefreshToken().then((_) {
          syncData(propertydata: propertydata);
        });
      }
    } catch (error, stackTrace) {
      setState(AppState.Idle);
      Catcher.reportCheckedError(error, stackTrace);
    }
    setState(AppState.Idle);
    return result;
  }

  List<String> dataFileList({LocalPropertySurvey propertydata}) {
    List<String> avaiblefiles = [];
    try {
      if (propertydata.isreldocphoto1 == 1) {
        avaiblefiles.add(propertydata.property_doc_photo_1);
      }
      if (propertydata.isreldocphoto2 == 1) {
        avaiblefiles.add(propertydata.property_doc_photo_2);
      }
      if (propertydata.isreldocphoto3 == 1) {
        avaiblefiles.add(propertydata.property_doc_photo_3);
      }
      if (propertydata.isreldocphoto4 == 1) {
        avaiblefiles.add(propertydata.property_doc_photo_4);
      }
      if (propertydata.isoddocphoto1 == 1) {
        avaiblefiles.add(propertydata.odinary_doc_photo1);
      }
      if (propertydata.isoddocphoto6 == 1) {
        avaiblefiles.add(propertydata.odinary_doc_photo6);
      }
      if (propertydata.isfirstpartner_photo == 1) {
        avaiblefiles.add(propertydata.first_partner_name_property_owner);
      }
      if (propertydata.isinfophotonote1 == 1) {
        avaiblefiles.add(propertydata.info_photo_hint_photo_note1);
      }
      if (propertydata.isinfophototips1 == 1) {
        avaiblefiles.add(propertydata.info_photo_hint_photo_tips1);
      }
      if (propertydata.isinfophototips2 == 1) {
        avaiblefiles.add(propertydata.info_photo_hint_photo_tips2);
      }
      if (propertydata.issecond_partner_photo == 1) {
        avaiblefiles.add(propertydata.second_partner_image);
      }
      if (propertydata.issecond_partner_photo_note1 == 1) {
        avaiblefiles.add(propertydata.second_partner_phote_note1);
      }
      if (propertydata.issecond_partner_photo_tips1 == 1) {
        avaiblefiles.add(propertydata.second_partner_photo_tips1);
      }
      if (propertydata.issecond_partner_photo_tips2 == 1) {
        avaiblefiles.add(propertydata.second_partner_photo_tips2);
      }
      if (propertydata.isthird_partner_photo == 1) {
        avaiblefiles.add(propertydata.third_partner_image);
      }
      if (propertydata.isthird_partner_photo_note1 == 1) {
        avaiblefiles.add(propertydata.third_partner_phote_note1);
      }
      if (propertydata.isthird_partner_photo_tips1 == 1) {
        avaiblefiles.add(propertydata.third_partner_photo_tips1);
      }
      if (propertydata.isthird_partner_photo_tips2 == 1) {
        avaiblefiles.add(propertydata.third_partner_photo_tips2);
      }
      if (propertydata.isfourth_partner_photo == 1) {
        avaiblefiles.add(propertydata.fourth_partner_image);
      }
      if (propertydata.isfourth_partner_photo_note1 == 1) {
        avaiblefiles.add(propertydata.fourth_partner_phote_note1);
      }
      if (propertydata.isfourth_partner_photo_tips1 == 1) {
        avaiblefiles.add(propertydata.fourth_partner_photo_tips1);
      }
      if (propertydata.isfourth_partner_photo_tips2 == 1) {
        avaiblefiles.add(propertydata.fourth_partner_photo_tips2);
      }
      if (propertydata.isfifth_partner_photo == 1) {
        avaiblefiles.add(propertydata.fifth_partner_image);
      }
      if (propertydata.isfifth_partner_photo_note1 == 1) {
        avaiblefiles.add(propertydata.fifth_partner_phote_note1);
      }
      if (propertydata.isfifth_partner_photo_tips1 == 1) {
        avaiblefiles.add(propertydata.fifth_partner_photo_tips1);
      }
      if (propertydata.isfifth_partner_photo_tips2 == 1) {
        avaiblefiles.add(propertydata.fifth_partner_photo_tips2);
      }
      if (propertydata.ismeter_pic_bill_power == 1) {
        avaiblefiles.add(propertydata.lightning_picture_bell_power);
      }
      if (propertydata.issafari_booklet_pic == 1) {
        avaiblefiles.add(propertydata.safari_booklet_picture);
      }
      if (propertydata.ishome_sketch_map == 1) {
        avaiblefiles.add(propertydata.home_map);
      }
      if (propertydata.ishome_photo == 1) {
        avaiblefiles.add(propertydata.home_photo);
      }
    } catch (error, stackTrace) {
      Catcher.reportCheckedError(error, stackTrace);
    }
    return avaiblefiles;
  }

  Future<bool> fileUpload(
      {LocalPropertySurvey propertydata,
      OnUploadProgressCallback uploadpreogress}) async {
    bool result = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      Response<dynamic> responce;
      var dio = Dio();
      final url = Configuration.apiurl + "surveydata";
      Options options = new Options(
        headers: {
          "Authorization": preferences.getString("accesstoken"),
        },
      );
      List<String> data = dataFileList(propertydata: propertydata);
      if (!(data?.isEmpty ?? true)) {
        for (var item in data) {
          if (!(item?.isEmpty ?? true)) {
            var f = FormData.fromMap({
              "files":
                  await MultipartFile.fromFile(item, filename: basename(item)),
            });
            responce = await dio.post(url, options: options, data: f,
                onSendProgress: (sent, total) {
              uploadpreogress(sent, total);
            });
            if (!(responce.statusCode == 201)) {
              break;
            } else if (responce.statusCode == 401) {
              //unauthorized
              AuthModel().generateRefreshToken().then((_) {
                fileUpload(
                    propertydata: propertydata,
                    uploadpreogress: uploadpreogress);
              });
            }
          }
        }
        if (responce.statusCode == 201) {
          //data uploaded
          await updateUploadstatus(propertydata: propertydata);
          result = await syncData(propertydata: propertydata);
          propertydata.isdrafted = isPropertyDataExistInOnlineDb ? 3 : 2;
          await updateUploadstatus(propertydata: propertydata);
        }
      } else {
        result = await syncData(propertydata: propertydata);
        propertydata.isdrafted = isPropertyDataExistInOnlineDb ? 3 : 2;
        await updateUploadstatus(propertydata: propertydata);
      }
    } catch (error, stackTrace) {
      Catcher.reportCheckedError(error, stackTrace);
    }
    return result;
  }

  Future<bool> validateUserData({String taskid}) async {
    setState(AppState.Busy);
    bool result = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      if (!(taskid?.isEmpty ?? true)) {
        var responce = await http
            .get(Configuration.apiurl + "taskassignment/$taskid", headers: {
          "Content-Type": "application/json",
          "Authorization": preferences.getString("accesstoken")
        });
        if (responce.statusCode == 200) {
          if (json.decode(responce.body)['active_status'].toString() == "0") {
            String surveyor1 = json.decode(responce.body)['surveyor_1'];
            String surveyor2 = json.decode(responce.body)['surveyor_2'];
            if ((surveyor1 == preferences.getString('userid')) ||
                (surveyor2 == preferences.getString('userid'))) {
              result = true;
            }
          }
        } else if (responce.statusCode == 401) {
          AuthModel().generateRefreshToken().then((_) {
            validateUserData(taskid: taskid);
          });
        }
      }
    } catch (error, stackTrace) {
      Catcher.reportCheckedError(error, stackTrace);
    }
    setState(AppState.Idle);
    return result;
  }

  //return treue if value exist
  Future<bool> isPropertyExistInDataBase({String propertyid}) async {
    setState(AppState.Busy);
    bool result = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      if (!(propertyid?.isEmpty ?? true)) {
        var responce = await http.get(
            Configuration.apiurl + "propertyinformation?upin=$propertyid",
            headers: {
              "Content-Type": "application/json",
              "Authorization": preferences.getString("accesstoken")
            });
        if (responce.statusCode == 200) {
          result =
              int.tryParse(json.decode(responce.body)['total'].toString()) == 0
                  ? false
                  : true;
        } else if (responce.statusCode == 401) {
          AuthModel().generateRefreshToken().then((_) {
            isPropertyExistInDataBase(propertyid: propertyid);
          });
        }
      }
    } catch (error, stackTrace) {
      Catcher.reportCheckedError(error, stackTrace);
    }
    setState(AppState.Idle);
    return result;
  }

  Future<String> getPropertyId({String propertyid}) async {
    setState(AppState.Busy);
    String result = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      if (!(propertyid?.isEmpty ?? true)) {
        var responce = await http.get(
            Configuration.apiurl + "propertyinformation?upin=$propertyid",
            headers: {
              "Content-Type": "application/json",
              "Authorization": preferences.getString("accesstoken")
            });
        if (responce.statusCode == 200) {
          result = json.decode(responce.body)['data'][0]['_id'].toString();
        } else if (responce.statusCode == 401) {
          AuthModel().generateRefreshToken().then((_) {
            isPropertyExistInDataBase(propertyid: propertyid);
          });
        }
      }
    } catch (error, stackTrace) {
      Catcher.reportCheckedError(error, stackTrace);
    }
    return result;
  }

  Future<void> updateUploadstatus({LocalPropertySurvey propertydata}) async {
    try {
      LocalPropertySurvey datatodb = propertydata;
      if (propertydata.isreldocphoto1 == 1) {
        datatodb.isreldocphoto1 = 2;
      }
      if (propertydata.isreldocphoto2 == 1) {
        datatodb.isreldocphoto2 = 2;
      }
      if (propertydata.isreldocphoto3 == 1) {
        datatodb.isreldocphoto3 = 2;
      }
      if (propertydata.isreldocphoto4 == 1) {
        datatodb.isreldocphoto4 = 2;
      }
      if (propertydata.isoddocphoto1 == 1) {
        datatodb.isoddocphoto1 = 2;
      }
      if (propertydata.isoddocphoto6 == 1) {
        datatodb.isoddocphoto6 = 2;
      }
      if (propertydata.isfirstpartner_photo == 1) {
        datatodb.isfirstpartner_photo = 2;
      }
      if (propertydata.isinfophotonote1 == 1) {
        datatodb.isinfophotonote1 = 2;
      }
      if (propertydata.isinfophototips1 == 1) {
        datatodb.isinfophototips1 = 2;
      }
      if (propertydata.isinfophototips2 == 1) {
        datatodb.isinfophototips2 = 2;
      }
      if (propertydata.issecond_partner_photo == 1) {
        datatodb.issecond_partner_photo = 2;
      }
      if (propertydata.issecond_partner_photo_note1 == 1) {
        datatodb.issecond_partner_photo_note1 = 2;
      }
      if (propertydata.issecond_partner_photo_tips1 == 1) {
        datatodb.issecond_partner_photo_tips1 = 2;
      }
      if (propertydata.issecond_partner_photo_tips2 == 1) {
        datatodb.issecond_partner_photo_tips2 = 2;
      }
      if (propertydata.isthird_partner_photo == 1) {
        datatodb.isthird_partner_photo = 2;
      }
      if (propertydata.isthird_partner_photo_note1 == 1) {
        datatodb.isthird_partner_photo_note1 = 2;
      }
      if (propertydata.isthird_partner_photo_tips1 == 1) {
        datatodb.isthird_partner_photo_tips1 = 2;
      }
      if (propertydata.isthird_partner_photo_tips2 == 1) {
        datatodb.isthird_partner_photo_tips2 = 2;
      }
      if (propertydata.isfourth_partner_photo == 1) {
        datatodb.isfourth_partner_photo = 2;
      }
      if (propertydata.isfourth_partner_photo_note1 == 1) {
        datatodb.isfourth_partner_photo_note1 = 2;
      }
      if (propertydata.isfourth_partner_photo_tips1 == 1) {
        datatodb.isfourth_partner_photo_tips1 = 2;
      }
      if (propertydata.isfourth_partner_photo_tips2 == 1) {
        datatodb.isfourth_partner_photo_tips2 = 2;
      }
      if (propertydata.isfifth_partner_photo == 1) {
        datatodb.isfifth_partner_photo = 2;
      }
      if (propertydata.isfifth_partner_photo_note1 == 1) {
        datatodb.isfifth_partner_photo_note1 = 2;
      }
      if (propertydata.isfifth_partner_photo_tips1 == 1) {
        datatodb.isfifth_partner_photo_tips1 = 2;
      }
      if (propertydata.isfifth_partner_photo_tips2 == 1) {
        datatodb.isfifth_partner_photo_tips2 = 2;
      }
      if (propertydata.ismeter_pic_bill_power == 1) {
        datatodb.ismeter_pic_bill_power = 2;
      }
      if (propertydata.issafari_booklet_pic == 1) {
        datatodb.issafari_booklet_pic = 2;
      }
      if (propertydata.ishome_sketch_map == 1) {
        datatodb.ishome_sketch_map = 2;
      }
      if (propertydata.ishome_photo == 1) {
        datatodb.ishome_photo = 2;
      }
      await DBHelper()
          .updatePropertySurvey(datatodb, datatodb.local_property_key);
    } catch (error, stackTrace) {
      Catcher.reportCheckedError(error, stackTrace);
    }
  }
}
