import 'package:flutter/material.dart';

import '../utils/appdrawer.dart';
import '../localization/app_translations.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          setapptext(key: 'key_home'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 30,
          children: <Widget>[
            //new task
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/add.png"),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text("data"),
              ),
            ),
            //rework
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/reworkSurvey.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
