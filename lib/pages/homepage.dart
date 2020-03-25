import 'package:flutter/material.dart';

import '../utils/appdrawer.dart';
import '../localization/app_translations.dart';
import '../utils/navigation_service.dart';
import '../utils/locator.dart';
import '../utils/route_paths.dart' as routes;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NavigationService _navigationService = locator<NavigationService>();
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
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //new task
              GestureDetector(
                onTap: () {
                  _navigationService.navigateRepalceTo(
                      routeName: routes.TaskRoute);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Container(
                          height: screenHeight / 5,
                          width: screenWidth / 3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/add.png"),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      Text(setapptext(key: 'key_newsurvey'),
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
              //rework
              GestureDetector(
                onTap: () {
                  _navigationService.navigateRepalceTo(
                      routeName: routes.ReworkTaskPage);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: screenHeight / 5,
                        width: screenWidth / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/reworkSurvey.png"),
                          ),
                        ),
                      ),
                      Text(setapptext(key: 'key_rework'),
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
