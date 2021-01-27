import 'package:flutter/material.dart';
import 'package:kapp/utils/db_helper.dart';
import 'package:provider/provider.dart';

import '../localization/app_translations.dart';
import '../utils/navigation_service.dart';
import '../utils/route_paths.dart' as routes;
import '../utils/locator.dart';
import '../utils/appstate.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  String getLanguage({int id}) {
    String result = "English";
    switch (id) {
      case 0:
        result = "English";
        break;
      case 1:
        result = "پښتو";
        break;
      case 2:
        result = "درى";
        break;
      default:
    }
    return result;
  }

  String getLocaleCode({int id}) {
    String result = "en";
    switch (id) {
      case 0:
        result = "en";
        break;
      case 1:
        result = "pashto";
        break;
      case 2:
        result = "dari";
        break;
      default:
    }
    return result;
  }

  final NavigationService _navigationService = locator<NavigationService>();
  String currentlanguage = "";
  void chnageLanguage({String value, int index}) async {
    var result = await DBHelper().changeLanguage(lang: value, langvalue: index);
    if (result != 0) {
      _navigationService.navigateRepalceTo(routeName: routes.Homepage);
    } else {
      DBHelper().reCreateLnagugae(lang: value, langvalue: index);
    }
    _navigationService.navigateRepalceTo(routeName: routes.Homepage);
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<DBHelper>(context).getLanguage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Consumer<DBHelper>(
            builder: (context, data, child) {
              return data.state == AppState.Busy
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: screenheight,
                      width: screenwidth,
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                chnageLanguage(value: 'English', index: 0);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Container(
                                  height: 40,
                                  width: screenwidth / 1.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white),
                                  child: Center(
                                    child: Text(
                                      "English",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                chnageLanguage(value: 'درى', index: 1);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Container(
                                  height: 40,
                                  width: screenwidth / 1.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white),
                                  child: Center(
                                    child: Text(
                                      "پښتو",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                chnageLanguage(value: 'پښتو', index: 2);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Container(
                                  height: 40,
                                  width: screenwidth / 1.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white),
                                  child: Center(
                                    child: Text(
                                      "درى",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
