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
import '../utils/appstate.dart';
import '../models/localpropertydata.dart';

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
      _surveyAssignments = [];
      setState(AppState.Busy);
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var responce = await http.get(
            Configuration.apiurl +
                'taskassignment?\$or[0][surveyor_1]=${preferences.getString('userid')}&\$or[1][surveyor_2]=${preferences.getString('userid')}&task_status[\$ne]=Completed',
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
                await finalTaskData(surveyassignments: _surveyAssignments);
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
      var tempsurvey = await DBHelper().getSurveys();
      _surveyAssignments =
          await DBHelper().addCompleteSUrvey(surveyAssignments: tempsurvey);
    } catch (error, stackTrace) {
      setState(AppState.Idle);
      Catcher.reportCheckedError(error, stackTrace);
    }
    setState(AppState.Idle);
    return _surveyAssignments;
  }

  Future<List<SurveyAssignment>> finalTaskData(
      {List<SurveyAssignment> surveyassignments}) async {
    List<SurveyAssignment> propertyinfolist = [];
    try {
      if (surveyassignments.isNotEmpty) {
        for (var item in surveyassignments) {
          var count = await getPropertySyncedNumber(taskid: item.id);
          item.property_to_survey = (item.property_to_survey - count);
          if (item.property_to_survey > 0) {
            propertyinfolist.add(item);
          }
        }
      }
    } catch (error, stackTrace) {
      Catcher.reportCheckedError(error, stackTrace);
    }
    return propertyinfolist;
  }

  Future<int> getPropertySyncedNumber({String taskid}) async {
    int count = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      var responce = await http.get(
          Configuration.apiurl +
              'propertyinformation?meta._id=$taskid&\$limit=0',
          headers: {
            "Content-Type": "application/json",
            "Authorization": preferences.getString("accesstoken")
          });
      if (responce.statusCode == 200) {
        count = json.decode(responce.body)['total'];
      }
    } catch (error, stackTrace) {
      Catcher.reportCheckedError(error, stackTrace);
    }
    return count;
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
