import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:catcher/catcher_plugin.dart';
import 'package:connectivity/connectivity.dart';

import './db_helper.dart';
import '../controllers/appsync.dart';

class BackGroundSync with ChangeNotifier {
  //background fetch configuration
  BackgroundFetchConfig _backgroundFetchConfig = new BackgroundFetchConfig(
      minimumFetchInterval: 120,
      startOnBoot: true,
      stopOnTerminate: false,
      enableHeadless: true,
      requiresBatteryNotLow: false,
      requiresCharging: false,
      requiresStorageNotLow: false,
      requiresDeviceIdle: false,
      requiredNetworkType: NetworkType.ANY);

  void onBackGroundfetch(String bfid) async {
    startSync().then((onValue) {
      if (onValue != "success") {
        Catcher.reportCheckedError(onValue, "error in onBackGroundfetch");
      }
      //after finish the task
      BackgroundFetch.finish(bfid);
    }).catchError((onError) {
      //after finish the task
      BackgroundFetch.finish(bfid);
      Catcher.reportCheckedError(onError, "error in onBackGroundfetch");
    });
  }

  void _setUploadProgress(int sentBytes, int totalBytes) {}
  // Configure BackgroundFetch.
  Future<void> initPlatformState() async {
    BackgroundFetch.configure(_backgroundFetchConfig, onBackGroundfetch)
        .catchError((onError, stackTrace) {
      Catcher.reportCheckedError(onError, stackTrace);
    });
  }

  Future<String> startSync() async {
    String result = "success";
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      //task performed only internet is avalible
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        //if all task not synced
        var localpropertydatas = await DBHelper().getAllUnsycedData();
        if (!(localpropertydatas?.isEmpty ?? true)) {
          //get a single data
          final singlelocaldata = localpropertydatas.first;
          //if user validated
          var isvalidated =
              await AppSync().validateUserData(taskid: singlelocaldata.taskid);
          if (isvalidated) {
            if (singlelocaldata != null) {
              bool isuploaded = await AppSync().fileUpload(
                  propertydata: singlelocaldata,
                  uploadpreogress: _setUploadProgress);
              if (isuploaded) {
                await DBHelper()
                    .updateTaskSyncStatus(taskid: singlelocaldata.taskid);
              } else {
                result = "data sync failed";
              }
            }
          }
        }
      }
    } catch (error, stackTrace) {
      Catcher.reportCheckedError(error, stackTrace);
    }
    return result;
  }
}
