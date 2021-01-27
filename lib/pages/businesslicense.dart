import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './firstpartnerinfo.dart';
import './typeofuse.dart';
import './propertydetails.dart';
import '../utils/appstate.dart';

class BusinessLicensePage extends StatefulWidget {
  BusinessLicensePage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _BusinessLicensePageState createState() => _BusinessLicensePageState();
}

class _BusinessLicensePageState extends State<BusinessLicensePage> {
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
          if (localdata.isdrafted != 2) {
            await DBHelper()
                .updatePropertySurvey(localdata, localdata.local_property_key);
          }
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: FirstPartnerPage(
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
        if (localdata.property_have_document == "1") {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: TypeOfUsePage(
                    localdata: localdata,
                  ),
                  type: PageTransitionType.leftToRight));
        } else {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: PropertyDetailsPage(
                    localdata: localdata,
                  ),
                  type: PageTransitionType.leftToRight));
        }
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
                        formheader(headerlablekey: 'key_business_licence'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield(
                                  maxLength: 9,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  keyboardtype: TextInputType.number,
                                  headerlablekey:
                                      setapptext(key: 'key_how_many_business'),
                                  radiovalue: localdata.number_of_business_unit
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  initvalue: localdata.number_of_business_unit
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.number_of_business_unit,
                                  // hinttextkey:
                                  //     setapptext(key: 'key_enter_1st_surveyor'),
                                  onSaved: (value) {
                                    localdata.number_of_business_unit =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.number_of_business_unit =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 9,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  keyboardtype: TextInputType.number,
                                  headerlablekey: setapptext(
                                      key: 'key_howmany_business_license'),
                                  radiovalue: localdata
                                              .business_unit_have_no_license
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  initvalue: localdata
                                              .business_unit_have_no_license
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.business_unit_have_no_license,
                                  // hinttextkey:
                                  //     setapptext(key: 'key_enter_1st_surveyor'),
                                  onSaved: (value) {
                                    localdata.business_unit_have_no_license =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.business_unit_have_no_license =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey: setapptext(key: 'key_other1'),
                                  radiovalue: localdata.business_license_another
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  initvalue: localdata.business_license_another
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.business_license_another,
                                  // hinttextkey:
                                  //     setapptext(key: 'key_enter_1st_surveyor'),
                                  onSaved: (value) {
                                    localdata.business_license_another =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.business_license_another =
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
