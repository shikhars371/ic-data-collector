import 'package:flutter/material.dart';

import '../localization/app_translations.dart';
import '../utils/buttomnavbar.dart';
import '../utils/appdrawer.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          setapptext(key: 'key_task'),
          style: TextStyle(
              //color: Color.fromRGBO(192, 65, 25, 1),
              fontWeight: FontWeight.bold),
        ),
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
      bottomNavigationBar: appbuttomnavbar(context),
      drawer: AppDrawer(),
      body: Container(

      ),
    );
  }
}
