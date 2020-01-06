import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localization/app_translations.dart';
import './form1.dart';

class SurveyPage extends StatefulWidget {
  SurveyPage({this.id});
  final String id;
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Survey List",
          style: TextStyle(
              //color: Color.fromRGBO(192, 65, 25, 1),
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: "add new property",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Form1Page(),
                ),
              );
            },
          )
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).secondaryHeaderColor
                ]),
          ),
        ),
      ),
      body: Container(),
    );
  }
}
