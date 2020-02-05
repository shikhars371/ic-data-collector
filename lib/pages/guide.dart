import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../utils/navigation_service.dart';
import '../utils/route_paths.dart' as routes;
import '../utils/locator.dart';
import '../localization/app_translations.dart';
import '../utils/appdrawer.dart';
import '../controllers/fileupload.dart';
import '../controllers/auth.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  double progressval = 0.0;

  static double remap(
      double value,
      double originalMinValue,
      double originalMaxValue,
      double translatedMinValue,
      double translatedMaxValue) {
    if (originalMaxValue - originalMinValue == 0) return 0;
    return (value - originalMinValue) /
            (originalMaxValue - originalMinValue) *
            (translatedMaxValue - translatedMinValue) +
        translatedMinValue;
  }

  void _setUploadProgress(int sentBytes, int totalBytes) {
    double __progressValue =
        remap(sentBytes.toDouble(), 0, totalBytes.toDouble(), 0, 1);

    __progressValue = double.parse(__progressValue.toStringAsFixed(2));

    if (__progressValue != progressval)
      setState(() {
        progressval = __progressValue;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          setapptext(key: 'key_guide'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: AppDrawer(),
      body: Consumer<FileUpload>(builder: (context, data, child) {
        return data.state == AppState.Busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.cloud_upload),
                      onPressed: () async {
                        var imagefile = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                        if (imagefile == null) {
                          return;
                        }
                        _setUploadProgress(0, 0);
                        try {
                          await FileUpload().fileUpload(
                              file: imagefile,
                              uploadpreogress: _setUploadProgress);
                        } catch (e) {
                          print(e);
                        }
                      }),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: LinearProgressIndicator(value: progressval),
                  )
                ],
              );
      }),
    );
  }
}
