import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import './controllers/auth.dart';
import './controllers/task.dart';
import './localization/app_translations_delegate.dart';
import './localization/application.dart';
import './utils/locator.dart';
import './utils/navigation_service.dart';
import './utils/router.dart' as router;
import './utils/route_paths.dart' as routes;
import './utils/appproviders.dart';
import './utils/db_helper.dart';
import './controllers/appsync.dart';

Future<Null> main() async {
  setupLocator();
  runApp(LocalisedApp());
}

class LocalisedApp extends StatefulWidget {
  @override
  LocalisedAppState createState() {
    return LocalisedAppState();
  }
}

class LocalisedAppState extends State<LocalisedApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  void dispose() {
    DBHelper().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppSyncModel(),
        )
      ],
      //providers: AppProviders().appproviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(218, 27, 96, 1),
          secondaryHeaderColor: Color.fromRGBO(255, 138, 0, 1),
        ),
        home: MyHomePage(),
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: router.generateRoute,
        //initialRoute: routes.LoginRoute,
        localizationsDelegates: [
          _newLocaleDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale("en", ""),
          const Locale("pashto", ""),
          const Locale("dari", ""),
        ],
      ),
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final NavigationService _navigationService = locator<NavigationService>();
  SharedPreferences sharedPreferences;
  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 2), onDoneLoading);
  }

  void onDoneLoading() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var access = sharedPreferences.getString("accesstoken");
    if (access != null && access != "") {
      _navigationService.navigateRepalceTo(routeName: routes.DashboardRoute);
    } else {
      _navigationService.navigateRepalceTo(routeName: routes.LoginRoute);
    }
  }

  @override
  void initState() {
    DBHelper().initDatabase();
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/splashscreen.jpg'),
            fit: BoxFit.fill),
      ),
    );
  }
}
