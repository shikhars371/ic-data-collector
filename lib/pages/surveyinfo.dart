import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localization/app_translations.dart';
import '../models/localpropertydata.dart';
import '../utils/db_helper.dart';
import '../controllers/auth.dart';
import './generalinfoone.dart';
import '../widgets/appformcards.dart';

class Dpvalue {
  String name;
  String value;
  Dpvalue({this.name, this.value});
}

class SurveyInfoPage extends StatefulWidget {
  SurveyInfoPage({this.taskid});
  final String taskid;
  @override
  _SurveyInfoPageState createState() => _SurveyInfoPageState();
}

class _SurveyInfoPageState extends State<SurveyInfoPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  Widget formheader({String headerlablekey}) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(177, 201, 224, 1),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            setapptext(key: headerlablekey),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget nextbutton() {
    return GestureDetector(
      onTap: () async {
        if (!(_formkey.currentState.validate())) {
          return;
        } else {
          _formkey.currentState.save();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => GeneralInfoOnePage(
                localdata: localdata,
              ),
            ),
          );
        }
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Text(
              "Next",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  Widget completedcheckbox({bool isCompleted}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          //color: Colors.white,
          shape: BoxShape.rectangle,
          border: Border.all(
              color: isCompleted ? Colors.lightGreen : Colors.black, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: BoxDecoration(
              color: isCompleted ? Colors.lightGreen : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    localdata = new LocalPropertySurvey();
    localdata.taskid = widget.taskid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Property Survey",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<DBHelper>(
        builder: (context, dbdata, child) {
          return dbdata.state == AppState.Busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //header
                        formheader(headerlablekey: 'key_provider_details'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield(
                                  headerlablekey: setapptext(key:'key_first_surveyor'),
                                  radiovalue:
                                      localdata.first_surveyor_name?.isEmpty ??
                                              true
                                          ? false
                                          : true,
                                  hinttextkey: setapptext(key:'key_enter_1st_surveyor'),
                                  initvalue:
                                      localdata.first_surveyor_name?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.first_surveyor_name,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return "field should not be blank";
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.first_surveyor_name =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.first_surveyor_name =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  headerlablekey: setapptext(key:'key_second_surveyor'),
                                  radiovalue:
                                      localdata.senond_surveyor_name?.isEmpty ??
                                              true
                                          ? false
                                          : true,
                                  hinttextkey: setapptext(key:'key_enter_1st_surveyor'),
                                  initvalue:
                                      localdata.senond_surveyor_name?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.senond_surveyor_name,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return "field should not be blank";
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.senond_surveyor_name =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.senond_surveyor_name =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  headerlablekey: setapptext(key:'key_name_technical_support'),
                                  radiovalue: localdata.technical_support_name
                                              ?.isEmpty ??
                                          true
                                      ? false
                                      : true,
                                  hinttextkey: setapptext(key:'key_enter_1st_surveyor'),
                                  initvalue: localdata.technical_support_name
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.technical_support_name,
                                  onSaved: (value) {
                                    localdata.technical_support_name =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.technical_support_name =
                                        value.trim();
                                    setState(() {});
                                  }),
                            ],
                          ),
                        ),

                        //footer
                        Container(
                          child: Column(
                            children: <Widget>[
                              Divider(
                                color: Colors.blueAccent,
                              ),
                              Container(
                                color: Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      //back button
                                      SizedBox(),
                                      //next button
                                      nextbutton()
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
