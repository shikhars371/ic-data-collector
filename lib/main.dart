import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kapp/localization/app_translations.dart';
import 'package:kapp/utils/language_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:catcher/catcher_plugin.dart';
import 'package:background_fetch/background_fetch.dart';

import './controllers/auth.dart';
import './controllers/task.dart';
import './controllers/appsync.dart';
import './localization/app_translations_delegate.dart';
import './localization/application.dart';
import './utils/locator.dart';
import './utils/navigation_service.dart';
import './utils/router.dart' as router;
import './utils/route_paths.dart' as routes;
import './utils/db_helper.dart';
import './utils/backgroundfetch.dart';

Future<Null> main() async {
  CatcherOptions debugOptions = CatcherOptions(SilentReportMode(), [
    ConsoleHandler(),
  ]);
  CatcherOptions releaseOptions = CatcherOptions(SilentReportMode(), [
    SlackHandler(
        "https://hooks.slack.com/services/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",
        "mobileapperror",
        username: "Oc Data Collector App Error",
        iconEmoji: ":thinking_face:",
        enableDeviceParameters: true,
        enableApplicationParameters: true,
        enableCustomParameters: true,
        enableStackTrace: true,
        printLogs: true),
  ]);
  Catcher(
    LocalisedApp(),
    debugConfig: debugOptions,
    releaseConfig: releaseOptions,
  );
  setupLocator();
  BackgroundFetch.registerHeadlessTask(BackGroundSync().onBackGroundfetch);
  FlutterError.onError = (FlutterErrorDetails flutterErrorDetails) async {
    if (!kReleaseMode) {
      FlutterError.dumpErrorToConsole(flutterErrorDetails);
    }
    Catcher.reportCheckedError(
        flutterErrorDetails.context, flutterErrorDetails.stack);
    if (kReleaseMode) exit(1);
  };
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
    BackGroundSync().initPlatformState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  void dispose() {
    DBHelper().close();
    super.dispose();
  }

  void sendCatchererror(FlutterErrorDetails error) {
    Catcher.reportCheckedError(error.exception, error.stack);
  }

  Widget buildError(BuildContext context, FlutterErrorDetails error) {
    sendCatchererror(error);
    return Scaffold(
        body: Center(
      child: RaisedButton(
        child: Text("Something goes wrong,Please close the app & Restart"),
        onPressed: () {
          exit(1);
        },
      ),
    ));
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
          create: (_) => DBHelper(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppSync(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Arvo',
          primaryColor: Colors.blue,
          secondaryHeaderColor: Colors.black,
        ),
        home: MyHomePage(),
        builder: (BuildContext context, Widget widget) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return buildError(context, errorDetails);
          };
          return widget;
        },
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: router.generateRoute,
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

  void onDoneLoading() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var access = sharedPreferences.getString("accesstoken");
    if (access != null && access != "") {
      _navigationService.navigateRepalceTo(routeName: routes.TaskRoute);
    } else {
      _navigationService.navigateRepalceTo(routeName: routes.LoginRoute);
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<DBHelper>(context).getLanguage();
    });
    DBHelper().initDatabase();
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DBHelper>(builder: (context, data, child) {
      AppTranslations.load(
        Locale(
          getLocaleCode(id: data.currentLanguageIndex),
        ),
      );
      locator<LanguageService>().currentlanguage = data.currentLanguageIndex;
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/splashscreen.jpg'),
              fit: BoxFit.fill),
        ),
      );
    });
  }
}
