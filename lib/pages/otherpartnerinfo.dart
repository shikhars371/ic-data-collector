import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kapp/pages/fourlimit.dart';
import 'package:kapp/pages/infophotonint.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';

class OtherPartnerInfoPage extends StatefulWidget {
  OtherPartnerInfoPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _OtherPartnerInfoPageState createState() => _OtherPartnerInfoPageState();
}

class _OtherPartnerInfoPageState extends State<OtherPartnerInfoPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  FocusNode _second_partner_name;
  FocusNode _second_partner_surname;
  FocusNode _second_partner_boy;
  FocusNode _second_partner_father;
  FocusNode _second_partner_phone;
  FocusNode _second_partner_email;
  FocusNode _second_partner_machinegun_no;
  FocusNode _second_partner_cover_note;
  FocusNode _second_partner_note_page;
  FocusNode _second_partner_reg_no;
  FocusNode _third_partner_name;
  FocusNode _third_partner_surname;
  FocusNode _third_partner_boy;
  FocusNode _third_partner_father;
  FocusNode _third_partner_phone;
  FocusNode _third_partner_email;
  FocusNode _third_partner_machinegun_no;
  FocusNode _third_partner_cover_note;
  FocusNode _third_partner_note_page;
  FocusNode _third_partner_reg_no;
  FocusNode _fourth_partner_name;
  FocusNode _fourth_partner_surname;
  FocusNode _fourth_partner_boy;
  FocusNode _fourth_partner_father;
  FocusNode _fourth_partner_phone;
  FocusNode _fourth_partner_email;
  FocusNode _fourth_partner_machinegun_no;
  FocusNode _fourth_partner_cover_note;
  FocusNode _fourth_partner_note_page;
  FocusNode _fourth_partner_reg_no;
  FocusNode _fifth_partner_name;
  FocusNode _fifth_partner_surname;
  FocusNode _fifth_partner_boy;
  FocusNode _fifth_partner_father;
  FocusNode _fifth_partner_phone;
  FocusNode _fifth_partner_email;
  FocusNode _fifth_partner_machinegun_no;
  FocusNode _fifth_partner_cover_note;
  FocusNode _fifth_partner_note_page;
  FocusNode _fifth_partner_reg_no;

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
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: InfoPhotoHintPage(
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
    _second_partner_name = new FocusNode();
    _second_partner_surname = new FocusNode();
    _second_partner_boy = new FocusNode();
    _second_partner_father = new FocusNode();
    _second_partner_phone = new FocusNode();
    _second_partner_email = new FocusNode();
    _second_partner_machinegun_no = new FocusNode();
    _second_partner_cover_note = new FocusNode();
    _second_partner_note_page = new FocusNode();
    _second_partner_reg_no = new FocusNode();
    _third_partner_name = new FocusNode();
    _third_partner_surname = new FocusNode();
    _third_partner_boy = new FocusNode();
    _third_partner_father = new FocusNode();
    _third_partner_phone = new FocusNode();
    _third_partner_email = new FocusNode();
    _third_partner_machinegun_no = new FocusNode();
    _third_partner_cover_note = new FocusNode();
    _third_partner_note_page = new FocusNode();
    _third_partner_reg_no = new FocusNode();
    _fourth_partner_name = new FocusNode();
    _fourth_partner_surname = new FocusNode();
    _fourth_partner_boy = new FocusNode();
    _fourth_partner_father = new FocusNode();
    _fourth_partner_phone = new FocusNode();
    _fourth_partner_email = new FocusNode();
    _fourth_partner_machinegun_no = new FocusNode();
    _fourth_partner_cover_note = new FocusNode();
    _fourth_partner_note_page = new FocusNode();
    _fourth_partner_reg_no = new FocusNode();
    _fifth_partner_name = new FocusNode();
    _fifth_partner_surname = new FocusNode();
    _fifth_partner_boy = new FocusNode();
    _fifth_partner_father = new FocusNode();
    _fifth_partner_phone = new FocusNode();
    _fifth_partner_email = new FocusNode();
    _fifth_partner_machinegun_no = new FocusNode();
    _fifth_partner_cover_note = new FocusNode();
    _fifth_partner_note_page = new FocusNode();
    _fifth_partner_reg_no = new FocusNode();
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey: setapptext(key: 'key_name'),
                                  fieldfocus: _second_partner_name,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _second_partner_name.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_second_partner_surname);
                                  },
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
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey:
                                      setapptext(key: 'key_surname'),
                                  fieldfocus: _second_partner_surname,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _second_partner_surname.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_second_partner_boy);
                                  },
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
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey: setapptext(key: 'key_wold'),
                                  fieldfocus: _second_partner_boy,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _second_partner_boy.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_second_partner_father);
                                  },
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
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.second_partner_boy = value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.second_partner_boy = value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey: setapptext(key: 'key_birth'),
                                  fieldfocus: _second_partner_father,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _second_partner_father.unfocus();
                                  },
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
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
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
                                  iscompleted: localdata
                                              .second_partner_gender?.isEmpty ??
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
                                    localdata.second_partner_gender = value;
                                  },
                                  onChanged: (value) {
                                    localdata.second_partner_gender = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  keyboardtype: TextInputType.number,
                                  headerlablekey: setapptext(key: 'key_phone'),
                                  fieldfocus: _second_partner_phone,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _second_partner_phone.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_second_partner_email);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey: setapptext(key: 'key_email'),
                                  fieldfocus: _second_partner_email,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _second_partner_email.unfocus();
                                  },
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
                                                              localdata
                                                                      .second_partner_image =
                                                                  await appimagepicker();
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
                                  fieldfocus: _second_partner_machinegun_no,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _second_partner_machinegun_no.unfocus();
                                    FocusScope.of(context).requestFocus(
                                        _second_partner_cover_note);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.second_partner_cover_note
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.second_partner_cover_note,
                                  headerlablekey:
                                      setapptext(key: 'key_cover_letter'),
                                  fieldfocus: _second_partner_cover_note,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _second_partner_cover_note.unfocus();
                                    FocusScope.of(context).requestFocus(
                                        _second_partner_note_page);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.second_partner_note_page
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.second_partner_note_page,
                                  headerlablekey:
                                      setapptext(key: 'key_notification_page'),
                                  fieldfocus: _second_partner_note_page,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _second_partner_note_page.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_second_partner_reg_no);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .second_partner_reg_no?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.second_partner_reg_no,
                                  headerlablekey: setapptext(key: 'key_reg_no'),
                                  fieldfocus: _second_partner_reg_no,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _second_partner_reg_no.unfocus();
                                  },
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
                                                              localdata
                                                                      .second_partner_phote_note1 =
                                                                  await appimagepicker();
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
                                                              localdata
                                                                      .second_partner_photo_tips1 =
                                                                  await appimagepicker();
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
                                                              localdata
                                                                      .second_partner_photo_tips2 =
                                                                  await appimagepicker();
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.third_partner_name?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.third_partner_name,
                                  headerlablekey: setapptext(key: 'key_name'),
                                  fieldfocus: _third_partner_name,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _third_partner_name.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_third_partner_surname);
                                  },
                                  radiovalue:
                                      localdata.third_partner_name?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.third_partner_name = value;
                                  },
                                  onChanged: (value) {
                                    localdata.third_partner_name = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .third_partner_surname?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.third_partner_surname,
                                  headerlablekey:
                                      setapptext(key: 'key_surname'),
                                  fieldfocus: _third_partner_surname,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _third_partner_surname.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_third_partner_boy);
                                  },
                                  radiovalue: localdata
                                              .third_partner_surname?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.third_partner_surname = value;
                                  },
                                  onChanged: (value) {
                                    localdata.third_partner_surname = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.third_partner_boy?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.third_partner_boy,
                                  headerlablekey: setapptext(key: 'key_wold'),
                                  fieldfocus: _third_partner_boy,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _third_partner_boy.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_third_partner_father);
                                  },
                                  radiovalue:
                                      localdata.third_partner_boy?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.third_partner_boy = value;
                                  },
                                  onChanged: (value) {
                                    localdata.third_partner_boy = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.third_partner_father?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.third_partner_father,
                                  headerlablekey: setapptext(key: 'key_birth'),
                                  fieldfocus: _third_partner_father,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _third_partner_father.unfocus();
                                  },
                                  radiovalue:
                                      localdata.third_partner_father?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
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
                                  fieldfocus: _third_partner_phone,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _third_partner_phone.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_third_partner_email);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.third_partner_email?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.third_partner_email,
                                  headerlablekey: setapptext(key: 'key_email'),
                                  fieldfocus: _third_partner_email,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _third_partner_email.unfocus();
                                  },
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
                                                              localdata
                                                                      .third_partner_image =
                                                                  await appimagepicker();
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
                                  fieldfocus: _third_partner_machinegun_no,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _third_partner_machinegun_no.unfocus();
                                    FocusScope.of(context).requestFocus(
                                        _third_partner_cover_note);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.third_partner_cover_note
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.third_partner_cover_note,
                                  headerlablekey:
                                      setapptext(key: 'key_cover_letter'),
                                  fieldfocus: _third_partner_cover_note,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _third_partner_cover_note.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_third_partner_note_page);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.third_partner_note_page
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.third_partner_note_page,
                                  headerlablekey:
                                      setapptext(key: 'key_notification_page'),
                                  fieldfocus: _third_partner_note_page,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _third_partner_note_page.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_third_partner_reg_no);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.third_partner_reg_no?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.third_partner_reg_no,
                                  headerlablekey: setapptext(key: 'key_reg_no'),
                                  fieldfocus: _third_partner_reg_no,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _third_partner_reg_no.unfocus();
                                  },
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
                                                              localdata
                                                                      .third_partner_phote_note1 =
                                                                  await appimagepicker();
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
                                                              localdata
                                                                      .third_partner_photo_tips1 =
                                                                  await appimagepicker();
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
                                                              localdata
                                                                      .third_partner_photo_tips2 =
                                                                  await appimagepicker();
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fourth_partner_name?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fourth_partner_name,
                                  headerlablekey: setapptext(key: 'key_name'),
                                  fieldfocus: _fourth_partner_name,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fourth_partner_name.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_fourth_partner_surname);
                                  },
                                  radiovalue:
                                      localdata.fourth_partner_name?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.fourth_partner_name = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fourth_partner_name = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.fourth_partner_surname
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fourth_partner_surname,
                                  headerlablekey:
                                      setapptext(key: 'key_surname'),
                                  fieldfocus: _fourth_partner_surname,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fourth_partner_surname.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_fourth_partner_boy);
                                  },
                                  radiovalue: localdata.fourth_partner_surname
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.fourth_partner_surname = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fourth_partner_surname = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fourth_partner_boy?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fourth_partner_boy,
                                  headerlablekey: setapptext(key: 'key_wold'),
                                  fieldfocus: _fourth_partner_boy,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fourth_partner_boy.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_fourth_partner_father);
                                  },
                                  radiovalue:
                                      localdata.fourth_partner_boy?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.fourth_partner_boy = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fourth_partner_boy = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .fourth_partner_father?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fourth_partner_father,
                                  headerlablekey: setapptext(key: 'key_birth'),
                                  fieldfocus: _fourth_partner_father,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _fourth_partner_father.unfocus();
                                  },
                                  radiovalue: localdata
                                              .fourth_partner_father?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
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
                                  fieldfocus: _fourth_partner_phone,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fourth_partner_phone.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_fourth_partner_email);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fourth_partner_email?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fourth_partner_email,
                                  headerlablekey: setapptext(key: 'key_email'),
                                  fieldfocus: _fourth_partner_email,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _fourth_partner_email.unfocus();
                                  },
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
                                                              localdata
                                                                      .fourth_partner_image =
                                                                  await appimagepicker();
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
                                  fieldfocus: _fourth_partner_machinegun_no,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fourth_partner_machinegun_no.unfocus();
                                    FocusScope.of(context).requestFocus(
                                        _fourth_partner_cover_note);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.fourth_partner_cover_note
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fourth_partner_cover_note,
                                  headerlablekey:
                                      setapptext(key: 'key_cover_letter'),
                                  fieldfocus: _fourth_partner_cover_note,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fourth_partner_cover_note.unfocus();
                                    FocusScope.of(context).requestFocus(
                                        _fourth_partner_note_page);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.fourth_partner_note_page
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fourth_partner_note_page,
                                  headerlablekey:
                                      setapptext(key: 'key_notification_page'),
                                  fieldfocus: _fourth_partner_note_page,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fourth_partner_note_page.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_fourth_partner_reg_no);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .fourth_partner_reg_no?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fourth_partner_reg_no,
                                  headerlablekey: setapptext(key: 'key_reg_no'),
                                  fieldfocus: _fourth_partner_reg_no,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _fourth_partner_reg_no.unfocus();
                                  },
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
                                                              localdata
                                                                      .fourth_partner_phote_note1 =
                                                                  await appimagepicker();
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
                                                              localdata
                                                                      .fourth_partner_photo_tips1 =
                                                                  await appimagepicker();
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
                                                              localdata
                                                                      .fourth_partner_photo_tips2 =
                                                                  await appimagepicker();
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fifth_partner_name?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fifth_partner_name,
                                  headerlablekey: setapptext(key: 'key_name'),
                                  fieldfocus: _fifth_partner_name,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fifth_partner_name.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_fifth_partner_surname);
                                  },
                                  radiovalue:
                                      localdata.fifth_partner_name?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.fifth_partner_name = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fifth_partner_name = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .fifth_partner_surname?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fifth_partner_surname,
                                  headerlablekey:
                                      setapptext(key: 'key_surname'),
                                  fieldfocus: _fifth_partner_surname,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fifth_partner_surname.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_fifth_partner_boy);
                                  },
                                  radiovalue: localdata
                                              .fifth_partner_surname?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.fifth_partner_surname = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fifth_partner_surname = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fifth_partner_boy?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fifth_partner_boy,
                                  headerlablekey: setapptext(key: 'key_wold'),
                                  fieldfocus: _fifth_partner_boy,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fifth_partner_boy.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_fifth_partner_father);
                                  },
                                  radiovalue:
                                      localdata.fifth_partner_boy?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.fifth_partner_boy = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fifth_partner_boy = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fifth_partner_father?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fifth_partner_father,
                                  headerlablekey: setapptext(key: 'key_birth'),
                                  fieldfocus: _fifth_partner_father,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _fifth_partner_father.unfocus();
                                  },
                                  radiovalue:
                                      localdata.fifth_partner_father?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  validator: (value) {
                                    if (!(value?.isEmpty ?? true)) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
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
                                  fieldfocus: _fifth_partner_phone,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fifth_partner_phone.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_fifth_partner_email);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fifth_partner_email?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fifth_partner_email,
                                  headerlablekey: setapptext(key: 'key_email'),
                                  fieldfocus: _fifth_partner_email,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _fifth_partner_email.unfocus();
                                  },
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
                                                              localdata
                                                                      .fifth_partner_image =
                                                                  await appimagepicker();
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
                                  fieldfocus: _fifth_partner_machinegun_no,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fifth_partner_machinegun_no.unfocus();
                                    FocusScope.of(context).requestFocus(
                                        _fifth_partner_cover_note);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.fifth_partner_cover_note
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fifth_partner_cover_note,
                                  headerlablekey:
                                      setapptext(key: 'key_cover_letter'),
                                  fieldfocus: _fifth_partner_cover_note,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fifth_partner_cover_note.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_fifth_partner_note_page);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata.fifth_partner_note_page
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.fifth_partner_note_page,
                                  headerlablekey:
                                      setapptext(key: 'key_notification_page'),
                                  fieldfocus: _fifth_partner_note_page,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fifth_partner_note_page.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_fifth_partner_reg_no);
                                  },
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
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fifth_partner_reg_no?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fifth_partner_reg_no,
                                  headerlablekey: setapptext(key: 'key_reg_no'),
                                  fieldfocus: _fifth_partner_reg_no,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _fifth_partner_reg_no.unfocus();
                                  },
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
                                                              localdata
                                                                      .fifth_partner_phote_note1 =
                                                                  await appimagepicker();
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
                                                              localdata
                                                                      .fifth_partner_photo_tips1 =
                                                                  await appimagepicker();
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
                                                              localdata
                                                                      .fifth_partner_photo_tips2 =
                                                                  await appimagepicker();
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
