import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './firstpartnerinfo.dart';

class BusinessLicensePage extends StatefulWidget {
  BusinessLicensePage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _BusinessLicensePageState createState() => _BusinessLicensePageState();
}

class _BusinessLicensePageState extends State<BusinessLicensePage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  FocusNode _number_of_business_unit;
FocusNode _business_unit_have_no_license;
FocusNode _business_license_another;

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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => FirstPartnerPage(
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
      onTap: () {},
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
    _number_of_business_unit = new FocusNode();
_business_unit_have_no_license = new FocusNode();
_business_license_another = new FocusNode();

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
                        formheader(headerlablekey: 'key_business_licence'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield(
                                  keyboardtype: TextInputType.number,
                                  headerlablekey:
                                      setapptext(key: 'key_how_many_business'),
                                      fieldfocus: _number_of_business_unit,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _number_of_business_unit.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_business_unit_have_no_license);
                                  },
                                  radiovalue: localdata.number_of_business_unit
                                              ?.isEmpty ??
                                          true
                                      ? false
                                      : true,
                                  initvalue: localdata.number_of_business_unit
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.number_of_business_unit,
                                  hinttextkey:
                                      setapptext(key: 'key_enter_1st_surveyor'),
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
                                  keyboardtype: TextInputType.number,
                                  headerlablekey: setapptext(
                                      key: 'key_howmany_business_license'),
                                      fieldfocus: _business_unit_have_no_license,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _business_unit_have_no_license.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_business_license_another);
                                  },
                                  radiovalue: localdata
                                              .business_unit_have_no_license
                                              ?.isEmpty ??
                                          true
                                      ? false
                                      : true,
                                  initvalue: localdata
                                              .business_unit_have_no_license
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.business_unit_have_no_license,
                                  hinttextkey:
                                      setapptext(key: 'key_enter_1st_surveyor'),
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
                                  headerlablekey:
                                      setapptext(key: 'key_Another'),
                                      fieldfocus: _business_license_another,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _business_license_another.unfocus(); },
                                  radiovalue: localdata.business_license_another
                                              ?.isEmpty ??
                                          true
                                      ? false
                                      : true,
                                  initvalue: localdata.business_license_another
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.business_license_another,
                                  hinttextkey:
                                      setapptext(key: 'key_enter_1st_surveyor'),
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
