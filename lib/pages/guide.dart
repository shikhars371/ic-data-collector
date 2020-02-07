import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../utils/navigation_service.dart';
import '../utils/route_paths.dart' as routes;
import '../utils/locator.dart';
import '../localization/app_translations.dart';
import '../utils/appdrawer.dart';
import '../controllers/auth.dart';
import '../controllers/appsync.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
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
      body: Consumer<AppSync>(builder: (context, data, child) {
        return data.state == AppState.Busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[],
              );
      }),
    );
  }
}
