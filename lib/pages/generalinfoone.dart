import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './generalinfotwo.dart';
import './surveyinfo.dart';

class GeneralInfoOnePage extends StatefulWidget {
  GeneralInfoOnePage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _GeneralInfoOnePageState createState() => _GeneralInfoOnePageState();
}

class _GeneralInfoOnePageState extends State<GeneralInfoOnePage> {
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
              builder: (BuildContext context) => GeneralInfotwoPage(
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

  Widget backbutton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SurveyInfoPage(
              localdata: localdata,
            ),
          ),
        );
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Icon(Icons.arrow_back_ios),
            Text(
              "Back",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    localdata = new LocalPropertySurvey();
    localdata = widget.localdata;
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
                        formheader(headerlablekey: 'key_general_info1'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formCardDropdown(
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_yes_sir'),
                                        value: "1"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_no'),
                                        value: "2")
                                  ],
                                  iscompleted: ((localdata
                                                  .property_dispte_subject_to
                                                  ?.isEmpty ??
                                              true) ||
                                          (localdata
                                                  .property_dispte_subject_to ==
                                              "0"))
                                      ? false
                                      : true,
                                  headerlablekey:
                                      setapptext(key: 'key_property_disputes'),
                                  value: localdata.property_dispte_subject_to
                                              ?.isEmpty ??
                                          true
                                      ? "0"
                                      : localdata.property_dispte_subject_to,
                                  onSaved: (String value) {
                                    localdata.property_dispte_subject_to =
                                        value;
                                  },
                                  onChanged: (value) {
                                    localdata.property_dispte_subject_to =
                                        value;
                                    setState(() {});
                                  },
                                  validate: (value) {
                                    if ((value.isEmpty) || value == "0") {
                                      return "required";
                                    }
                                  }),
                              formCardDropdown(
                                  iscompleted: ((localdata.real_person_status
                                                  ?.isEmpty ??
                                              true) ||
                                          (localdata.real_person_status == "0"))
                                      ? false
                                      : true,
                                  headerlablekey:
                                      setapptext(key: 'key_real_person'),
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_present'),
                                        value: "1"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_absence'),
                                        value: "3"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_died'),
                                        value: "2")
                                  ],
                                  onSaved: (String value) {
                                    localdata.real_person_status = value;
                                  },
                                  value:
                                      localdata.real_person_status?.isEmpty ??
                                              true
                                          ? "0"
                                          : localdata.real_person_status,
                                  onChanged: (value) {
                                    localdata.real_person_status = value;
                                    setState(() {});
                                  },
                                  validate: (value) {
                                    if ((value.isEmpty) || value == "0") {
                                      return "required";
                                    }
                                  }),
                              formCardDropdown(
                                  iscompleted: ((localdata.cityzenship_notice
                                                  ?.isEmpty ??
                                              true) ||
                                          (localdata.cityzenship_notice == "0"))
                                      ? false
                                      : true,
                                  headerlablekey:
                                      setapptext(key: 'key_is_citizenship'),
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_yes_sir'),
                                        value: "1"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_no'),
                                        value: "2")
                                  ],
                                  onSaved: (String value) {
                                    localdata.cityzenship_notice = value;
                                  },
                                  value:
                                      localdata.cityzenship_notice?.isEmpty ??
                                              true
                                          ? "0"
                                          : localdata.cityzenship_notice,
                                  onChanged: (value) {
                                    localdata.cityzenship_notice = value;
                                    setState(() {});
                                  },
                                  validate: (value) {
                                    if ((value.isEmpty) || value == "0") {
                                      return "required";
                                    }
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
                                      backbutton(),
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
