import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/login.dart';

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
    DrawerItem("Dashboard", Icons.dashboard), //page index = 0
    DrawerItem("Committee Formation", Icons.group), //page index = 1
    DrawerItem("Joint Verification", Icons.verified_user), //page index = 2
    DrawerItem("DGPS Survey", Icons.router) //page index = 3
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
      _user = pref.getString("user");
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
      //_navfunction();
    } 
  }

  _navfunction(Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => page),
    );
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
              decoration: BoxDecoration(color: Colors.green[800]),
              currentAccountPicture: new CircleAvatar(
                radius: 50.0,
                child: new Image.asset(
                  'assets/images/logo_light.png',
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