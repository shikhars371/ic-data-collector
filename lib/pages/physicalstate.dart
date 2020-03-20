import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../utils/appstate.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './propertylocation.dart';
import './generalinfotwo.dart';

class PhysicalStatePropertyPage extends StatefulWidget {
  PhysicalStatePropertyPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _PhysicalStatePropertyState createState() => _PhysicalStatePropertyState();
}

class _PhysicalStatePropertyState extends State<PhysicalStatePropertyPage> {
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
              PageTransition(
                  child: PropertyLocationPage(
                    localdata: localdata,
                  ),
                  type: PageTransitionType.rightToLeft));
        }
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Text(
              setapptext(key: 'key_next'),
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white),
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
            PageTransition(
                child: GeneralInfotwoPage(
                  localdata: localdata,
                ),
                type: PageTransitionType.leftToRight));
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Icon(Icons.arrow_back_ios, color: Colors.white),
            Text(
              setapptext(key: 'key_back'),
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
          setapptext(key: 'key_property_survey'),
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
                        formheader(headerlablekey: 'key_physical_state'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formCardDropdown(
                                fieldrequired: true,
                                  enable:
                                      localdata.isdrafted == 2 ? true : false,
                                  value:
                                      localdata.status_of_area_plan?.isEmpty ??
                                              true
                                          ? "0"
                                          : localdata.status_of_area_plan,
                                  iscompleted: ((localdata.status_of_area_plan
                                                  ?.isEmpty ??
                                              true) ||
                                          (localdata.status_of_area_plan ==
                                              "0"))
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  headerlablekey:
                                      setapptext(key: 'key_specify_the'),
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_plan'),
                                        value: "1"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_unplan'),
                                        value: "2"),
                                  ],
                                  onSaved: (String value) {
                                    localdata.status_of_area_plan = value;
                                  },
                                  onChanged: (value) {
                                    localdata.status_of_area_plan = value;
                                    setState(() {});
                                  },
                                  validate: (value) {
                                    if ((value.isEmpty) || value == "0") {
                                      return setapptext(key: 'key_required');
                                    }
                                  }),
                              formCardDropdown(
                                fieldrequired: true,
                                  enable:
                                      localdata.isdrafted == 2 ? true : false,
                                  value: localdata.status_of_area_official
                                              ?.isEmpty ??
                                          true
                                      ? "0"
                                      : localdata.status_of_area_official,
                                  iscompleted: ((localdata
                                                  .status_of_area_official
                                                  ?.isEmpty ??
                                              true) ||
                                          (localdata.status_of_area_official ==
                                              "0"))
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  headerlablekey:
                                      setapptext(key: 'key_Property_Rights'),
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_official'),
                                        value: "1"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_unofficial'),
                                        value: "2")
                                  ],
                                  onSaved: (String value) {
                                    localdata.status_of_area_official = value;
                                  },
                                  onChanged: (value) {
                                    localdata.status_of_area_official = value;
                                    setState(() {});
                                  },
                                  validate: (value) {
                                    if ((value.isEmpty) || value == "0") {
                                      return setapptext(key: 'key_required');
                                    }
                                  }),
                              formCardDropdown(
                                fieldrequired: true,
                                  enable:
                                      localdata.isdrafted == 2 ? true : false,
                                  value: localdata.status_of_area_regular
                                              ?.isEmpty ??
                                          true
                                      ? "0"
                                      : localdata.status_of_area_regular,
                                  iscompleted: ((localdata
                                                  .status_of_area_regular
                                                  ?.isEmpty ??
                                              true) ||
                                          (localdata.status_of_area_regular ==
                                              "0"))
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  headerlablekey:
                                      setapptext(key: 'key_Property_Type'),
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_regular'),
                                        value: "1"),
                                    Dpvalue(
                                        name:
                                            setapptext(key: 'key_Disorganized'),
                                        value: "2")
                                  ],
                                  onSaved: (String value) {
                                    localdata.status_of_area_regular = value;
                                  },
                                  onChanged: (value) {
                                    localdata.status_of_area_regular = value;
                                    setState(() {});
                                  },
                                  validate: (value) {
                                    if ((value.isEmpty) || (value == "0")) {
                                      return setapptext(key: 'key_required');
                                    }
                                  }),
                              formCardDropdown(
                                fieldrequired: true,
                                  enable:
                                      localdata.isdrafted == 2 ? true : false,
                                  value:
                                      localdata.slope_of_area?.isEmpty ?? true
                                          ? "0"
                                          : localdata.slope_of_area,
                                  iscompleted:
                                      ((localdata.slope_of_area?.isEmpty ??
                                                  true) ||
                                              (localdata.slope_of_area == "0"))
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  headerlablekey:
                                      setapptext(key: 'key_specify_slope'),
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_Smooth'),
                                        value: "1"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_slope_30'),
                                        value: "2"),
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_slope_above_30'),
                                        value: "3"),
                                  ],
                                  onSaved: (String value) {
                                    localdata.slope_of_area = value;
                                  },
                                  onChanged: (value) {
                                    localdata.slope_of_area = value;
                                    setState(() {});
                                  },
                                  validate: (value) {
                                    if ((value.isEmpty) || value == "0") {
                                      return setapptext(key: 'key_required');
                                    }
                                  }),
                              SizedBox(
                                height: 50,
                              )
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
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
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
