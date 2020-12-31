import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

import '../localization/app_translations.dart';
import '../controllers/auth.dart';
import '../models/user.dart';
import '../utils/showappdialog.dart';
import '../utils/navigation_service.dart';
import '../utils/route_paths.dart' as routes;
import '../utils/locator.dart';
import '../utils/appstate.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  var _formkey = GlobalKey<FormState>();
  User _user = new User();
  FocusNode _email;
  FocusNode _password;
  bool showpassword = true;

  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  @override
  void initState() {
    _email = FocusNode();
    _password = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.blue),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Logo
              Container(
                height: 100,
                width: 100,
                child: Image.asset(
                  "assets/images/applogo.png",
                ),
              ),
              //titel
              Container(
                child: Text(
                  setapptext(key: 'key_login_app_titel'),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              //card
              Container(
                padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Consumer<AuthModel>(
                    builder: (context, data, child) {
                      return Form(
                        key: _formkey,
                        child: Column(
                          children: <Widget>[
                            //email textbox
                            Container(
                              padding:
                                  EdgeInsets.only(top: 20, left: 20, right: 20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person_pin),
                                  labelText: AppTranslations.of(context)
                                      .text("key_only_email"),
                                ),
                                textInputAction: TextInputAction.next,
                                focusNode: _email,
                                onFieldSubmitted: (_) {
                                  _email.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(_password);
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return setapptext(key: 'key_required');
                                  }
                                },
                                onSaved: (value) {
                                  _user.email = value;
                                },
                              ),
                            ),
                            //password textbox
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                obscureText: showpassword,
                                focusNode: _password,
                                textInputAction: TextInputAction.go,
                                onFieldSubmitted: (_) async {
                                  if (_formkey.currentState.validate()) {
                                    _formkey.currentState.save();
                                    var connectivityResult =
                                        await (Connectivity()
                                            .checkConnectivity());
                                    if (connectivityResult ==
                                            ConnectivityResult.mobile ||
                                        connectivityResult ==
                                            ConnectivityResult.wifi) {
                                      var result =
                                          await data.login(user: _user);
                                      if (result == "ok") {
                                        _navigationService.navigateRepalceTo(
                                            routeName: routes.LanguageRoute);
                                      } else {
                                        showDialogSingleButton(
                                            context: context,
                                            message: result,
                                            title: 'Warning',
                                            buttonLabel: 'ok');
                                      }
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                setapptext(key: 'key_warning'),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                              content: Text(setapptext(
                                                  key: 'key_ckeck_internet')),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    setapptext(key: 'key_ok'),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  }
                                  return;
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(showpassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        showpassword = !showpassword;
                                      });
                                    },
                                  ),
                                  prefixIcon: Icon(Icons.lock),
                                  labelText: AppTranslations.of(context)
                                      .text("key_password"),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return setapptext(key: 'key_required');
                                  }
                                },
                                onSaved: (value) {
                                  _user.password = value;
                                },
                              ),
                            ),
                            //login button
                            data.state == AppState.Busy
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      if (_formkey.currentState.validate()) {
                                        _formkey.currentState.save();
                                        var connectivityResult =
                                            await (Connectivity()
                                                .checkConnectivity());
                                        if (connectivityResult ==
                                                ConnectivityResult.mobile ||
                                            connectivityResult ==
                                                ConnectivityResult.wifi) {
                                          var result =
                                              await data.login(user: _user);
                                          if (result == "ok") {
                                            _navigationService
                                                .navigateRepalceTo(
                                                    routeName:
                                                        routes.LanguageRoute);
                                          } else {
                                            showDialogSingleButton(
                                                context: context,
                                                message: result,
                                                title: 'Warning',
                                                buttonLabel: 'ok');
                                          }
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    setapptext(
                                                        key: 'key_warning'),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red),
                                                  ),
                                                  content: Text(setapptext(
                                                      key:
                                                          'key_ckeck_internet')),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        setapptext(
                                                            key: 'key_ok'),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              });
                                        }
                                      }
                                      return;
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, bottom: 15),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 5.0,
                                                    color: Colors.black)
                                              ],
                                              color: Colors.blue),
                                          margin: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                          ),
                                          child: Center(
                                            child: Text(
                                              setapptext(key: 'key_login'),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
