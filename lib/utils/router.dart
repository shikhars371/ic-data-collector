import 'package:flutter/material.dart';

import './route_paths.dart' as routers;
import '../pages/login.dart';
import '../pages/dashboard.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case routers.LoginRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case routers.DashboardRoute:
      return MaterialPageRoute(builder: (context) => DashboardPage());
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