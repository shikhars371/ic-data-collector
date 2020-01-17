import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/surveyAssignment.dart';
import '../controllers/auth.dart';

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
