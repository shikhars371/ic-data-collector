import 'package:flutter/material.dart';

import '../utils/appdrawer.dart';
import '../localization/app_translations.dart';

class ReworkTaskPage extends StatefulWidget {
  @override
  _ReworkTaskPageState createState() => _ReworkTaskPageState();
}

class _ReworkTaskPageState extends State<ReworkTaskPage> {
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          setapptext(key: 'key_rework'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
