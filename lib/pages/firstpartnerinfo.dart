import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './infophotonint.dart';
import './businesslicense.dart';
import './typeofuse.dart';
import './propertydetails.dart';

class FirstPartnerPage extends StatefulWidget {
  FirstPartnerPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _FirstPartnerPageState createState() => _FirstPartnerPageState();
}

class _FirstPartnerPageState extends State<FirstPartnerPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  FocusNode _first_partner_name_property_owner;
  FocusNode _first_partner_surname;
  FocusNode _first_partner_boy;
  FocusNode _first_partner__father;
  FocusNode _first_partner_name_phone;
  FocusNode _first_partner_name_email;

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
            MaterialPageRoute(
              builder: (BuildContext context) => InfoPhotoHintPage(
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
              setapptext(key: 'key_next'),
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
            ),
            Icon(Icons.arrow_forward_ios,color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget backbutton() {
    return GestureDetector(
      onTap: () {
        if (localdata.property_have_document == "1") {
          if ((localdata.current_use_of_property == "2") ||
              (localdata.current_use_of_property == "3")) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BusinessLicensePage(
                  localdata: localdata,
                ),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => TypeOfUsePage(
                  localdata: localdata,
                ),
              ),
            );
          }
        } else {
          if ((localdata.current_use_of_property == "2") ||
              (localdata.current_use_of_property == "3")) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BusinessLicensePage(
                  localdata: localdata,
                ),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => PropertyDetailsPage(
                  localdata: localdata,
                ),
              ),
            );
          }
        }
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Icon(Icons.arrow_back_ios,color: Colors.white),
            Text(
              setapptext(key: 'key_back'),
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
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
    _first_partner_name_property_owner = new FocusNode();
    _first_partner_surname = new FocusNode();
    _first_partner_boy = new FocusNode();
    _first_partner__father = new FocusNode();
    _first_partner_name_phone = new FocusNode();
    _first_partner_name_email = new FocusNode();
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
                        formheader(headerlablekey: 'key_first_partner'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield(
                                  headerlablekey: setapptext(key: 'key_name'),
                                  fieldfocus:
                                      _first_partner_name_property_owner,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _first_partner_name_property_owner
                                        .unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_first_partner_surname);
                                  },
                                  radiovalue:
                                      localdata.first_partner_name?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  initvalue:
                                      localdata.first_partner_name?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.first_partner_name,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return setapptext(
                                          key: 'key_field_not_blank');
                                    } else if (!RegExp(r'^[a-zA-Z_ ]*$')
                                        .hasMatch(value)) {
                                      return setapptext(
                                          key: 'key_text_format_error');
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.first_partner_name = value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.first_partner_name = value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  headerlablekey:
                                      setapptext(key: 'key_surname'),
                                  fieldfocus: _first_partner_surname,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _first_partner_surname.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_first_partner_boy);
                                  },
                                  radiovalue: localdata
                                              .first_partner_surname?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  initvalue: localdata
                                              .first_partner_surname?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.first_partner_surname,
                                  validator: (value) {
                                    if (!RegExp(r'^[a-zA-Z_ ]*$')
                                        .hasMatch(value)) {
                                      return setapptext(
                                          key: 'key_text_format_error');
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.first_partner_surname =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.first_partner_surname =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  headerlablekey: setapptext(key: 'key_wold'),
                                  fieldfocus: _first_partner_boy,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _first_partner_boy.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_first_partner__father);
                                  },
                                  radiovalue:
                                      localdata.first_partner_boy?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  initvalue:
                                      localdata.first_partner_boy?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.first_partner_boy,
                                  validator: (value) {
                                    if (!RegExp(r'^[a-zA-Z_ ]*$')
                                        .hasMatch(value)) {
                                      return setapptext(
                                          key: 'key_text_format_error');
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.first_partner_boy = value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.first_partner_boy = value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  headerlablekey: setapptext(key: 'key_birth'),
                                  fieldfocus: _first_partner__father,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _first_partner__father.unfocus();
                                  },
                                  radiovalue: localdata
                                              .first_partner__father?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  initvalue: localdata
                                              .first_partner__father?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.first_partner__father,
                                  validator: (value) {
                                    if (!RegExp(r'^[a-zA-Z_ ]*$')
                                        .hasMatch(value)) {
                                      return setapptext(
                                          key: 'key_text_format_error');
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.first_partner__father =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.first_partner__father =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formCardDropdown(
                                  value: localdata.first_partner_name_gender
                                              ?.isEmpty ??
                                          true
                                      ? "0"
                                      : localdata.first_partner_name_gender,
                                  iscompleted: ((localdata
                                                  .first_partner_name_gender
                                                  ?.isEmpty ??
                                              true) ||
                                          (localdata
                                                  .first_partner_name_gender ==
                                              "0"))
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  headerlablekey: setapptext(key: 'key_gender'),
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_male'),
                                        value: "1"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_female'),
                                        value: "2"),
                                  ],
                                  onSaved: (String value) {
                                    localdata.first_partner_name_gender = value;
                                  },
                                  onChanged: (value) {
                                    localdata.first_partner_name_gender = value;
                                    setState(() {});
                                  },
                                  validate: (value) {
                                    if ((value.isEmpty) || value == "0") {
                                      return setapptext(key: 'key_required');
                                    }
                                  }),
                              formcardtextfield(
                                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                                  keyboardtype: TextInputType.number,
                                  headerlablekey: setapptext(key: 'key_phone'),
                                  fieldfocus: _first_partner_name_phone,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _first_partner_name_phone.unfocus();
                                    FocusScope.of(context).requestFocus(
                                        _first_partner_name_email);
                                  },
                                  radiovalue: localdata.first_partner_name_phone
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  initvalue: localdata.first_partner_name_phone
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.first_partner_name_phone,
                                  onSaved: (value) {
                                    localdata.first_partner_name_phone =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.first_partner_name_phone =
                                        value.trim();
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (value.length != 10) {
                                        return setapptext(
                                            key: 'key_mobile_field');
                                      }
                                    }
                                  }),
                              formcardtextfield(
                                  keyboardtype: TextInputType.emailAddress,
                                  headerlablekey: setapptext(key: 'key_email'),
                                  fieldfocus: _first_partner_name_email,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _first_partner_name_email.unfocus();
                                  },
                                  radiovalue: localdata.first_partner_name_email
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  initvalue: localdata.first_partner_name_email
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.first_partner_name_email,
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      Pattern pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value))
                                        return setapptext(
                                            key: 'key_email_field');
                                      else
                                        return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.first_partner_name_email =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.first_partner_name_email =
                                        value.trim();
                                    setState(() {});
                                  }),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: localdata
                                                            .first_partner_name_property_owner
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_owner'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(setapptext(
                                                      key:
                                                          'key_capture_image')),
                                                  onPressed: () async {
                                                    localdata
                                                            .first_partner_name_property_owner =
                                                        await appimagepicker();
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: localdata
                                                        .first_partner_name_property_owner
                                                        ?.isEmpty ??
                                                    true
                                                ? Center(
                                                    child: Text(
                                                      setapptext(
                                                          key: 'key_no_image'),
                                                    ),
                                                  )
                                                : File(localdata
                                                            .first_partner_name_property_owner)
                                                        .existsSync()
                                                    ? Image.file(File(localdata
                                                        .first_partner_name_property_owner))
                                                    : Center(
                                                        child: Text(
                                                          setapptext(
                                                              key:
                                                                  'key_no_image'),
                                                        ),
                                                      ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              formcardtextfield(
                                  headerlablekey:
                                      setapptext(key: 'key_enter_any_mere'),
                                  radiovalue: localdata
                                              .first_partner_name_mere_individuals
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  initvalue: localdata
                                              .first_partner_name_mere_individuals
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata
                                          .first_partner_name_mere_individuals,
                                  onSaved: (value) {
                                    localdata
                                            .first_partner_name_mere_individuals =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata
                                            .first_partner_name_mere_individuals =
                                        value.trim();
                                    setState(() {});
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
