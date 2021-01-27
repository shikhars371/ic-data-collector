import 'package:flutter/material.dart';
import 'package:kapp/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/navigation_service.dart';
import '../utils/route_paths.dart' as routes;
import '../utils/locator.dart';
import '../localization/app_translations.dart';
import '../utils/appdrawer.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  List<String> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          setapptext(key: 'key_help'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
          child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () async {
              data = await DBHelper().help();
              setState(() {});
            },
            child: Text("Click"),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Text(data[index]);
                }),
          )
        ],
      )),
    );
  }
}
