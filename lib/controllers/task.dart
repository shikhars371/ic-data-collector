import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kapp/controllers/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:catcher/catcher_plugin.dart';

import '../models/surveyAssignment.dart';
import '../configs/configuration.dart';
import '../utils/db_helper.dart';

enum AppState { Idle, Busy }

class TaskModel with ChangeNotifier {
  AppState _state = AppState.Idle;
  AppState get state => _state;
  void setState(AppState appState) {
    _state = appState;
    notifyListeners();
  }

  List<SurveyAssignment> _surveyAssignments = [];
  List<SurveyAssignment> get surveyAssignments => _surveyAssignments;

  Future<List<SurveyAssignment>> getAssignments() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      setState(AppState.Busy);
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var responce = await http.get(
            Configuration.apiurl +
                'taskassignment?\$or[0][surveyor_1]=${preferences.getString('userid')}&\$or[1][surveyor_2]=${preferences.getString('userid')}',
            headers: {
              "Content-Type": "application/json",
              "Authorization": preferences.getString("accesstoken")
            });
        if (responce.statusCode == 200) {
          Map responseJson = json.decode(responce.body);
          Iterable i = responseJson['data'];
          if ((i != null) || (i.isNotEmpty)) {
            _surveyAssignments =
                i.map((model) => SurveyAssignment.fromJson(model)).toList();
            _surveyAssignments =
                await addNames(assignmentlist: _surveyAssignments);
            await DBHelper()
                .addSurveyList(surveyAssignments: _surveyAssignments);
          }
        } else if (responce.statusCode == 401) {
          var email = preferences.getString('email');
          if (!(email?.isEmpty ?? true)) {
            AuthModel().generateRefreshToken().then((_) {
              getAssignments();
            });
          }
        }
      }
      _surveyAssignments = await DBHelper().getSurveys();
    } catch (error, stackTrace) {
      setState(AppState.Idle);

      Catcher.reportCheckedError(error, stackTrace);
    }
    setState(AppState.Idle);
    return _surveyAssignments;
  }

  Future<String> getUserName({String userid}) async {
    var result = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      var responce =
          await http.get(Configuration.apiurl + 'users/$userid', headers: {
        "Content-Type": "application/json",
        "Authorization": preferences.getString("accesstoken")
      });
      if (responce.statusCode == 200) {
        Map responseJson = json.decode(responce.body);
        result = responseJson['first_name'] + " " + responseJson['last_name'];
      } else if (responce.statusCode == 401) {
        AuthModel().generateRefreshToken().then((_) {
          getUserName(userid: userid);
        });
      }
    } catch (error, stackTrace) {
      Catcher.reportCheckedError(error, stackTrace);
    }
    return result;
  }

  Future<List<SurveyAssignment>> addNames(
      {List<SurveyAssignment> assignmentlist}) async {
    List<SurveyAssignment> modifiedassignment = [];
    try {
      if (assignmentlist.isNotEmpty) {
        for (SurveyAssignment item in assignmentlist) {
          item.teamleadname = await getUserName(userid: item.teamlead);
          item.surveyoronename = await getUserName(userid: item.surveyor1);
          item.surveyortwoname = await getUserName(userid: item.surveyor2);
          modifiedassignment.add(item);
        }
      }
    } catch (error, stackTrace) {
      Catcher.reportCheckedError(error, stackTrace);
    }
    return modifiedassignment;
  }
}
