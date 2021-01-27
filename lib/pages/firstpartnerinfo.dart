import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kapp/pages/fourlimit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../utils/appstate.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './infophotonint.dart';
import './businesslicense.dart';
import './typeofuse.dart';
import './propertydetails.dart';
import './otherpartnerinfo.dart';
import '../utils/language_service.dart';
import '../utils/locator.dart';

class FirstPartnerPage extends StatefulWidget {
  FirstPartnerPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _FirstPartnerPageState createState() => _FirstPartnerPageState();
}

class _FirstPartnerPageState extends State<FirstPartnerPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  String tempemailholder = "";
  TextEditingController emailController;

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
          if (localdata.cityzenship_notice == "2") {
            if (localdata.property_type == "2") {
              Navigator.pushReplacement(
                context,
                PageTransition(
                    child: OtherPartnerInfoPage(
                      localdata: localdata,
                    ),
                    type: PageTransitionType.rightToLeft),
              );
            } else {
              Navigator.pushReplacement(
                context,
                PageTransition(
                    child: FourLimitPage(
                      localdata: localdata,
                    ),
                    type: PageTransitionType.rightToLeft),
              );
            }
          } else {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: InfoPhotoHintPage(
                      localdata: localdata,
                    ),
                    type: PageTransitionType.rightToLeft));
          }
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
          if ((localdata.current_use_of_property == "2") ||
              (localdata.current_use_of_property == "3")) {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: BusinessLicensePage(
                      localdata: localdata,
                    ),
                    type: PageTransitionType.leftToRight));
          } else {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: TypeOfUsePage(
                      localdata: localdata,
                    ),
                    type: PageTransitionType.leftToRight));
          }
        } else {
          if ((localdata.current_use_of_property == "2") ||
              (localdata.current_use_of_property == "3")) {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: BusinessLicensePage(
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
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    localdata = new LocalPropertySurvey();
    localdata = widget.localdata;
    emailController = new TextEditingController(
        text: localdata.first_partner_name_email?.isEmpty ?? true
            ? ""
            : localdata.first_partner_name_email);
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
                        formheader(headerlablekey: 'key_first_partner'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey: setapptext(key: 'key_name'),
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
                                  fieldrequired: true,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return setapptext(
                                          key: 'key_field_not_blank');
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
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey:
                                      setapptext(key: 'key_surname'),
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
                                  validator: (value) {},
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
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey: setapptext(key: 'key_wold'),
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
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.first_partner_boy = value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.first_partner_boy = value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey: setapptext(key: 'key_birth'),
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
                                  validator: (value) {},
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
                                  fieldrequired: true,
                                  enable:
                                      localdata.isdrafted == 2 ? true : false,
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
                                  maxLength: 10,
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  keyboardtype: TextInputType.number,
                                  headerlablekey: setapptext(key: 'key_phone'),
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
                              // formcardtextfield(
                              //     controller: emailController,
                              //     maxLength: 120,
                              //     enable:
                              //         localdata.isdrafted == 2 ? false : true,
                              //     keyboardtype: TextInputType.emailAddress,
                              //     headerlablekey: setapptext(key: 'key_email'),
                              //     radiovalue: localdata.first_partner_name_email
                              //                 ?.isEmpty ??
                              //             true
                              //         ? CheckColor.Black
                              //         : CheckColor.Green,
                              //     // initvalue: localdata.first_partner_name_email
                              //     //             ?.isEmpty ??
                              //     //         true
                              //     //     ? ""
                              //     //     : localdata.first_partner_name_email,
                              //     validator: (value) {
                              //       if (!(value?.isEmpty ?? true)) {
                              //         Pattern pattern =
                              //             r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              //         RegExp regex = new RegExp(pattern);
                              //         if (!regex.hasMatch(value))
                              //           return setapptext(
                              //               key: 'key_email_field');
                              //         else
                              //           return null;
                              //       }
                              //     },
                              //     onSaved: (value) {
                              //       localdata.first_partner_name_email =
                              //           value.trim();
                              //     },
                              //     onChanged: (value) {
                              //       localdata.first_partner_name_email =
                              //           value.trim();
                              //       setState(() {});
                              //     },
                              //     onFieldSubmitted: (value) {
                              //       localdata.first_partner_name_email =
                              //           value.trim();
                              //       setState(() {});
                              //     }),
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
                                          textDirection:
                                              locator<LanguageService>()
                                                          .currentlanguage ==
                                                      0
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: localdata
                                                            .first_partner_name_email
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            SizedBox(),
                                            Flexible(
                                              child: Container(
                                                child: Text(
                                                  setapptext(key: 'key_email'),
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true,
                                                  style: TextStyle(),
                                                  textDirection:
                                                      locator<LanguageService>()
                                                                  .currentlanguage ==
                                                              0
                                                          ? TextDirection.ltr
                                                          : TextDirection.rtl,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: TextFormField(
                                            autofocus: false,
                                            textDirection:
                                                locator<LanguageService>()
                                                            .currentlanguage ==
                                                        0
                                                    ? TextDirection.ltr
                                                    : TextDirection.rtl,
                                            enabled: localdata.isdrafted == 2
                                                ? false
                                                : true,
                                            keyboardType:
                                                TextInputType.emailAddress,

                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent),
                                            ),
                                            onSaved: (value) {
                                              localdata
                                                      .first_partner_name_email =
                                                  value.trim();
                                            },
                                            validator: (value) {
                                              if (!(value?.isEmpty ?? true)) {
                                                Pattern pattern =
                                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                                RegExp regex =
                                                    new RegExp(pattern);
                                                if (!regex.hasMatch(value))
                                                  return setapptext(
                                                      key: 'key_email_field');
                                                else
                                                  return null;
                                              }
                                            },
                                            onChanged: (value) {
                                              localdata
                                                      .first_partner_name_email =
                                                  value.trim();
                                              setState(() {});
                                            },
                                            onFieldSubmitted: (value) {
                                              localdata
                                                      .first_partner_name_email =
                                                  value.trim();
                                              setState(() {});
                                            },
                                            maxLength: 120,
                                            controller: emailController,

                                            ///WhitelistingTextInputFormatter.digitsOnly
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
                                                  onPressed:
                                                      localdata.isdrafted == 2
                                                          ? null
                                                          : () async {
                                                              tempemailholder =
                                                                  localdata
                                                                      .first_partner_name_email;

                                                              showModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Container(
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.all(8),
                                                                            //decoration: BoxDecoration(color: Colors.blue),
                                                                            child:
                                                                                Text(
                                                                              "Pick the image",
                                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                          Divider(),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              localdata.first_partner_name_property_owner = await appimagepicker(source: ImageSource.camera);
                                                                              Navigator.pop(context);
                                                                              setState(() {});
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              "Use Camera",
                                                                              style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                            ),
                                                                          ),
                                                                          Divider(),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              localdata.first_partner_name_property_owner = await appimagepicker(source: ImageSource.gallery);
                                                                              Navigator.pop(context);
                                                                              setState(() {});
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              "Use Gallery",
                                                                              style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                20,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  });

                                                              setState(() {});
                                                              localdata
                                                                      .first_partner_name_email =
                                                                  tempemailholder;
                                                              emailController
                                                                      .text =
                                                                  tempemailholder;
                                                              setState(() {});
                                                            },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Center(
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
                                                            key:
                                                                'key_no_image'),
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
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              formcardtextfield(
                                  maxLength: 256,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
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
