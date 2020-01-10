import 'package:flutter/material.dart';
import 'package:kapp/controllers/auth.dart';
import 'package:provider/provider.dart';

import '../localization/app_translations.dart';
import '../utils/buttomnavbar.dart';
import '../controllers/appsync.dart';

class AppSetting extends StatefulWidget {
  @override
  _AppSettingState createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
              //color: Color.fromRGBO(192, 65, 25, 1),
              fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).secondaryHeaderColor
                ]),
          ),
        ),
      ),
      bottomNavigationBar: appbuttomnavbar(context),
      body: SingleChildScrollView(
        child: Consumer<AppSyncModel>(
          builder: (context, data, child) {
            return data.state == AppState.Busy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.language),
                          title: Text(setapptext(key: 'key_language')),
                          onTap: () {
                            print("language");
                          },
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                        ListTile(
                          leading: Icon(Icons.sync),
                          title: Text(setapptext(key: 'key_app_sync')),
                          onTap: () {
                            data.appSync().then((onValue) {
                              print(onValue);
                            });
                          },
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
