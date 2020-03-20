import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kapp/controllers/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:catcher/catcher_plugin.dart';

import '../configs/configuration.dart';
import '../utils/db_helper.dart';
import '../models/reworkassignment.dart';
import '../utils/appstate.dart';

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
    try {
      if (!(propertyid?.isEmpty ?? true)) {
        var responce = await http
            .get(Configuration.apiurl + 'propertyinformation/$propertyid');
        
      }
    } catch (error, stackTrace) {
      setState(AppState.Idle);
      Catcher.reportCheckedError(error, stackTrace);
    }
    setState(AppState.Idle);
    return result;
  }
}
