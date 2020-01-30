import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

import '../models/surveyAssignment.dart';
import '../configs/configuration.dart';
import '../utils/navigation_service.dart';
import '../utils/route_paths.dart' as routes;
import '../utils/locator.dart';
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
  final NavigationService _navigationService = locator<NavigationService>();

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
            await DBHelper()
                .addSurveyList(surveyAssignments: _surveyAssignments);
          }
        } else if (responce.statusCode == 401) {
          _navigationService.navigateRepalceTo(routeName: routes.LoginRoute);
        }
      }
      _surveyAssignments = await DBHelper().getSurveys();
    } catch (e) {
      setState(AppState.Idle);
      notifyListeners();
      print(e);
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
        _navigationService.navigateRepalceTo(routeName: routes.LoginRoute);
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
