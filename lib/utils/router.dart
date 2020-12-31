import 'package:flutter/material.dart';
import 'package:kapp/pages/surveyor_list.dart';

import './route_paths.dart' as routers;
import '../pages/login.dart';
import '../pages/surveylist.dart';
// import '../pages/task.dart';
import '../pages/language.dart';
import '../pages/guide.dart';
import '../pages/help.dart';
import '../pages/surveyinfo.dart';
import '../main.dart';
import '../pages/homepage.dart';
import '../pages/reworktask.dart';
import '../pages/reworklist.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routers.LoginRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case routers.SurveyRoute:
      return MaterialPageRoute(
          builder: (context) => SurveyPage(
                surveyassignment: settings.arguments,
              ));
    case routers.TaskRoute:
      return MaterialPageRoute(builder: (context) => SurveyoerList());
    case routers.LanguageRoute:
      return MaterialPageRoute(builder: (context) => LanguagePage());
    case routers.GuideRoute:
      return MaterialPageRoute(builder: (context) => GuidePage());
    case routers.HelpRoute:
      return MaterialPageRoute(builder: (context) => HelpPage());
    case routers.SurveyInfo:
      return MaterialPageRoute(
        builder: (context) => SurveyInfoPage(
          localdata: settings.arguments,
        ),
      );
    case routers.Homepage:
      return MaterialPageRoute(builder: (context) => MyHomePage());
    case routers.DashboardRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    case routers.ReworkTaskPage:
      return MaterialPageRoute(builder: (context) => ReworkTaskPage());
    case routers.ReworkList:
      return MaterialPageRoute(builder: (context) => RewokListPage());
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
