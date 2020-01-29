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

  List<LocalPropertySurvey> _propertysurveys = [];
  List<LocalPropertySurvey> get propertysurveys => _propertysurveys;

  LocalPropertySurvey _singlepropertysurveys = new LocalPropertySurvey();
  LocalPropertySurvey get singlepropertysurveys => _singlepropertysurveys;

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
          id TEXT PRIMARY KEY UNIQUE,province TEXT,
          municpality TEXT, nahia TEXT,gozar TEXT,propertytosurvey INTEGER,
          startdate TEXT,duedate TEXT,isdeleted INTEGER DEFAULT 0,
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
        area_unit_business_units TEXT, second_partner_name TEXT,second_partner_surname TEXT,
        second_partner_boy TEXT,second_partner_father TEXT,second_partner_gender TEXT,
        second_partner_phone TEXT,second_partner_email TEXT,second_partner_image TEXT,
        second_partner_machinegun_no TEXT,second_partner_cover_note TEXT,
        second_partner_note_page TEXT,second_partner_reg_no TEXT,second_partner_phote_note1 TEXT,
        second_partner_photo_tips1 TEXT,second_partner_photo_tips2 TEXT,
        third_partner_name TEXT,third_partner_surname TEXT,third_partner_boy TEXT,third_partner_father TEXT,
        third_partner_gender TEXT,third_partner_phone TEXT,third_partner_email TEXT,
        third_partner_image TEXT,third_partner_machinegun_no TEXT,third_partner_cover_note TEXT,
        third_partner_note_page TEXT,third_partner_reg_no TEXT,third_partner_phote_note1 TEXT,
        third_partner_photo_tips1 TEXT,third_partner_photo_tips2 TEXT,fourth_partner_name TEXT,
        fourth_partner_surname TEXT,fourth_partner_boy TEXT,fourth_partner_father TEXT,fourth_partner_gender TEXT,fourth_partner_phone TEXT,
        fourth_partner_email TEXT,fourth_partner_image TEXT,fourth_partner_machinegun_no TEXT,
        fourth_partner_cover_note TEXT,fourth_partner_note_page TEXT,fourth_partner_reg_no TEXT,
        fourth_partner_phote_note1 TEXT,fourth_partner_photo_tips1 TEXT,fourth_partner_photo_tips2 TEXT,
        fifth_partner_name TEXT,fifth_partner_surname TEXT,fifth_partner_boy TEXT,fifth_partner_father TEXT,fifth_partner_gender TEXT,fifth_partner_phone TEXT,
        fifth_partner_email TEXT,fifth_partner_image TEXT,fifth_partner_machinegun_no TEXT,fifth_partner_cover_note TEXT,
        fifth_partner_note_page TEXT,fifth_partner_reg_no TEXT,fifth_partner_phote_note1 TEXT,
        fifth_partner_photo_tips1 TEXT,fifth_partner_photo_tips2 TEXT,formval INTEGER,editmode INTEGER
      )
    ''').catchError((onError) {
      print(onError);
    });
    await db.execute('''
      CREATE TABLE IF NOT EXISTS applanguage(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        language TEXT
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
          INSERT INTO surveylist(id,province,municpality,nahia,gozar,propertytosurvey,
          startdate,duedate)VALUES(?,?,?,?,?,?,?,?);
        ''';
          List<dynamic> params = [
            item.id,
            item.province,
            item.municpality,
            item.nahia,
            item.gozar,
            item.property_to_survey,
            item.startDate,
            item.due_date
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
                province: maps[i]['province'],
                municpality: maps[i]['municpality'],
                nahia: maps[i]['nahia'],
                gozar: maps[i]['gozar'],
                property_to_survey: maps[i]['propertytosurvey'],
                startDate: maps[i]['startdate'],
                due_date: maps[i]['duedate'],
                isdeleted: maps[i]['isdeleted'],
                iscompleted: maps[i]['iscompleted'],
                isstatrted: maps[i]['isstatrted'],
                issynced: maps[i]['issynced']),
          );
        }
      }
    } catch (e) {
      print(e);
    }
    return surveys;
  }

  Future<int> addPropertySurvey(LocalPropertySurvey data) async {
    setState(AppState.Busy);
    notifyListeners();
    int result = 0;
    try {
      var dbClient = await db;
      String sqlquery = '''
        INSERT INTO propertysurvey(taskid,
        local_property_key,other_key,first_surveyor_name,senond_surveyor_name,
        technical_support_name,property_dispte_subject_to,
        real_person_status,cityzenship_notice,issue_regarding_property,
        municipality_ref_number,natural_threaten,status_of_area_plan,status_of_area_official,
        status_of_area_regular,slope_of_area,province,city,area,pass,block,part_number,
        unit_number,unit_in_parcel,street_name,historic_site_area,land_area,property_type,
        location_of_land_area,property_have_document,document_type,issued_on,place_of_issue,
        property_number,document_cover,document_page,doc_reg_number,land_area_qawwala,property_doc_photo_1,
        property_doc_photo_2,property_doc_photo_3,property_doc_photo_4,odinary_doc_photo1,odinary_doc_photo6,
        use_in_property_doc,current_use_of_property,redeemable_property,proprietary_properties,
        govt_property,specified_current_use,unspecified_current_use_type,
        number_of_business_unit,business_unit_have_no_license,business_license_another,
        first_partner_name,first_partner_surname,first_partner_boy,
        first_partner__father,first_partner_name_gender,
        first_partner_name_phone,first_partner_name_email,
        first_partner_name_property_owner,first_partner_name_mere_individuals,
        info_photo_hint_sukuk_number,info_photo_hint_cover_note,
        info_photo_hint_note_page,info_photo_hint_reg_no,
        info_photo_hint_photo_note1,info_photo_hint_photo_tips1,
        info_photo_hint_photo_tips2,fore_limits_east,fore_limits_west,
        fore_limits_south,fore_limits_north,lightning_meter_no,
        lightning_common_name,lightning_father_name,
        lightning_picture_bell_power,safari_booklet_common_name,
        safari_booklet_father_name,safari_booklet_machinegun_no,
        safari_booklet_issue_date,safari_booklet_picture,property_user_owner,
        property_user_master_rent,property_user_recipient_group,
        property_user_no_longer,property_user_type_of_misconduct,
        fst_have_building,fst_building_use,fst_building_category,
        fst_specifyif_other,fst_no_of_floors,fst_cubie_meter,
        snd_have_building,snd_building_use,snd_building_category,
        snd_specifyif_other,snd_no_of_floors,snd_cubie_meter,
        trd_have_building,trd_building_use,trd_building_category,
        trd_specifyif_other,trd_no_of_floors,trd_cubie_meter,
        forth_have_building,forth_building_use,forth_building_category,forth_specifyif_other,
        forth_no_of_floors,forth_cubie_meter,fth_have_building,fth_building_use,
        fth_building_category,fth_specifyif_other,fth_no_of_floors,
        fth_cubie_meter,home_map,home_photo,reg_property_fertilizer,
        area_unit_release_area,area_unit_business_area,area_unit_total_no_unit,
        area_unit_business_units, second_partner_name,second_partner_surname,
        second_partner_boy,second_partner_father,second_partner_gender,
        second_partner_phone,second_partner_email,second_partner_image,
        second_partner_machinegun_no,second_partner_cover_note,
        second_partner_note_page,second_partner_reg_no,second_partner_phote_note1,
        second_partner_photo_tips1,second_partner_photo_tips2,
        third_partner_name,third_partner_surname,third_partner_boy,third_partner_father,
        third_partner_gender,third_partner_phone,third_partner_email,
        third_partner_image,third_partner_machinegun_no,third_partner_cover_note,
        third_partner_note_page,third_partner_reg_no,third_partner_phote_note1,
        third_partner_photo_tips1,third_partner_photo_tips2,fourth_partner_name,
        fourth_partner_surname,fourth_partner_boy,fourth_partner_father,fourth_partner_gender,fourth_partner_phone,
        fourth_partner_email,fourth_partner_image,fourth_partner_machinegun_no,
        fourth_partner_cover_note,fourth_partner_note_page,fourth_partner_reg_no,
        fourth_partner_phote_note1,fourth_partner_photo_tips1,fourth_partner_photo_tips2,
        fifth_partner_name,fifth_partner_surname,fifth_partner_boy,fifth_partner_father,fifth_partner_gender,fifth_partner_phone,
        fifth_partner_email,fifth_partner_image,fifth_partner_machinegun_no,fifth_partner_cover_note,
        fifth_partner_note_page,fifth_partner_reg_no,fifth_partner_phote_note1,
        fifth_partner_photo_tips1,fifth_partner_photo_tips2,formval,editmode)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,
        ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,
        ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,
        ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,
        ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
      ''';
      List<dynamic> params = [
        data.taskid,
        data.local_property_key,
        data.other_key,
        data.first_surveyor_name,
        data.senond_surveyor_name,
        data.technical_support_name,
        data.property_dispte_subject_to,
        data.real_person_status,
        data.cityzenship_notice,
        data.issue_regarding_property,
        data.municipality_ref_number,
        data.natural_threaten,
        data.status_of_area_plan,
        data.status_of_area_official,
        data.status_of_area_regular,
        data.slope_of_area,
        data.province,
        data.city,
        data.area,
        data.pass,
        data.block,
        data.part_number,
        data.unit_number,
        data.unit_in_parcel,
        data.street_name,
        data.historic_site_area,
        data.land_area,
        data.property_type,
        data.location_of_land_area,
        data.property_have_document,
        data.document_type,
        data.issued_on,
        data.place_of_issue,
        data.property_number,
        data.document_cover,
        data.document_page,
        data.doc_reg_number,
        data.land_area_qawwala,
        data.property_doc_photo_1,
        data.property_doc_photo_2,
        data.property_doc_photo_3,
        data.property_doc_photo_4,
        data.odinary_doc_photo1,
        data.odinary_doc_photo6,
        data.use_in_property_doc,
        data.current_use_of_property,
        data.redeemable_property,
        data.proprietary_properties,
        data.govt_property,
        data.specified_current_use,
        data.unspecified_current_use_type,
        data.number_of_business_unit,
        data.business_unit_have_no_license,
        data.business_license_another,
        data.first_partner_name,
        data.first_partner_surname,
        data.first_partner_boy,
        data.first_partner__father,
        data.first_partner_name_gender,
        data.first_partner_name_phone,
        data.first_partner_name_email,
        data.first_partner_name_property_owner,
        data.first_partner_name_mere_individuals,
        data.info_photo_hint_sukuk_number,
        data.info_photo_hint_cover_note,
        data.info_photo_hint_note_page,
        data.info_photo_hint_reg_no,
        data.info_photo_hint_photo_note1,
        data.info_photo_hint_photo_tips1,
        data.info_photo_hint_photo_tips2,
        data.fore_limits_east,
        data.fore_limits_west,
        data.fore_limits_south,
        data.fore_limits_north,
        data.lightning_meter_no,
        data.lightning_common_name,
        data.lightning_father_name,
        data.lightning_picture_bell_power,
        data.safari_booklet_common_name,
        data.safari_booklet_father_name,
        data.safari_booklet_machinegun_no,
        data.safari_booklet_issue_date,
        data.safari_booklet_picture,
        data.property_user_owner,
        data.property_user_master_rent,
        data.property_user_recipient_group,
        data.property_user_no_longer,
        data.property_user_type_of_misconduct,
        data.fst_have_building,
        data.fst_building_use,
        data.fst_building_category,
        data.fst_specifyif_other,
        data.fst_no_of_floors,
        data.fst_cubie_meter,
        data.snd_have_building,
        data.snd_building_use,
        data.snd_building_category,
        data.snd_specifyif_other,
        data.snd_no_of_floors,
        data.snd_cubie_meter,
        data.trd_have_building,
        data.trd_building_use,
        data.trd_building_category,
        data.trd_specifyif_other,
        data.trd_no_of_floors,
        data.trd_cubie_meter,
        data.forth_have_building,
        data.forth_building_use,
        data.forth_building_category,
        data.forth_specifyif_other,
        data.forth_no_of_floors,
        data.forth_cubie_meter,
        data.fth_have_building,
        data.fth_building_use,
        data.fth_building_category,
        data.fth_specifyif_other,
        data.fth_no_of_floors,
        data.fth_cubie_meter,
        data.home_map,
        data.home_photo,
        data.reg_property_fertilizer,
        data.area_unit_release_area,
        data.area_unit_business_area,
        data.area_unit_total_no_unit,
        data.area_unit_business_units,
        data.second_partner_name,
        data.second_partner_surname,
        data.second_partner_boy,
        data.second_partner_father,
        data.second_partner_gender,
        data.second_partner_phone,
        data.second_partner_email,
        data.second_partner_image,
        data.second_partner_machinegun_no,
        data.second_partner_cover_note,
        data.second_partner_note_page,
        data.second_partner_reg_no,
        data.second_partner_phote_note1,
        data.second_partner_photo_tips1,
        data.second_partner_photo_tips2,
        data.third_partner_name,
        data.third_partner_surname,
        data.third_partner_boy,
        data.third_partner_father,
        data.third_partner_gender,
        data.third_partner_phone,
        data.third_partner_email,
        data.third_partner_image,
        data.third_partner_machinegun_no,
        data.third_partner_cover_note,
        data.third_partner_note_page,
        data.third_partner_reg_no,
        data.third_partner_phote_note1,
        data.third_partner_photo_tips1,
        data.third_partner_photo_tips2,
        data.fourth_partner_name,
        data.fourth_partner_surname,
        data.fourth_partner_boy,
        data.fourth_partner_father,
        data.fourth_partner_gender,
        data.fourth_partner_phone,
        data.fourth_partner_email,
        data.fourth_partner_image,
        data.fourth_partner_machinegun_no,
        data.fourth_partner_cover_note,
        data.fourth_partner_note_page,
        data.fourth_partner_reg_no,
        data.fourth_partner_phote_note1,
        data.fourth_partner_photo_tips1,
        data.fourth_partner_photo_tips2,
        data.fifth_partner_name,
        data.fifth_partner_surname,
        data.fifth_partner_boy,
        data.fifth_partner_father,
        data.fifth_partner_gender,
        data.fifth_partner_phone,
        data.fifth_partner_email,
        data.fifth_partner_image,
        data.fifth_partner_machinegun_no,
        data.fifth_partner_cover_note,
        data.fifth_partner_note_page,
        data.fifth_partner_reg_no,
        data.fifth_partner_phote_note1,
        data.fifth_partner_photo_tips1,
        data.fifth_partner_photo_tips2,
        data.formval,
        data.editmode
      ];
      bool check = await ifpropertyexist(localkey: data.local_property_key);
      if (!check) {
        result = await dbClient.rawInsert(sqlquery, params);
      }
    } catch (e) {
      setState(AppState.Idle);
      notifyListeners();
      print(e);
    }
    setState(AppState.Idle);
    notifyListeners();
    return result;
  }

  Future<bool> ifpropertyexist({String localkey}) async {
    bool result = false;
    try {
      var dbClient = await db;
      String sqlquery =
          'SELECT local_property_key FROM propertysurvey WHERE local_property_key=?';
      List<dynamic> params = [localkey];
      List<Map> maps = await dbClient.rawQuery(sqlquery, params);
      result = (maps?.isEmpty ?? true) ? false : true;
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<int> updatePropertySurvey(
      LocalPropertySurvey data, String localkey) async {
    int result = 0;
    try {
      var dbClient = await db;
      String sqlquery = '''
        UPDATE propertysurvey
        SET other_key=?,first_surveyor_name=?,senond_surveyor_name=?,
        technical_support_name=?,property_dispte_subject_to=?,
        real_person_status=?,cityzenship_notice=?,issue_regarding_property=?,
        municipality_ref_number=?,natural_threaten=?,status_of_area_plan=?,status_of_area_official=?,
        status_of_area_regular=?,slope_of_area=?,province=?,city=?,area=?,pass=?,block=?,part_number=?,
        unit_number=?,unit_in_parcel=?,street_name=?,historic_site_area=?,land_area=?,property_type=?,
        location_of_land_area=?,property_have_document=?,document_type=?,issued_on=?,place_of_issue=?,
        property_number=?,document_cover=?,document_page=?,doc_reg_number=?,land_area_qawwala=?,property_doc_photo_1=?,
        property_doc_photo_2=?,property_doc_photo_3=?,property_doc_photo_4=?,odinary_doc_photo1=?,odinary_doc_photo6=?,
        use_in_property_doc=?,current_use_of_property=?,redeemable_property=?,proprietary_properties=?,
        govt_property=?,specified_current_use=?,unspecified_current_use_type=?,
        number_of_business_unit=?,business_unit_have_no_license=?,business_license_another=?,
        first_partner_name=?,first_partner_surname=?,first_partner_boy=?,
        first_partner__father=?,first_partner_name_gender=?,
        first_partner_name_phone=?,first_partner_name_email=?,
        first_partner_name_property_owner=?,first_partner_name_mere_individuals=?,
        info_photo_hint_sukuk_number=?,info_photo_hint_cover_note=?,
        info_photo_hint_note_page=?,info_photo_hint_reg_no=?,
        info_photo_hint_photo_note1=?,info_photo_hint_photo_tips1=?,
        info_photo_hint_photo_tips2=?,fore_limits_east=?,fore_limits_west=?,
        fore_limits_south=?,fore_limits_north=?,lightning_meter_no=?,
        lightning_common_name=?,lightning_father_name=?,
        lightning_picture_bell_power=?,safari_booklet_common_name=?,
        safari_booklet_father_name=?,safari_booklet_machinegun_no=?,
        safari_booklet_issue_date=?,safari_booklet_picture=?,property_user_owner=?,
        property_user_master_rent=?,property_user_recipient_group=?,
        property_user_no_longer=?,property_user_type_of_misconduct=?,
        fst_have_building=?,fst_building_use=?,fst_building_category=?,
        fst_specifyif_other=?,fst_no_of_floors=?,fst_cubie_meter=?,
        snd_have_building=?,snd_building_use=?,snd_building_category=?,
        snd_specifyif_other=?,snd_no_of_floors=?,snd_cubie_meter=?,
        trd_have_building=?,trd_building_use=?,trd_building_category=?,
        trd_specifyif_other=?,trd_no_of_floors=?,trd_cubie_meter=?,
        forth_have_building=?,forth_building_use=?,forth_building_category=?,forth_specifyif_other=?,
        forth_no_of_floors=?,forth_cubie_meter=?,fth_have_building=?,fth_building_use=?,
        fth_building_category=?,fth_specifyif_other=?,fth_no_of_floors=?,
        fth_cubie_meter=?,home_map=?,home_photo=?,reg_property_fertilizer=?,
        area_unit_release_area=?,area_unit_business_area=?,area_unit_total_no_unit=?,
        area_unit_business_units=?, second_partner_name=?,second_partner_surname=?,
        second_partner_boy=?,second_partner_father=?,second_partner_gender=?,
        second_partner_phone=?,second_partner_email=?,second_partner_image=?,
        second_partner_machinegun_no=?,second_partner_cover_note=?,
        second_partner_note_page=?,second_partner_reg_no=?,second_partner_phote_note1=?,
        second_partner_photo_tips1=?,second_partner_photo_tips2=?,
        third_partner_name=?,third_partner_surname=?,third_partner_boy=?,third_partner_father=?,
        third_partner_gender=?,third_partner_phone=?,third_partner_email=?,
        third_partner_image=?,third_partner_machinegun_no=?,third_partner_cover_note=?,
        third_partner_note_page=?,third_partner_reg_no=?,third_partner_phote_note1=?,
        third_partner_photo_tips1=?,third_partner_photo_tips2=?,fourth_partner_name=?,
        fourth_partner_surname=?,fourth_partner_boy=?,fourth_partner_father=?,fourth_partner_gender=?,fourth_partner_phone=?,
        fourth_partner_email=?,fourth_partner_image=?,fourth_partner_machinegun_no=?,
        fourth_partner_cover_note=?,fourth_partner_note_page=?,fourth_partner_reg_no=?,
        fourth_partner_phote_note1=?,fourth_partner_photo_tips1=?,fourth_partner_photo_tips2=?,
        fifth_partner_name=?,fifth_partner_surname=?,fifth_partner_boy=?,fifth_partner_father=?,fifth_partner_gender=?,fifth_partner_phone=?,
        fifth_partner_email=?,fifth_partner_image=?,fifth_partner_machinegun_no=?,fifth_partner_cover_note=?,
        fifth_partner_note_page=?,fifth_partner_reg_no=?,fifth_partner_phote_note1=?,
        fifth_partner_photo_tips1=?,fifth_partner_photo_tips2=?,formval=?,editmode=?
        WHERE local_property_key=?
      ''';
      List<dynamic> params = [
        data.other_key,
        data.first_surveyor_name,
        data.senond_surveyor_name,
        data.technical_support_name,
        data.property_dispte_subject_to,
        data.real_person_status,
        data.cityzenship_notice,
        data.issue_regarding_property,
        data.municipality_ref_number,
        data.natural_threaten,
        data.status_of_area_plan,
        data.status_of_area_official,
        data.status_of_area_regular,
        data.slope_of_area,
        data.province,
        data.city,
        data.area,
        data.pass,
        data.block,
        data.part_number,
        data.unit_number,
        data.unit_in_parcel,
        data.street_name,
        data.historic_site_area,
        data.land_area,
        data.property_type,
        data.location_of_land_area,
        data.property_have_document,
        data.document_type,
        data.issued_on,
        data.place_of_issue,
        data.property_number,
        data.document_cover,
        data.document_page,
        data.doc_reg_number,
        data.land_area_qawwala,
        data.property_doc_photo_1,
        data.property_doc_photo_2,
        data.property_doc_photo_3,
        data.property_doc_photo_4,
        data.odinary_doc_photo1,
        data.odinary_doc_photo6,
        data.use_in_property_doc,
        data.current_use_of_property,
        data.redeemable_property,
        data.proprietary_properties,
        data.govt_property,
        data.specified_current_use,
        data.unspecified_current_use_type,
        data.number_of_business_unit,
        data.business_unit_have_no_license,
        data.business_license_another,
        data.first_partner_name,
        data.first_partner_surname,
        data.first_partner_boy,
        data.first_partner__father,
        data.first_partner_name_gender,
        data.first_partner_name_phone,
        data.first_partner_name_email,
        data.first_partner_name_property_owner,
        data.first_partner_name_mere_individuals,
        data.info_photo_hint_sukuk_number,
        data.info_photo_hint_cover_note,
        data.info_photo_hint_note_page,
        data.info_photo_hint_reg_no,
        data.info_photo_hint_photo_note1,
        data.info_photo_hint_photo_tips1,
        data.info_photo_hint_photo_tips2,
        data.fore_limits_east,
        data.fore_limits_west,
        data.fore_limits_south,
        data.fore_limits_north,
        data.lightning_meter_no,
        data.lightning_common_name,
        data.lightning_father_name,
        data.lightning_picture_bell_power,
        data.safari_booklet_common_name,
        data.safari_booklet_father_name,
        data.safari_booklet_machinegun_no,
        data.safari_booklet_issue_date,
        data.safari_booklet_picture,
        data.property_user_owner,
        data.property_user_master_rent,
        data.property_user_recipient_group,
        data.property_user_no_longer,
        data.property_user_type_of_misconduct,
        data.fst_have_building,
        data.fst_building_use,
        data.fst_building_category,
        data.fst_specifyif_other,
        data.fst_no_of_floors,
        data.fst_cubie_meter,
        data.snd_have_building,
        data.snd_building_use,
        data.snd_building_category,
        data.snd_specifyif_other,
        data.snd_no_of_floors,
        data.snd_cubie_meter,
        data.trd_have_building,
        data.trd_building_use,
        data.trd_building_category,
        data.trd_specifyif_other,
        data.trd_no_of_floors,
        data.trd_cubie_meter,
        data.forth_have_building,
        data.forth_building_use,
        data.forth_building_category,
        data.forth_specifyif_other,
        data.forth_no_of_floors,
        data.forth_cubie_meter,
        data.fth_have_building,
        data.fth_building_use,
        data.fth_building_category,
        data.fth_specifyif_other,
        data.fth_no_of_floors,
        data.fth_cubie_meter,
        data.home_map,
        data.home_photo,
        data.reg_property_fertilizer,
        data.area_unit_release_area,
        data.area_unit_business_area,
        data.area_unit_total_no_unit,
        data.area_unit_business_units,
        data.second_partner_name,
        data.second_partner_surname,
        data.second_partner_boy,
        data.second_partner_father,
        data.second_partner_gender,
        data.second_partner_phone,
        data.second_partner_email,
        data.second_partner_image,
        data.second_partner_machinegun_no,
        data.second_partner_cover_note,
        data.second_partner_note_page,
        data.second_partner_reg_no,
        data.second_partner_phote_note1,
        data.second_partner_photo_tips1,
        data.second_partner_photo_tips2,
        data.third_partner_name,
        data.third_partner_surname,
        data.third_partner_boy,
        data.third_partner_father,
        data.third_partner_gender,
        data.third_partner_phone,
        data.third_partner_email,
        data.third_partner_image,
        data.third_partner_machinegun_no,
        data.third_partner_cover_note,
        data.third_partner_note_page,
        data.third_partner_reg_no,
        data.third_partner_phote_note1,
        data.third_partner_photo_tips1,
        data.third_partner_photo_tips2,
        data.fourth_partner_name,
        data.fourth_partner_surname,
        data.fourth_partner_boy,
        data.fourth_partner_father,
        data.fourth_partner_gender,
        data.fourth_partner_phone,
        data.fourth_partner_email,
        data.fourth_partner_image,
        data.fourth_partner_machinegun_no,
        data.fourth_partner_cover_note,
        data.fourth_partner_note_page,
        data.fourth_partner_reg_no,
        data.fourth_partner_phote_note1,
        data.fourth_partner_photo_tips1,
        data.fourth_partner_photo_tips2,
        data.fifth_partner_name,
        data.fifth_partner_surname,
        data.fifth_partner_boy,
        data.fifth_partner_father,
        data.fifth_partner_gender,
        data.fifth_partner_phone,
        data.fifth_partner_email,
        data.fifth_partner_image,
        data.fifth_partner_machinegun_no,
        data.fifth_partner_cover_note,
        data.fifth_partner_note_page,
        data.fifth_partner_reg_no,
        data.fifth_partner_phote_note1,
        data.fifth_partner_photo_tips1,
        data.fifth_partner_photo_tips2,
        data.formval,
        data.editmode,
        localkey
      ];
      result = await dbClient.rawUpdate(sqlquery, params);
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<List<LocalPropertySurvey>> getpropertysurveys(
      {String taskid, String localkey, String searchtext}) async {
    setState(AppState.Busy);
    notifyListeners();
    try {
      var dbClient = await db;
      var sqlquery = "";
      List<dynamic> params = [];
      if (localkey?.isEmpty ?? true) {
        sqlquery = '''
        SELECT * FROM propertysurvey WHERE taskid=?
      ''';
        params = [taskid];
      } else if (!(localkey?.isEmpty ?? true)) {
        sqlquery = '''
        SELECT * FROM propertysurvey WHERE taskid=? AND local_property_key=?
      ''';
        params = [taskid, localkey];
      } else if (!(localkey?.isEmpty ?? true)) {
        sqlquery = '''
          SELECT * FROM propertysurvey WHERE taskid=? AND part_number LIKE ?  
        ''';
        params = [taskid, searchtext];
      }

      List<Map> it = await dbClient.rawQuery(sqlquery, params);
      _propertysurveys =
          it.map((f) => LocalPropertySurvey.frommapobject(f)).toList();
    } catch (e) {
      setState(AppState.Idle);
      notifyListeners();
      print(e);
    }
    setState(AppState.Idle);
    notifyListeners();
    return _propertysurveys;
  }

  Future<LocalPropertySurvey> getSingleProperty(
      {String taskid, String localkey}) async {
    setState(AppState.Busy);
    notifyListeners();
    try {
      var dbClient = await db;
      var sqlquery = '''
        SELECT * FROM propertysurvey WHERE taskid=? AND local_property_key=?
      ''';
      List<dynamic> params = [taskid, localkey];
      List<Map> it = await dbClient.rawQuery(sqlquery, params);
      _singlepropertysurveys =
          it.map((f) => LocalPropertySurvey.frommapobject(f)).first;
    } catch (e) {
      setState(AppState.Idle);
      notifyListeners();
      print(e);
    }
    setState(AppState.Idle);
    notifyListeners();
    return _singlepropertysurveys;
  }

  Future<int> deletePropertySurvey({String localkey}) async {
    setState(AppState.Busy);
    notifyListeners();
    int result = 0;
    try {
      var dbClient = await db;
      result = await dbClient.delete('propertysurvey',
          where: 'local_property_key=?', whereArgs: [localkey]);
    } catch (e) {
      setState(AppState.Idle);
      notifyListeners();
      print(e);
    }
    setState(AppState.Idle);
    notifyListeners();
    return result;
  }

  Future<int> updateTaskStatus({String taskid}) async {
    int result = 0;
    try {
      var dbClient = await db;
      String query = '''
        UPDATE surveylist 
        set isstatrted = 1
        WHERE id =?
      ''';
      List<dynamic> params = [taskid];
      result = await dbClient.rawUpdate(query, params);
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
