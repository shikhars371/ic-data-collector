import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './dashboard.dart';
import '../localization/app_translations.dart';
import '../controllers/auth.dart';
import '../models/user.dart';
import '../utils/showappdialog.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formkey = GlobalKey<FormState>();
  User _user = new User();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue,
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
                  "assets/images/klogo.png",
                ),
              ),
              //titel
              Container(
                child: Text(
                  "OC Data Collector",
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
                                      .text("key_email"),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '* requaired';
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
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  labelText: AppTranslations.of(context)
                                      .text("key_password"),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '* required';
                                  }
                                },
                                onSaved: (value) {
                                  _user.password = value;
                                },
                              ),
                            ),
                            //login button
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: data.state == AppState.Busy
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      onPressed: () async {
                                        if (_formkey.currentState.validate()) {
                                          _formkey.currentState.save();
                                          var result =
                                              await data.login(user: _user);
                                          if (result) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        DashboardPage(),
                                              ),
                                            );
                                          } else {
                                            showDialogSingleButton(
                                                context: context,
                                                message:
                                                    'Invalid username or password.',
                                                title: 'Warning',
                                                buttonLabel: 'ok');
                                          }
                                        }
                                        return;
                                      },
                                      padding: EdgeInsets.all(12),
                                      color: Colors.lightBlueAccent,
                                      child: Text(
                                        AppTranslations.of(context)
                                            .text("key_login"),
                                        style: TextStyle(color: Colors.white),
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
              // Container(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       FlatButton(
              //         child: Text("english"),
              //         onPressed: () {
              //           AppTranslations.load(Locale("en"));
              //           setState(() {});
              //         },
              //       ),
              //       FlatButton(
              //         child: Text("Pashto"),
              //         onPressed: () {
              //           AppTranslations.load(Locale("pashto"));
              //           setState(() {});
              //         },
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
