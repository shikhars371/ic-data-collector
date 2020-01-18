import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/surveyAssignment.dart';
import '../controllers/auth.dart';
import '../models/localpropertydata.dart';

class DBHelper with ChangeNotifier {
  AppState _state = AppState.Idle;
  AppState get state => _state;
  void setState(AppState appState) {
    _state = appState;
    notifyListeners();
  }

  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'kettle.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE IF NOT EXISTS surveylist (
          id TEXT PRIMARY KEY UNIQUE,
          uid TEXT ,assignedby TEXT,assignedto TEXT, provinceid TEXT,
          municpalityid TEXT, nahiaid TEXT,gozarid TEXT,blockid TEXT,
          startdate TEXT,propertytosurvey INTEGER,propertysurveyed INTEGER,
          propertyverified INTEGER, propertygeoverified INTEGER,
          completiondate TEXT,completionstatus TEXT,approvestatus INTEGER,
          createdby TEXT,updatedby TEXT,ip TEXT,isdeleted INTEGER DEFAULT 0,
          issynced INTEGER DEFAULT 0,iscompleted INTEGER DEFAULT 0,isstatrted INTEGER DEFAULT 0
        )
        ''').catchError((onError) {
      print(onError);
    });
    await db.execute('''
      CREATE TABLE IF NOT EXISTS propertysurvey(
        id INTEGER PRIMARY KEY AUTOINCREMENT,taskid TEXT,
        local_created_on TEXT DEFAULT CURRENT_TIMESTAMP,
        local_property_key TEXT,other_key TEXT,
        first_surveyor_name TEXT,senond_surveyor_name TEXT,
        technical_support_name TEXT,property_dispte_subject_to TEXT,
        real_person_status TEXT,cityzenship_notice TEXT,issue_regarding_property TEXT,
        municipality_ref_number TEXT,natural_threaten TEXT,
        status_of_area_plan TEXT,status_of_area_official TEXT,
        status_of_area_regular TEXT,slope_of_area TEXT,province TEXT,
        city TEXT,area TEXT,pass TEXT,block TEXT,part_number TEXT,
        unit_number TEXT,unit_in_parcel TEXT,street_name TEXT,
        historic_site_area TEXT,land_area TEXT,property_type TEXT,
        location_of_land_area TEXT,property_have_document TEXT,
        document_type TEXT,issued_on TEXT,place_of_issue TEXT,
        property_number TEXT,document_cover TEXT,document_page TEXT,
        doc_reg_number TEXT,land_area_qawwala TEXT,property_doc_photo_1 TEXT,
        property_doc_photo_2 TEXT,property_doc_photo_3 TEXT,
        property_doc_photo_4 TEXT,odinary_doc_photo1 TEXT,odinary_doc_photo6 TEXT,
        use_in_property_doc TEXT,current_use_of_property TEXT,
        redeemable_property TEXT,proprietary_properties TEXT,
        govt_property TEXT,specified_current_use TEXT,unspecified_current_use_type TEXT,
        number_of_business_unit TEXT,business_unit_have_no_license TEXT,business_license_another TEXT,
        first_partner_name TEXT,first_partner_surname TEXT,first_partner_boy TEXT,
        first_partner__father TEXT,first_partner_name_gender TEXT,
        first_partner_name_phone TEXT,first_partner_name_email TEXT,
        first_partner_name_property_owner TEXT,first_partner_name_mere_individuals TEXT,
        info_photo_hint_sukuk_number TEXT,info_photo_hint_cover_note TEXT,
        info_photo_hint_note_page TEXT,info_photo_hint_reg_no TEXT,
        info_photo_hint_photo_note1 TEXT,info_photo_hint_photo_tips1 TEXT,
        info_photo_hint_photo_tips2 TEXT,fore_limits_east TEXT,fore_limits_west TEXT,
        fore_limits_south TEXT,fore_limits_north TEXT,lightning_meter_no TEXT,
        lightning_common_name TEXT,lightning_father_name TEXT,
        lightning_picture_bell_power TEXT,safari_booklet_common_name TEXT,
        safari_booklet_father_name TEXT,safari_booklet_machinegun_no TEXT,
        safari_booklet_issue_date TEXT,safari_booklet_picture TEXT,property_user_owner TEXT,
        property_user_master_rent TEXT,property_user_recipient_group TEXT,
        property_user_no_longer TEXT,property_user_type_of_misconduct TEXT,
        fst_have_building TEXT,fst_building_use TEXT,fst_building_category TEXT,
        fst_specifyif_other TEXT,fst_no_of_floors TEXT,fst_cubie_meter TEXT,
        snd_have_building TEXT,snd_building_use TEXT,snd_building_category TEXT,
        snd_specifyif_other TEXT,snd_no_of_floors TEXT,snd_cubie_meter TEXT,
        trd_have_building TEXT,trd_building_use TEXT,trd_building_category TEXT,
        trd_specifyif_other TEXT,trd_no_of_floors TEXT,trd_cubie_meter TEXT,
        forth_have_building TEXT,forth_building_use TEXT,forth_building_category TEXT,forth_specifyif_other TEXT,
        forth_no_of_floors TEXT,forth_cubie_meter TEXT,fth_have_building TEXT,fth_building_use TEXT,
        fth_building_category TEXT,fth_specifyif_other TEXT,fth_no_of_floors TEXT,
        fth_cubie_meter TEXT,home_map TEXT,home_photo TEXT,reg_property_fertilizer TEXT,
        area_unit_release_area TEXT,area_unit_business_area TEXT,area_unit_total_no_unit TEXT,
        area_unit_business_units TEXT
      )
    ''').catchError((onError) {
      print(onError);
    });
  }

  Future<int> addSurveyList({List<SurveyAssignment> surveyAssignments}) async {
    int result = 0;
    try {
      var dbClient = await db;
      for (var item in surveyAssignments) {
        bool check = await isExist(id: item.id);
        if (!check) {
          String sqlquery = '''
          INSERT INTO surveylist(id,uid,assignedby,assignedto,provinceid,
          municpalityid,nahiaid,gozarid,blockid,startdate,propertytosurvey,
          propertysurveyed,propertyverified,propertygeoverified,
          completiondate,completionstatus,approvestatus,createdby,updatedby,
          ip)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);
        ''';
          List<dynamic> params = [
            item.id,
            item.uid,
            item.assignedBy,
            item.assignedTo,
            item.provinceId,
            item.municpalityId,
            item.nahiaId,
            item.gozarId,
            item.blockId,
            item.startDate,
            int.tryParse(item.propertyToSurvey.toString()),
            int.tryParse(item.propertySurveyed.toString()),
            int.tryParse(item.propertyVerified.toString()),
            int.tryParse(item.propertyGeoverified.toString()),
            item.completionDate,
            item.completionStatus,
            item.approveStatus,
            item.createdBy,
            item.updatedBy,
            item.ip
          ];
          result = await dbClient.rawInsert(sqlquery, params);
        }
      }
    } catch (e) {
      print("addsurveylist db error:" + e);
    }
    return result;
  }

  Future<bool> isExist({String id}) async {
    bool result = false;
    try {
      var dbClient = await db;
      List<String> idvalues = [];
      List<Map> maps = await dbClient.rawQuery("SELECT id FROM surveylist");
      for (var item in maps) {
        idvalues.add(item['id']);
      }
      result = idvalues.contains(id);
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<List<SurveyAssignment>> getSurveys() async {
    List<SurveyAssignment> surveys = [];
    try {
      var dbClient = await db;
      List<Map> maps =
          await dbClient.rawQuery('select * from surveylist where isdeleted=0');
      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          surveys.add(
            SurveyAssignment(
              id: maps[i]['id'],
              uid: maps[i]['uid'],
              assignedBy: maps[i]['assignedby'],
              assignedTo: maps[i]['assignedto'],
              provinceId: maps[i]['provinceid'],
              municpalityId: maps[i]['municpalityid'],
              nahiaId: maps[i]['nahiaid'],
              gozarId: maps[i]['gozarid'],
              blockId: maps[i]['blockid'],
              startDate: maps[i]['startdate'],
              propertyToSurvey:
                  int.tryParse(maps[i]['propertytosurvey'].toString()),
              propertySurveyed:
                  int.tryParse(maps[i]['propertysurveyed'].toString()),
              propertyVerified:
                  int.tryParse(maps[i]['propertyverified'].toString()),
              propertyGeoverified:
                  int.tryParse(maps[i]['propertygeoverified'].toString()),
              completionDate: maps[i]['completiondate'],
              completionStatus:
                  maps[i]['completionstatus'] == null ? false : true,
              approveStatus: int.tryParse(maps[i]['approvestatus'].toString()),
              createdBy: maps[i]['createdby'],
              updatedBy: maps[i]['updatedby'],
              ip: maps[i]['ip'],
              isdeleted: maps[i]['isdeleted'],
              issynced: maps[i]['issynced'],
              iscompleted: maps[i]['iscompleted'],
              isstatrted: maps[i]['isstatrted'],
            ),
          );
        }
      }
    } catch (e) {
      print(e);
    }
    return surveys;
  }

  Future<int> addPropertySurvey(LocalPropertySurvey data) async { 
    int result = 0;
    try {

    } catch (e) {
      print(e);
    }
    return result;
  }
  // Future<int> delete(int id) async {
  //   var dbClient = await db;
  //   return await dbClient.delete(
  //     'student',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }

  // Future<int> update(Student student) async {
  //   var dbClient = await db;
  //   return await dbClient.update(
  //     'student',
  //     student.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [student.id],
  //   );
  // }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
