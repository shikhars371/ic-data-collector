import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper with ChangeNotifier {
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

  Future<dynamic> add(U umodel) async {
    try {
      var dbClient = await db;
      umodel.id = await dbClient.insert('user1', umodel.toJson());
      return umodel;
    } catch (e) {
      print(e);
    }
  }

  Future<List<U>> getStudents() async {
    List<U> students = [];
    try {
      var dbClient = await db;
      List<Map> maps = await dbClient.query('user1', columns: ['id', 'name']);
      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          students.add(U(id: maps[i]['id'], name: maps[i]['name']));
        }
      }
    } catch (e) {
      print(e);
    }
    return students;
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

class U {
  int id;
  String name;
  U({this.id, this.name});
  U.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
