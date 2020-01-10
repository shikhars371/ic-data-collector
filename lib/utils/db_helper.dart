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
          issynced INTEGER DEFAULT 0,iscompleted INTEGER DEFAULT 0
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
        result = await dbClient.rawInsert('''
          INSERT INTO surveylist(id,uid,assignedby,assignedto,provinceid,
          municpalityid,nahiaid,gozarid,blockid,startdate,propertytosurvey,
          propertysurveyed,propertyverified,propertygeoverified,
          completiondate,completionstatus,approvestatus,createdby,updatedby,
          ip)VALUES("${item.id}","${item.uid}","${item.assignedBy}",
          "${item.assignedTo}","${item.provinceId}","${item.municpalityId}",
          "${item.nahiaId}","${item.gozarId}","${item.blockId}","${item.startDate}",
          ${item.propertyToSurvey.toInt()},${item.propertySurveyed.toInt()},
          ${item.propertyVerified.toInt()},${item.propertyGeoverified.toInt()},
          "${item.completionDate}","${item.completionStatus}","${item.approveStatus}",
          "${item.createdBy}","${item.updatedBy}","${item.ip}")
        ''');
        // result = await dbClient.insert('surveylist', {
        //   "id": item.id,
        //   "uid": item.uid,
        //   "assignedby": item.assignedBy,
        //   "assignedto": item.assignedTo,
        //   "provinceid": item.provinceId,
        //   "municpalityid": item.municpalityId,
        //   "nahiaid": item.nahiaId,
        //   "gozarid": item.gozarId,
        //   "blockid": item.blockId,
        //   "startdate": item.startDate,
        //   "propertytosurvey": item.propertyToSurvey,
        //   "propertysurveyed": item.propertySurveyed,
        //   "propertyverified": item.propertyVerified,
        //   "propertygeoverified": item.propertyGeoverified,
        //   "completiondate": item.completionDate,
        //   "completionstatus": item.completionStatus,
        //   "approvestatus": item.approveStatus,
        //   "createdby": item.createdBy,
        //   "updatedby": item.updatedBy,
        //   "ip": item.ip
        // });
      }
    } catch (e) {
      print("addsurveylist db error:" + e);
    }
    return result;
  }

  Future<List<SurveyAssignment>> getSurveys() async {
    List<SurveyAssignment> surveys = [];
    try {
      var dbClient = await db;
      List<Map> maps = await dbClient.query('surveylist');
      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          surveys.add(
            SurveyAssignment(
                id: maps[i]['id'],
                uid: maps[i]['id'],
                assignedBy: maps[i]['id'],
                assignedTo: maps[i]['id'],
                provinceId: maps[i]['id'],
                municpalityId: maps[i]['id'],
                nahiaId: maps[i]['id'],
                gozarId: maps[i]['id'],
                blockId: maps[i]['id'],
                startDate: maps[i]['id'],
                propertyToSurvey: maps[i]['id'],
                propertySurveyed: maps[i]['id'],
                propertyVerified: maps[i]['id'],
                propertyGeoverified: maps[i]['id'],
                completionDate: maps[i]['id'],
                completionStatus: maps[i]['id'],
                approveStatus: maps[i]['id'],
                createdBy: maps[i]['id'],
                updatedBy: maps[i]['id'],
                ip: maps[i]['id']),
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
