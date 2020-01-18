import 'package:flutter/material.dart';

import './route_paths.dart' as routers;
import '../pages/login.dart';
import '../pages/dashboard.dart';
import '../pages/surveylist.dart';
import '../pages/task.dart';
import '../pages/language.dart';
import '../pages/guide.dart';
import '../pages/help.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routers.LoginRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case routers.DashboardRoute:
      return MaterialPageRoute(builder: (context) => DashboardPage());
    case routers.SurveyRoute:
      return MaterialPageRoute(builder: (context) => SurveyPage(id: settings.arguments,));
    case routers.TaskRoute:
      return MaterialPageRoute(builder: (context) => TaskPage());
    case routers.LanguageRoute:
      return MaterialPageRoute(builder: (context) => LanguagePage());
    case routers.GuideRoute:
      return MaterialPageRoute(builder: (context) => GuidePage());
    case routers.HelpRoute:
      return MaterialPageRoute(builder: (context) => HelpPage());
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
