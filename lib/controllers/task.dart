import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/surveyAssignment.dart';
import '../configs/configuration.dart';

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
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(AppState.Busy);
      var responce =
          await http.get(Configuration.apiurl + 'SurveyAssignment', headers: {
        "Content-Type": "application/json",
        "Authorization": preferences.getString("accesstoken")
      });
      if (responce.statusCode == 200) {
        Iterable i = json.decode(responce.body[3]);
        _surveyAssignments =
            i.map((model) => SurveyAssignment.fromJson(model)).toList();
      } else {
        _surveyAssignments = [];
        setState(AppState.Idle);
        notifyListeners();
      }
    } catch (e) {
      setState(AppState.Idle);
      notifyListeners();
      print(e);
    }
    return _surveyAssignments;
  }
}
