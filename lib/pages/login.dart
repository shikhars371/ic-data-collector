import 'package:flutter/material.dart';

import '../pages/form1.dart';
import '../localization/app_translations.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                child: Image.asset("assets/images/klogo.png",),
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
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_pin),
                            labelText:
                                AppTranslations.of(context).text("key_email"),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: AppTranslations.of(context)
                                .text("key_password"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Form1Page(),
                              ),
                            );
                          },
                          padding: EdgeInsets.all(12),
                          color: Colors.lightBlueAccent,
                          child: Text(
                            AppTranslations.of(context).text("key_login"),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text("english"),
                      onPressed: () {
                        AppTranslations.load(Locale("en"));
                        setState(() {});
                      },
                    ),
                    FlatButton(
                      child: Text("Pashto"),
                      onPressed: () {
                        AppTranslations.load(Locale("pashto"));
                        setState(() {});
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
