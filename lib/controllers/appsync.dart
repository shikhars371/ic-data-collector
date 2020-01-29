import 'dart:convert';
import 'package:flutter/foundation.dart';
import './auth.dart';
import '../models/localpropertydata.dart';

class AppSync with ChangeNotifier {
  AppState _state = AppState.Idle;
  AppState get state => _state;
  void setState(AppState appState) {
    _state = appState;
    notifyListeners();
  }
}
