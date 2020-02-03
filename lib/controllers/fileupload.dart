import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../configs/configuration.dart';

typedef void OnUploadProgressCallback(int sentBytes, int totalBytes);

class FileUpload with ChangeNotifier {
  Future<String> uploadFile(
      {File file, OnUploadProgressCallback onUploadProgress}) async {
    final url = Configuration.apiurl + "surveydata";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final stream = file.openRead();
    int length = file.lengthSync();
    final client = new HttpClient();
    final request = await client.postUrl(Uri.parse(url));
    request.headers
        .add(HttpHeaders.contentTypeHeader, "application/octet-stream");
    request.headers.add("Authorization", preferences.getString("accesstoken"));
    request.contentLength = length;
    var totalByteLength = request.contentLength;
    int byteCount = 0;
    Stream<List<int>> streamUpload = stream.transform(
      new StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);
          byteCount += data.length;
          if (onUploadProgress != null) {
            onUploadProgress(byteCount, totalByteLength);
            // CALL STATUS CALLBACK;
          }
        },
        handleError: (error, stack, sink) {
          throw error;
        },
        handleDone: (sink) {
          sink.close();
          // UPLOAD DONE;
        },
      ),
    );
    await request.addStream(streamUpload);
    final response = await request.close();
    // response prociessing.
  }
}
