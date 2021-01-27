import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo({String routeName, Object parms}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: parms);
  }

  Future<dynamic> navigateRepalceTo({String routeName, Object parms}) {
    return navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: parms);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
