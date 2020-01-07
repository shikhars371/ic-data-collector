import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/dashboard.dart';
import '../pages/task.dart';
import '../pages/appsettings.dart';

int pageindex = 0;

Widget appbuttomnavbar(BuildContext context) {
  return CurvedNavigationBar(
    items: <Widget>[
      Icon(Icons.home),
      Icon(Icons.assignment),
      Icon(Icons.settings)
    ],
    color: Color.fromRGBO(255, 138, 0, 1),
    buttonBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    animationCurve: Curves.easeInOut,
    index: pageindex,
    onTap: (index) {
      setIndex(index);
      if (index == 0) {
        Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.fade,
            child: DashboardPage(),
            duration: Duration(milliseconds: 600),
          ),
        );
      } else if (index == 1) {
        Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.fade,
            child: TaskPage(),
            duration: Duration(milliseconds: 600),
          ),
        );
      } else if (index == 2) {
        Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.fade,
            child: AppSetting(),
            duration: Duration(milliseconds: 600),
          ),
        );
      }
    },
  );
}

void setIndex(int value) {
  pageindex = value;
}
