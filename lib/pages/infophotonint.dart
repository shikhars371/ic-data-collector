import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kapp/pages/firstpartnerinfo.dart';
import 'package:kapp/pages/fourlimit.dart';
import 'package:kapp/pages/otherpartnerinfo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';

class InfoPhotoHintPage extends StatefulWidget {
  InfoPhotoHintPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _InfoPhotoHintPageState createState() => _InfoPhotoHintPageState();
}

class _InfoPhotoHintPageState extends State<InfoPhotoHintPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  FocusNode _info_photo_hint_sukuk_number;
  FocusNode _info_photo_hint_cover_note;
  FocusNode _info_photo_hint_note_page;
  FocusNode _info_photo_hint_reg_no;

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
          if (localdata.property_type == "1") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => FourLimitPage(
                  localdata: localdata,
                ),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => OtherPartnerInfoPage(
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => FirstPartnerPage(
              localdata: localdata,
            ),
          ),
        );
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
    _info_photo_hint_sukuk_number = new FocusNode();
    _info_photo_hint_cover_note = new FocusNode();
    _info_photo_hint_note_page = new FocusNode();
    _info_photo_hint_reg_no = new FocusNode();
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
                        formheader(headerlablekey: 'key_information_and_photo'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield(
                                  headerlablekey:
                                      setapptext(key: 'key_machine_gun'),
                                  fieldfocus: _info_photo_hint_sukuk_number,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _info_photo_hint_sukuk_number.unfocus();
                                    FocusScope.of(context).requestFocus(
                                        _info_photo_hint_cover_note);
                                  },
                                  radiovalue: localdata
                                              .info_photo_hint_sukuk_number
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  initvalue: localdata
                                              .info_photo_hint_sukuk_number
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.info_photo_hint_sukuk_number,
                                  onSaved: (value) {
                                    localdata.info_photo_hint_sukuk_number =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.info_photo_hint_sukuk_number =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  headerlablekey:
                                      setapptext(key: 'key_cover_note'),
                                  fieldfocus: _info_photo_hint_cover_note,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _info_photo_hint_cover_note.unfocus();
                                    FocusScope.of(context).requestFocus(
                                        _info_photo_hint_note_page);
                                  },
                                  radiovalue: localdata
                                              .info_photo_hint_cover_note
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  initvalue: localdata
                                              .info_photo_hint_cover_note
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.info_photo_hint_cover_note,
                                  onSaved: (value) {
                                    localdata.info_photo_hint_cover_note =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.info_photo_hint_cover_note =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  headerlablekey:
                                      setapptext(key: 'key_notification_page'),
                                  fieldfocus: _info_photo_hint_note_page,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _info_photo_hint_note_page.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_info_photo_hint_reg_no);
                                  },
                                  radiovalue: localdata
                                              .info_photo_hint_note_page
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  initvalue: localdata.info_photo_hint_note_page
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.info_photo_hint_note_page,
                                  onSaved: (value) {
                                    localdata.info_photo_hint_note_page =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.info_photo_hint_note_page =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  headerlablekey: setapptext(key: 'key_reg_no'),
                                  fieldfocus: _info_photo_hint_reg_no,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _info_photo_hint_reg_no.unfocus();
                                  },
                                  radiovalue: localdata.info_photo_hint_reg_no
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  initvalue: localdata.info_photo_hint_reg_no
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.info_photo_hint_reg_no,
                                  onSaved: (value) {
                                    localdata.info_photo_hint_reg_no =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.info_photo_hint_reg_no =
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
                                                            .info_photo_hint_photo_note1
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
                                                  onPressed: () async {
                                                    localdata
                                                            .info_photo_hint_photo_note1 =
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
                                                        .info_photo_hint_photo_note1
                                                        ?.isEmpty ??
                                                    true
                                                ? Center(
                                                    child: Text(setapptext(
                                                        key: 'key_no_image')),
                                                  )
                                                : File(localdata
                                                            .info_photo_hint_photo_note1)
                                                        .existsSync()
                                                    ? Image.file(
                                                        File(localdata
                                                            .info_photo_hint_photo_note1),
                                                      )
                                                    : Center(
                                                        child: Text(setapptext(
                                                            key:
                                                                'key_no_image')),
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
                                                            .info_photo_hint_photo_tips1
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
                                                  onPressed: () async {
                                                    localdata
                                                            .info_photo_hint_photo_tips1 =
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
                                                        .info_photo_hint_photo_tips1
                                                        ?.isEmpty ??
                                                    true
                                                ? Center(
                                                    child: Text(setapptext(
                                                        key: 'key_no_image')),
                                                  )
                                                : File(localdata
                                                            .info_photo_hint_photo_tips1)
                                                        .existsSync()
                                                    ? Image.file(
                                                        File(localdata
                                                            .info_photo_hint_photo_tips1),
                                                      )
                                                    : Center(
                                                        child: Text(setapptext(
                                                            key:
                                                                'key_no_image')),
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
                                                            .info_photo_hint_photo_tips2
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
                                                  onPressed: () async {
                                                    localdata
                                                            .info_photo_hint_photo_tips2 =
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
                                                        .info_photo_hint_photo_tips2
                                                        ?.isEmpty ??
                                                    true
                                                ? Center(
                                                    child: Text(setapptext(
                                                        key: 'key_no_image')),
                                                  )
                                                : File(localdata
                                                            .info_photo_hint_photo_tips2)
                                                        .existsSync()
                                                    ? Image.file(
                                                        File(localdata
                                                            .info_photo_hint_photo_tips2),
                                                      )
                                                    : Center(
                                                        child: Text(setapptext(
                                                            key:
                                                                'key_no_image')),
                                                      ),
                                          ),
                                        )
                                      ],
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
