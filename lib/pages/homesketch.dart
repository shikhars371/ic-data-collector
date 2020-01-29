import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './detailnumberarea.dart';
import './task.dart';

class HomeSketchPage extends StatefulWidget {
  HomeSketchPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _HomeSketchPageState createState() => _HomeSketchPageState();
}

class _HomeSketchPageState extends State<HomeSketchPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  FocusNode _area_unit_release_area;
FocusNode _area_unit_business_area;
FocusNode _area_unit_total_no_unit;
FocusNode _area_unit_business_units;

  Future<String> appimagepicker() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    var apppath = await getApplicationDocumentsDirectory();
    var filename = image.path.split("/").last;
    var localfile = await image.copy('${apppath.path}/$filename');
    return localfile.path;
  }

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
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>),);
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
            builder: (BuildContext context) => DetailsNumberAreaPage(
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
    _area_unit_release_area = new FocusNode();
_area_unit_business_area = new FocusNode();
_area_unit_total_no_unit = new FocusNode();
_area_unit_business_units = new FocusNode();

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
                        formheader(headerlablekey: 'key_final_details'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield(
                                  initvalue: localdata.area_unit_release_area
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.area_unit_release_area,
                                  headerlablekey: setapptext(key: 'key_release_area'),
                                  fieldfocus: _area_unit_release_area,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _area_unit_release_area.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_area_unit_business_area);
                                  },
                                  radiovalue: localdata.area_unit_release_area
                                              ?.isEmpty ??
                                          true
                                      ? false
                                      : true,
                                  onSaved: (value) {
                                    localdata.area_unit_release_area = value;
                                  },
                                  onChanged: (value) {
                                    localdata.area_unit_release_area = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  initvalue: localdata.area_unit_business_area
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.area_unit_business_area,
                                  headerlablekey: setapptext(key: 'key_business_area'),
                                  fieldfocus: _area_unit_business_area,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _area_unit_business_area.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_area_unit_total_no_unit);
                                  },
                                  radiovalue: localdata.area_unit_business_area
                                              ?.isEmpty ??
                                          true
                                      ? false
                                      : true,
                                  onSaved: (value) {
                                    localdata.area_unit_business_area = value;
                                  },
                                  onChanged: (value) {
                                    localdata.area_unit_business_area = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  initvalue: localdata.area_unit_total_no_unit
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.area_unit_total_no_unit,
                                  headerlablekey: setapptext(key: 'key_total_release_units'),
                                  fieldfocus: _area_unit_total_no_unit,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _area_unit_total_no_unit.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_area_unit_business_units);
                                  },
                                  radiovalue: localdata.area_unit_total_no_unit
                                              ?.isEmpty ??
                                          true
                                      ? false
                                      : true,
                                  onSaved: (value) {
                                    localdata.area_unit_total_no_unit = value;
                                  },
                                  onChanged: (value) {
                                    localdata.area_unit_total_no_unit = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  initvalue: localdata.area_unit_business_units
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.area_unit_business_units,
                                  headerlablekey: setapptext(key: 'key_total_business_unit'),
                                   fieldfocus: _area_unit_business_units,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _area_unit_business_units.unfocus(); },

                                  radiovalue: localdata.area_unit_business_units
                                              ?.isEmpty ??
                                          true
                                      ? false
                                      : true,
                                  onSaved: (value) {
                                    localdata.area_unit_business_units = value;
                                  },
                                  onChanged: (value) {
                                    localdata.area_unit_business_units = value;
                                    setState(() {});
                                  }),
                              GestureDetector(
                                onTap: () async {
                                  _formkey.currentState.save();
                                  localdata.other_key = "1";
                                  await DBHelper().updatePropertySurvey(
                                      localdata, localdata.local_property_key);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            TaskPage()),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 5.0,
                                              color: Colors.black)
                                        ],
                                        color: Colors.blue),
                                    margin: EdgeInsets.only(
                                      left:
                                          MediaQuery.of(context).size.width / 5,
                                      right:
                                          MediaQuery.of(context).size.width / 5,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      //back button
                                      backbutton(),
                                      //next button
                                      SizedBox()
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
