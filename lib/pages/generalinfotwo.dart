import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './physicalstate.dart';
import './generalinfoone.dart';

class GeneralInfotwoPage extends StatefulWidget {
  GeneralInfotwoPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _GeneralInfotwoPageState createState() => _GeneralInfotwoPageState();
}

class _GeneralInfotwoPageState extends State<GeneralInfotwoPage> {
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
              builder: (BuildContext context) => PhysicalStatePropertyPage(
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
            builder: (BuildContext context) => GeneralInfoOnePage(
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
                        formheader(headerlablekey: 'key_general_info_2'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield(
                                  initvalue: localdata.issue_regarding_property
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.issue_regarding_property,
                                  headerlablekey:
                                      setapptext(key: 'key_property_issues'),
                                  radiovalue: localdata.issue_regarding_property
                                              ?.isEmpty ??
                                          true
                                      ? false
                                      : true,
                                  onSaved: (value) {
                                    localdata.issue_regarding_property =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.issue_regarding_property =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  initvalue: localdata.municipality_ref_number
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.municipality_ref_number,
                                  headerlablekey: setapptext(
                                      key: 'key_municipal_regulation'),
                                  radiovalue: localdata.municipality_ref_number
                                              ?.isEmpty ??
                                          true
                                      ? false
                                      : true,
                                  onSaved: (value) {
                                    localdata.municipality_ref_number =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.municipality_ref_number =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formCardDropdown(
                                  iscompleted:
                                      localdata.natural_threaten?.isEmpty ??
                                              true
                                          ? false
                                          : true,
                                  value: localdata.natural_threaten?.isEmpty ??
                                          true
                                      ? "0"
                                      : localdata.natural_threaten,
                                  headerlablekey:
                                      setapptext(key: 'key_natural_factor'),
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
                                    localdata.natural_threaten = value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.natural_threaten = value.trim();
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
