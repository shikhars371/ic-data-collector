import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:kapp/controllers/auth.dart';
import 'package:kapp/utils/db_helper.dart';
import 'package:provider/provider.dart';

import '../localization/app_translations.dart';
import '../utils/appdrawer.dart';
import '../utils/navigation_service.dart';
import '../utils/route_paths.dart' as routes;
import '../utils/locator.dart';

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
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<DBHelper>(context).getLanguage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          setapptext(key: 'key_language'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          child: Consumer<DBHelper>(
            builder: (context, data, child) {
              return data.state == AppState.Busy
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RadioButtonGroup(
                      labels: ['English', 'پښتو', 'درى'],
                      picked: getLanguage(id: data.currentLanguageIndex),
                      onChange: (value, index) async {
                        await DBHelper()
                            .changeLanguage(lang: value, langvalue: index);
                        Provider.of<DBHelper>(context).getLanguage();
                        setState(() {});
                        _navigationService.navigateRepalceTo(
                            routeName: routes.Homepage);
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
