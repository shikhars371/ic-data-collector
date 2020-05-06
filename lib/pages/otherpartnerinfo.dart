import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../models/localpropertydata.dart';
import '../utils/appstate.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './firstpartnerinfo.dart';
import './fourlimit.dart';
import './infophotonint.dart';

class OtherPartnerInfoPage extends StatefulWidget {
  OtherPartnerInfoPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _OtherPartnerInfoPageState createState() => _OtherPartnerInfoPageState();
}

class _OtherPartnerInfoPageState extends State<OtherPartnerInfoPage> {
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
                  child: FourLimitPage(
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
        if (localdata.cityzenship_notice == "2") {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: FirstPartnerPage(
                    localdata: localdata,
                  ),
                  type: PageTransitionType.leftToRight));
        } else {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: InfoPhotoHintPage(
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
                        formheader(
                            headerlablekey: 'key_Characteristics_of_earth'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              ///second partner details
                              ///start
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Center(
                                  child: Text(
                                    setapptext(key: 'key_second_partner_info'),
                                  ),
                                ),
                              ),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey: setapptext(key: 'key_name'),
                                  radiovalue:
                                      localdata.second_partner_name?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  initvalue:
                                      localdata.second_partner_name?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.second_partner_name,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.second_partner_name =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.second_partner_name =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey:
                                      setapptext(key: 'key_surname'),
                                  radiovalue: localdata.second_partner_surname
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  initvalue: localdata.second_partner_surname
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.second_partner_surname,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.second_partner_surname =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.second_partner_surname =
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
                                      localdata.second_partner_boy?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  initvalue:
                                      localdata.second_partner_boy?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.second_partner_boy,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.second_partner_boy = value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.second_partner_boy = value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey: setapptext(key: 'key_birth'),
                                  radiovalue: localdata
                                              .second_partner_father?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  initvalue: localdata
                                              .second_partner_father?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.second_partner_father,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.second_partner_father =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.second_partner_father =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formCardDropdown(
                                  enable:
                                      localdata.isdrafted == 2 ? true : false,
                                  value: localdata
                                              .second_partner_gender?.isEmpty ??
                                          true
                                      ? "0"
                                      : localdata.second_partner_gender,
                                  iscompleted: ((localdata.second_partner_gender
                                                  ?.isEmpty ??
                                              true) ||
                                          localdata.second_partner_gender ==
                                              "0")
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
                                    localdata.second_partner_gender = value;
                                  },
                                  onChanged: (value) {
                                    localdata.second_partner_gender = value;
                                    setState(() {});
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
                                  radiovalue:
                                      localdata.second_partner_phone?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  initvalue:
                                      localdata.second_partner_phone?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.second_partner_phone,
                                  onSaved: (value) {
                                    localdata.second_partner_phone =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.second_partner_phone =
                                        value.trim();
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (!(value.isEmpty ?? true)) {
                                      if (value.length != 10) {
                                        return setapptext(
                                            key: 'key_mobile_field');
                                      }
                                    }
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey: setapptext(key: 'key_email'),
                                  keyboardtype: TextInputType.emailAddress,
                                  radiovalue:
                                      localdata.second_partner_email?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  initvalue:
                                      localdata.second_partner_email?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.second_partner_email,
                                  validator: (value) {
                                    if (!(value.isEmpty ?? true)) {
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
                                    localdata.second_partner_email =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.second_partner_email =
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
                                                            .second_partner_image
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key:
                                                        'key_second_partner_photo'),
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
                                                                              localdata.second_partner_image = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.second_partner_image = await appimagepicker(source: ImageSource.gallery);
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
                                                          .second_partner_image
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .second_partner_image),
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
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .second_partner_machinegun_no
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.second_partner_machinegun_no,
                                  headerlablekey:
                                      setapptext(key: 'key_machine_gun'),
                                  radiovalue: localdata
                                              .second_partner_machinegun_no
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.second_partner_machinegun_no =
                                        value;
                                  },
                                  onChanged: (value) {
                                    localdata.second_partner_machinegun_no =
                                        value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.second_partner_cover_note
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.second_partner_cover_note,
                                  headerlablekey:
                                      setapptext(key: 'key_cover_letter'),
                                  radiovalue: localdata
                                              .second_partner_cover_note
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.second_partner_cover_note = value;
                                  },
                                  onChanged: (value) {
                                    localdata.second_partner_cover_note = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.second_partner_note_page
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.second_partner_note_page,
                                  headerlablekey:
                                      setapptext(key: 'key_notification_page'),
                                  radiovalue: localdata.second_partner_note_page
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.second_partner_note_page = value;
                                  },
                                  onChanged: (value) {
                                    localdata.second_partner_note_page = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .second_partner_reg_no?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.second_partner_reg_no,
                                  headerlablekey: setapptext(key: 'key_reg_no'),
                                  radiovalue: localdata
                                              .second_partner_reg_no?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.second_partner_reg_no = value;
                                  },
                                  onChanged: (value) {
                                    localdata.second_partner_reg_no = value;
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
                                                            .second_partner_phote_note1
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_note1'),
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
                                                                              localdata.second_partner_phote_note1 = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.second_partner_phote_note1 = await appimagepicker(source: ImageSource.gallery);
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
                                                          .second_partner_phote_note1
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .second_partner_phote_note1),
                                                    ),
                                            ),
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
                                                            .second_partner_photo_tips1
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips1'),
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
                                                                              localdata.second_partner_photo_tips1 = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.second_partner_photo_tips1 = await appimagepicker(source: ImageSource.gallery);
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
                                                          .second_partner_photo_tips1
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .second_partner_photo_tips1),
                                                    ),
                                            ),
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
                                                            .second_partner_photo_tips2
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips2'),
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
                                                                              localdata.second_partner_photo_tips2 = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.second_partner_photo_tips2 = await appimagepicker(source: ImageSource.gallery);
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
                                                          .second_partner_photo_tips2
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .second_partner_photo_tips2),
                                                    ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              ///end
                              ///third partner details
                              ///start
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Center(
                                  child: Text(
                                    setapptext(key: 'key_third_partner_info'),
                                  ),
                                ),
                              ),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.third_partner_name?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.third_partner_name,
                                  headerlablekey: setapptext(key: 'key_name'),
                                  radiovalue:
                                      localdata.third_partner_name?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.third_partner_name = value;
                                  },
                                  onChanged: (value) {
                                    localdata.third_partner_name = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .third_partner_surname?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.third_partner_surname,
                                  headerlablekey:
                                      setapptext(key: 'key_surname'),
                                  radiovalue: localdata
                                              .third_partner_surname?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.third_partner_surname = value;
                                  },
                                  onChanged: (value) {
                                    localdata.third_partner_surname = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.third_partner_boy?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.third_partner_boy,
                                  headerlablekey: setapptext(key: 'key_wold'),
                                  radiovalue:
                                      localdata.third_partner_boy?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.third_partner_boy = value;
                                  },
                                  onChanged: (value) {
                                    localdata.third_partner_boy = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.third_partner_father?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.third_partner_father,
                                  headerlablekey: setapptext(key: 'key_birth'),
                                  radiovalue:
                                      localdata.third_partner_father?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.third_partner_father = value;
                                  },
                                  onChanged: (value) {
                                    localdata.third_partner_father = value;
                                    setState(() {});
                                  }),
                              formCardDropdown(
                                  enable:
                                      localdata.isdrafted == 2 ? true : false,
                                  value:
                                      localdata.third_partner_gender?.isEmpty ??
                                              true
                                          ? "0"
                                          : localdata.third_partner_gender,
                                  iscompleted:
                                      localdata.third_partner_gender?.isEmpty ??
                                              true
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
                                    localdata.third_partner_gender = value;
                                  },
                                  onChanged: (value) {
                                    localdata.third_partner_gender = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 10,
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  initvalue:
                                      localdata.third_partner_phone?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.third_partner_phone,
                                  headerlablekey: setapptext(key: 'key_phone'),
                                  keyboardtype: TextInputType.number,
                                  radiovalue:
                                      localdata.third_partner_phone?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.third_partner_phone = value;
                                  },
                                  onChanged: (value) {
                                    localdata.third_partner_phone = value;
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (!(value.isEmpty ?? true)) {
                                      if (value.length != 10) {
                                        return setapptext(
                                            key: 'key_mobile_field');
                                      }
                                    }
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.third_partner_email?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.third_partner_email,
                                  headerlablekey: setapptext(key: 'key_email'),
                                  keyboardtype: TextInputType.emailAddress,
                                  radiovalue:
                                      localdata.third_partner_email?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.third_partner_email = value;
                                  },
                                  onChanged: (value) {
                                    localdata.third_partner_email = value;
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (!(value.isEmpty ?? true)) {
                                      Pattern pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value))
                                        return setapptext(
                                            key: 'key_email_field');
                                      else
                                        return null;
                                    }
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
                                                            .third_partner_image
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key:
                                                        'key_third_partner_photo'),
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
                                                                              localdata.third_partner_image = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.third_partner_image = await appimagepicker(source: ImageSource.gallery);
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
                                                          .third_partner_image
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .third_partner_image),
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
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .third_partner_machinegun_no
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.third_partner_machinegun_no,
                                  headerlablekey:
                                      setapptext(key: 'key_machine_gun'),
                                  radiovalue: localdata
                                              .third_partner_machinegun_no
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.third_partner_machinegun_no =
                                        value;
                                  },
                                  onChanged: (value) {
                                    localdata.third_partner_machinegun_no =
                                        value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.third_partner_cover_note
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.third_partner_cover_note,
                                  headerlablekey:
                                      setapptext(key: 'key_cover_letter'),
                                  radiovalue: localdata.third_partner_cover_note
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.third_partner_cover_note = value;
                                  },
                                  onChanged: (value) {
                                    localdata.third_partner_cover_note = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.third_partner_note_page
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.third_partner_note_page,
                                  headerlablekey:
                                      setapptext(key: 'key_notification_page'),
                                  radiovalue: localdata.third_partner_note_page
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.third_partner_note_page = value;
                                  },
                                  onChanged: (value) {
                                    localdata.third_partner_note_page = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.third_partner_reg_no?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.third_partner_reg_no,
                                  headerlablekey: setapptext(key: 'key_reg_no'),
                                  radiovalue:
                                      localdata.third_partner_reg_no?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.third_partner_reg_no = value;
                                  },
                                  onChanged: (value) {
                                    localdata.third_partner_reg_no = value;
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
                                                            .third_partner_phote_note1
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_note1'),
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
                                                                              localdata.third_partner_phote_note1 = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.third_partner_phote_note1 = await appimagepicker(source: ImageSource.gallery);
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
                                                          .third_partner_phote_note1
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .third_partner_phote_note1),
                                                    ),
                                            ),
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
                                                            .third_partner_photo_tips1
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips1'),
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
                                                                              localdata.third_partner_photo_tips1 = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.third_partner_photo_tips1 = await appimagepicker(source: ImageSource.gallery);
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
                                                          .third_partner_photo_tips1
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .third_partner_photo_tips1),
                                                    ),
                                            ),
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
                                                            .third_partner_photo_tips2
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips2'),
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
                                                                              localdata.third_partner_photo_tips2 = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.third_partner_photo_tips2 = await appimagepicker(source: ImageSource.gallery);
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
                                                          .third_partner_photo_tips2
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .third_partner_photo_tips2),
                                                    ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              ///end
                              ///fourth partner
                              ///start
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Center(
                                  child: Text(
                                    setapptext(key: 'key_fourth_partner_info'),
                                  ),
                                ),
                              ),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fourth_partner_name?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fourth_partner_name,
                                  headerlablekey: setapptext(key: 'key_name'),
                                  radiovalue:
                                      localdata.fourth_partner_name?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.fourth_partner_name = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fourth_partner_name = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.fourth_partner_surname
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fourth_partner_surname,
                                  headerlablekey:
                                      setapptext(key: 'key_surname'),
                                  radiovalue: localdata.fourth_partner_surname
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.fourth_partner_surname = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fourth_partner_surname = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fourth_partner_boy?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fourth_partner_boy,
                                  headerlablekey: setapptext(key: 'key_wold'),
                                  radiovalue:
                                      localdata.fourth_partner_boy?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.fourth_partner_boy = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fourth_partner_boy = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .fourth_partner_father?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fourth_partner_father,
                                  headerlablekey: setapptext(key: 'key_birth'),
                                  radiovalue: localdata
                                              .fourth_partner_father?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.fourth_partner_father = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fourth_partner_father = value;
                                    setState(() {});
                                  }),
                              formCardDropdown(
                                  enable:
                                      localdata.isdrafted == 2 ? true : false,
                                  value: localdata
                                              .fourth_partner_gender?.isEmpty ??
                                          true
                                      ? "0"
                                      : localdata.fourth_partner_gender,
                                  iscompleted: localdata
                                              .fourth_partner_gender?.isEmpty ??
                                          true
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
                                    localdata.fourth_partner_gender = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fourth_partner_gender = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 10,
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  initvalue:
                                      localdata.fourth_partner_phone?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fourth_partner_phone,
                                  headerlablekey: setapptext(key: 'key_phone'),
                                  keyboardtype: TextInputType.number,
                                  radiovalue:
                                      localdata.fourth_partner_phone?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.fourth_partner_phone = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fourth_partner_phone = value;
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (!(value.isEmpty ?? true)) {
                                      if (value.length != 10) {
                                        return setapptext(
                                            key: 'key_mobile_field');
                                      }
                                    }
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fourth_partner_email?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fourth_partner_email,
                                  headerlablekey: setapptext(key: 'key_email'),
                                  keyboardtype: TextInputType.emailAddress,
                                  radiovalue:
                                      localdata.fourth_partner_email?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.fourth_partner_email = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fourth_partner_email = value;
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (!(value.isEmpty ?? true)) {
                                      Pattern pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value))
                                        return setapptext(
                                            key: 'key_email_field');
                                      else
                                        return null;
                                    }
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
                                                            .fourth_partner_image
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key:
                                                        'key_fourth_partner_photo'),
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
                                                                              localdata.fourth_partner_image = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.fourth_partner_image = await appimagepicker(source: ImageSource.gallery);
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
                                                          .fourth_partner_image
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .fourth_partner_image),
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
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .fourth_partner_machinegun_no
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fourth_partner_machinegun_no,
                                  headerlablekey:
                                      setapptext(key: 'key_machine_gun'),
                                  radiovalue: localdata
                                              .fourth_partner_machinegun_no
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.fourth_partner_machinegun_no =
                                        value;
                                  },
                                  onChanged: (value) {
                                    localdata.fourth_partner_machinegun_no =
                                        value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.fourth_partner_cover_note
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fourth_partner_cover_note,
                                  headerlablekey:
                                      setapptext(key: 'key_cover_letter'),
                                  radiovalue: localdata
                                              .fourth_partner_cover_note
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.fourth_partner_cover_note = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fourth_partner_cover_note = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.fourth_partner_note_page
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fourth_partner_note_page,
                                  headerlablekey:
                                      setapptext(key: 'key_notification_page'),
                                  radiovalue: localdata.fourth_partner_note_page
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.fourth_partner_note_page = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fourth_partner_note_page = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .fourth_partner_reg_no?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fourth_partner_reg_no,
                                  headerlablekey: setapptext(key: 'key_reg_no'),
                                  radiovalue: localdata
                                              .fourth_partner_reg_no?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.fourth_partner_reg_no = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fourth_partner_reg_no = value;
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
                                                            .fourth_partner_phote_note1
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_note1'),
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
                                                                              localdata.fourth_partner_phote_note1 = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.fourth_partner_phote_note1 = await appimagepicker(source: ImageSource.gallery);
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
                                                          .fourth_partner_phote_note1
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .fourth_partner_phote_note1),
                                                    ),
                                            ),
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
                                                            .fourth_partner_photo_tips1
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips1'),
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
                                                                              localdata.fourth_partner_photo_tips1 = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.fourth_partner_photo_tips1 = await appimagepicker(source: ImageSource.gallery);
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
                                                          .fourth_partner_photo_tips1
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .fourth_partner_photo_tips1),
                                                    ),
                                            ),
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
                                                            .fourth_partner_photo_tips2
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips2'),
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
                                                                              localdata.fourth_partner_photo_tips2 = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.fourth_partner_photo_tips2 = await appimagepicker(source: ImageSource.gallery);
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
                                                          .fourth_partner_photo_tips2
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .fourth_partner_photo_tips2),
                                                    ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              ///end
                              ///fifth partnet deatils
                              ///start
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Center(
                                  child: Text(
                                    setapptext(key: 'key_fifth_partner_info'),
                                  ),
                                ),
                              ),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fifth_partner_name?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fifth_partner_name,
                                  headerlablekey: setapptext(key: 'key_name'),
                                  radiovalue:
                                      localdata.fifth_partner_name?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.fifth_partner_name = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fifth_partner_name = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .fifth_partner_surname?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fifth_partner_surname,
                                  headerlablekey:
                                      setapptext(key: 'key_surname'),
                                  radiovalue: localdata
                                              .fifth_partner_surname?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.fifth_partner_surname = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fifth_partner_surname = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fifth_partner_boy?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fifth_partner_boy,
                                  headerlablekey: setapptext(key: 'key_wold'),
                                  radiovalue:
                                      localdata.fifth_partner_boy?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.fifth_partner_boy = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fifth_partner_boy = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fifth_partner_father?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fifth_partner_father,
                                  headerlablekey: setapptext(key: 'key_birth'),
                                  radiovalue:
                                      localdata.fifth_partner_father?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.fifth_partner_father = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fifth_partner_father = value;
                                    setState(() {});
                                  }),
                              formCardDropdown(
                                  enable:
                                      localdata.isdrafted == 2 ? true : false,
                                  value:
                                      localdata.fifth_partner_gender?.isEmpty ??
                                              true
                                          ? "0"
                                          : localdata.fifth_partner_gender,
                                  iscompleted:
                                      localdata.fifth_partner_gender?.isEmpty ??
                                              true
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
                                    localdata.fifth_partner_gender = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fifth_partner_gender = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 10,
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  initvalue:
                                      localdata.fifth_partner_phone?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fifth_partner_phone,
                                  headerlablekey: setapptext(key: 'key_phone'),
                                  keyboardtype: TextInputType.number,
                                  radiovalue:
                                      localdata.fifth_partner_phone?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.fifth_partner_phone = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fifth_partner_phone = value;
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (!(value.isEmpty ?? true)) {
                                      if (value.length != 10) {
                                        return setapptext(
                                            key: 'key_mobile_field');
                                      }
                                    }
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fifth_partner_email?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fifth_partner_email,
                                  headerlablekey: setapptext(key: 'key_email'),
                                  keyboardtype: TextInputType.emailAddress,
                                  radiovalue:
                                      localdata.fifth_partner_email?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.fifth_partner_email = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fifth_partner_email = value;
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (!(value.isEmpty ?? true)) {
                                      Pattern pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value))
                                        return setapptext(
                                            key: 'key_email_field');
                                      else
                                        return null;
                                    }
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
                                                            .fifth_partner_image
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key:
                                                        'key_fifth_partner_photo'),
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
                                                                              localdata.fifth_partner_image = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.fifth_partner_image = await appimagepicker(source: ImageSource.gallery);
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
                                                          .fifth_partner_image
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .fifth_partner_image),
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
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .fifth_partner_machinegun_no
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fifth_partner_machinegun_no,
                                  headerlablekey:
                                      setapptext(key: 'key_machine_gun'),
                                  radiovalue: localdata
                                              .fifth_partner_machinegun_no
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.fifth_partner_machinegun_no =
                                        value;
                                  },
                                  onChanged: (value) {
                                    localdata.fifth_partner_machinegun_no =
                                        value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.fifth_partner_cover_note
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fifth_partner_cover_note,
                                  headerlablekey:
                                      setapptext(key: 'key_cover_letter'),
                                  radiovalue: localdata.fifth_partner_cover_note
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.fifth_partner_cover_note = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fifth_partner_cover_note = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.fifth_partner_note_page
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fifth_partner_note_page,
                                  headerlablekey:
                                      setapptext(key: 'key_notification_page'),
                                  radiovalue: localdata.fifth_partner_note_page
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.fifth_partner_note_page = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fifth_partner_note_page = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fifth_partner_reg_no?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fifth_partner_reg_no,
                                  headerlablekey: setapptext(key: 'key_reg_no'),
                                  radiovalue:
                                      localdata.fifth_partner_reg_no?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.fifth_partner_reg_no = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fifth_partner_reg_no = value;
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
                                                            .fifth_partner_phote_note1
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_note1'),
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
                                                                              localdata.fifth_partner_phote_note1 = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.fifth_partner_phote_note1 = await appimagepicker(source: ImageSource.gallery);
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
                                                          .fifth_partner_phote_note1
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .fifth_partner_phote_note1),
                                                    ),
                                            ),
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
                                                            .fifth_partner_photo_tips1
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips1'),
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
                                                                              localdata.fifth_partner_photo_tips1 = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.fifth_partner_photo_tips1 = await appimagepicker(source: ImageSource.gallery);
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
                                                          .fifth_partner_photo_tips1
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .fifth_partner_photo_tips1),
                                                    ),
                                            ),
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
                                                            .fifth_partner_photo_tips2
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_photo_tips2'),
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
                                                                              localdata.fifth_partner_photo_tips2 = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.fifth_partner_photo_tips2 = await appimagepicker(source: ImageSource.gallery);
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
                                                          .fifth_partner_photo_tips2
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .fifth_partner_photo_tips2),
                                                    ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              ///end
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
