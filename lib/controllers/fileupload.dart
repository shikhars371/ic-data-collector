import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';

import '../models/user.dart';
import '../configs/configuration.dart';
import './auth.dart';

typedef void OnUploadProgressCallback(int sentBytes, int totalBytes);

class FileUpload with ChangeNotifier {
  AppState _state = AppState.Idle;
  AppState get state => _state;
  void setState(AppState appState) {
    _state = appState;
    notifyListeners();
  }

  Future<String> fileUpload({File file}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      var dio = Dio();
      final url = Configuration.apiurl + "surveydata";
      Options options = new Options(
        headers: {
          "Authorization": preferences.getString("accesstoken"),
        },
      );
      var f = FormData.fromMap({
        "files": await MultipartFile.fromFile(file.path,
            filename: basename(file.path)),
      });
      var responce = await dio.post(url, options: options, data: f,
          onSendProgress: (sent, total) {
        print("sent" + sent.toString() + "total" + total.toString());
      });
    } catch (e) {
      print(e);
    }
  }
}
