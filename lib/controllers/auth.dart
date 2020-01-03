import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../configs/configuration.dart';

enum AppState { Idle, Busy }

class AuthModel with ChangeNotifier {
  AppState _state = AppState.Idle;
  AppState get state => _state;
  void setState(AppState appState) {
    _state = appState;
    notifyListeners();
  }

  Future<bool> login({User user}) async {
    setState(AppState.Busy);
    bool result = false;
    try {
      var responce = await http.post(Configuration.apiurl + "authentication",
          body: {
            "strategy": "local",
            "email": user.email.trim(),
            "password": user.password.trim()
          });
      if (responce.statusCode == 201) {
        if (responce.body.isNotEmpty) {
          saveCurrentLogin(
            json.decode(responce.body),
          );
          // print(
          //   json.decode(responce.body)['accessToken'],
          // );
          result = true;
        }
      } else {
        result = false;
      }
    } catch (e) {
      print(e);
      result = false;
      setState(AppState.Idle);
    }
    setState(AppState.Idle);
    notifyListeners();
    return result;
  }
}

void saveCurrentLogin(Map responseJson) async {
  var preferences = await SharedPreferences.getInstance();
  preferences.setString("accesstoken", responseJson['accessToken']);
  preferences.setString("userid", responseJson['user']['_id']);
  preferences.setString("firstname", responseJson['user']['first_name']);
  preferences.setString("lastname", responseJson['user']['last_name']);
  preferences.setString("designation", responseJson['user']['designation']);
  preferences.setString("username", responseJson['user']['user_name']);
  preferences.setString("email", responseJson['user']['email']);
  preferences.setString("activeStatus", responseJson['user']['active_status']);
  preferences.setString("roleId", responseJson['user']['role_id']);
}
