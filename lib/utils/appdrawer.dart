import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../pages/login.dart';
import '../utils/navigation_service.dart';
import '../utils/route_paths.dart' as routes;
import '../utils/locator.dart';
import '../localization/app_translations.dart';

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
  final NavigationService _navigationService = locator<NavigationService>();
  int _selectedDrawerIndex = 0;
  SharedPreferences pref;
  String _user;
  String _email;
  String lastsynceddate;

  final drawerItems = [
    DrawerItem("key_tasks", Icons.assignment), //page index = 0
    DrawerItem("key_language", Icons.language), //page index = 1
    DrawerItem("key_guide", Icons.book), //page index = 2
    DrawerItem("key_help", Icons.help), //page index = 2
  ];
  @override
  void initState() {
    setpageindex(widget.pageindex);
    Future.delayed(Duration.zero).then((_) {
      getUserInfo();
      getLastsyncdata();
    });
    super.initState();
  }

  getLastsyncdata() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    lastsynceddate = sp.getString("lastsync");
  }

  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
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
      _navigationService.navigateRepalceTo(routeName: routes.TaskRoute);
    } else if (page == 1) {
      _navigationService.navigateRepalceTo(routeName: routes.LanguageRoute);
    } else if (page == 2) {
      _navigationService.navigateRepalceTo(routeName: routes.GuideRoute);
    } else if (page == 3) {
      _navigationService.navigateRepalceTo(routeName: routes.HelpRoute);
    }
  }

  logout() async {
    ///TODO check data sync or not
    ///if data synced then clear the local data if not ask
    ///user to sync the data then logout
    ///if then also user wish to delete the data then allow
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
          title: new Text(setapptext(key: d.title)),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        ),
      );
    }

    return Container(
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Wrap(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
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
            lastsynceddate?.isEmpty ?? true
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      child: Text(
                        setapptext(key: 'key_Last_Sync_Date') +
                            "-:" +
                            DateFormat("dd-MM-yyy hh:mm").format(
                              DateTime.tryParse(lastsynceddate),
                            ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
