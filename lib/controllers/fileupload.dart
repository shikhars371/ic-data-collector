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
  // Future<String> uploadFile(
  //     {File file, OnUploadProgressCallback onUploadProgress}) async {
  //   final url = Configuration.apiurl + "surveydata";
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final stream = file.openRead();
  //   int length = file.lengthSync();
  //   final client = new HttpClient();
  //   final request = await client.postUrl(Uri.parse(url));
  //   request.headers
  //       .add(HttpHeaders.contentTypeHeader, "application/octet-stream");
  //   request.headers.add("Authorization", preferences.getString("accesstoken"));
  //   request.contentLength = length;
  //   var totalByteLength = request.contentLength;
  //   int byteCount = 0;
  //   Stream<List<int>> streamUpload = stream.transform(
  //     new StreamTransformer.fromHandlers(
  //       handleData: (data, sink) {
  //         sink.add(data);
  //         byteCount += data.length;
  //         if (onUploadProgress != null) {
  //           onUploadProgress(byteCount, totalByteLength);
  //           print(byteCount);
  //         }
  //       },
  //       handleError: (error, stack, sink) {
  //         throw error;
  //       },
  //       handleDone: (sink) {
  //         sink.close();
  //         // UPLOAD DONE;
  //       },
  //     ),
  //   );
  //   await request.addStream(streamUpload);
  //   final response = await request.close();
  //   // response prociessing.
  // }

  Future<String> fu(
      {File file, OnUploadProgressCallback onUploadProgress}) async {
    String upload;
    try {
      var stream = new http.ByteStream(file.openRead());
      var request = new http.MultipartRequest(
        "POST",
        Uri.parse(Configuration.apiurl + "surveydata"),
      );
      var multipartFile = new http.MultipartFile(
        "files",
        stream,
        await file.length(),
        filename: basename(file.path),
      );
      int byteCount = 0;
      var totalByteLength = file.lengthSync();
      Stream<List<int>> streamUpload = stream.transform(
        new StreamTransformer.fromHandlers(
          handleData: (data, sink) {
            sink.add(data);
            byteCount += data.length;
            if (onUploadProgress != null) {
              onUploadProgress(byteCount, totalByteLength);
              print(byteCount);
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
      request.files.add(multipartFile);
      var response = await request.send();
      if (response.statusCode == 201) {
        //var arr = json.decode(await response.stream.bytesToString());
        // response.stream.transform(utf8.decoder).listen(
        //   (value) {
        //     upload = Upload.fromJson(json.decode(value)[0]);
        //     return upload;
        //   },
        // );
        //upload = upload;
      } else {
        upload = null;
      }
    } catch (e) {
      print(e);
    }
    return upload;
  }
}
