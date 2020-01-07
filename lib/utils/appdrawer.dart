import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/login.dart';
import '../pages/propertyregistation.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class AppDrawer extends StatefulWidget {
  AppDrawer({this.pageindex});
  final int pageindex;
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int _selectedDrawerIndex = 0;
  SharedPreferences pref;
  String _user;
  String _email;

  final drawerItems = [
    DrawerItem("New Tasks", Icons.dashboard), //page index = 0
    DrawerItem("Progressive Tasks", Icons.terrain), //page index = 1
    DrawerItem("Completed Tasks", Icons.check), //page index = 2
  ];
  @override
  void initState() {
    setpageindex(widget.pageindex);
    Future.delayed(Duration.zero).then((_) {
      getUserInfo();
    });
    super.initState();
  }

  setpageindex(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
  }

  getUserInfo() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      _user = pref.getString("firstname");
      _email = pref.getString("email");
    });
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    _pageNavigator(_selectedDrawerIndex);
    //Navigator.of(context).pop();
    // close the drawer
  }

  _pageNavigator(int page) {
    if (page == 0) {
      _navfunction(PropertyRegistationPage());
    }
  }

  _navfunction(Widget page) {
    Navigator.of(context).pushReplacement(
        PageTransition(type: PageTransitionType.downToUp, child: page));
  }

  logout() async {
    pref.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        ),
      );
    }

    return Container(
      child: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).secondaryHeaderColor,
                    ]),
              ),
              currentAccountPicture: new CircleAvatar(
                radius: 50.0,
                child: new Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTnx9gugwptmYiJSoH38ftixCTsOiX86pseDJUG8nTONwADCQUS',
                ),
              ),
              accountEmail: Text(_user?.isEmpty ?? true ? "" : _user),
              accountName: Text(_email?.isEmpty ?? true ? "" : _email),
              otherAccountsPictures: <Widget>[
                IconButton(
                  onPressed: () {
                    logout();
                  },
                  icon: Icon(Icons.power_settings_new, color: Colors.white),
                  tooltip: "Logout",
                )
              ],
            ),
            Column(
              children: drawerOptions,
            ),
          ],
        ),
      ),
    );
  }
}
