import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kapp/pages/firstpartnerinfo.dart';
import 'package:kapp/pages/fourlimit.dart';
import 'package:kapp/pages/otherpartnerinfo.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../models/localpropertydata.dart';
import '../utils/appstate.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import '../utils/language_service.dart';
import '../utils/locator.dart';

class InfoPhotoHintPage extends StatefulWidget {
  InfoPhotoHintPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _InfoPhotoHintPageState createState() => _InfoPhotoHintPageState();
}

class _InfoPhotoHintPageState extends State<InfoPhotoHintPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  TextEditingController _regno;
  String tempval = "";

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
                PageTransition(
                    child: FourLimitPage(
                      localdata: localdata,
                    ),
                    type: PageTransitionType.rightToLeft));
          } else {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: OtherPartnerInfoPage(
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
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: FirstPartnerPage(
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
    _regno = new TextEditingController(
        text: localdata.info_photo_hint_reg_no?.isEmpty ?? true
            ? ""
            : localdata.info_photo_hint_reg_no);
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
                        formheader(headerlablekey: 'key_information_and_photo'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey:
                                      setapptext(key: 'key_machine_gun'),
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
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey:
                                      setapptext(key: 'key_cover_note'),
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
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  headerlablekey:
                                      setapptext(key: 'key_notification_page'),
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
                              // formcardtextfield(
                              //     maxLength: 120,
                              //     inputFormatters: [],
                              //     enable:
                              //         localdata.isdrafted == 2 ? false : true,
                              //     headerlablekey: setapptext(key: 'key_reg_no'),
                              //     radiovalue: localdata.info_photo_hint_reg_no
                              //                 ?.isEmpty ??
                              //             true
                              //         ? CheckColor.Black
                              //         : CheckColor.Green,
                              //     initvalue: localdata.info_photo_hint_reg_no
                              //                 ?.isEmpty ??
                              //             true
                              //         ? ""
                              //         : localdata.info_photo_hint_reg_no,
                              //     onSaved: (value) {
                              //       localdata.info_photo_hint_reg_no =
                              //           value.trim();
                              //     },
                              //     onChanged: (value) {
                              //       localdata.info_photo_hint_reg_no =
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
                                                            .info_photo_hint_reg_no
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            SizedBox(),
                                            Flexible(
                                              child: Container(
                                                child: Text(
                                                  setapptext(key: 'key_reg_no'),
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
                                            controller: _regno,
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
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent),
                                            ),
                                            onSaved: (value) {
                                              localdata.info_photo_hint_reg_no =
                                                  value.trim();
                                            },
                                            onChanged: (value) {
                                              localdata.info_photo_hint_reg_no =
                                                  value.trim();
                                              setState(() {});
                                            },
                                            onFieldSubmitted: (value) {
                                              localdata.info_photo_hint_reg_no =
                                                  value.trim();
                                            },
                                            maxLength: 120,
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
                                                  onPressed:
                                                      localdata.isdrafted == 2
                                                          ? null
                                                          : () async {
                                                              tempval = localdata
                                                                  .info_photo_hint_reg_no;

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
                                                                              localdata.info_photo_hint_photo_note1 = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.info_photo_hint_photo_note1 = await appimagepicker(source: ImageSource.gallery);
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
                                                                      .info_photo_hint_reg_no =
                                                                  tempval;
                                                              _regno.text =
                                                                  tempval;
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
                                                                              localdata.info_photo_hint_photo_tips1 = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.info_photo_hint_photo_tips1 = await appimagepicker(source: ImageSource.gallery);
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
                                                                              localdata.info_photo_hint_photo_tips2 = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.info_photo_hint_photo_tips2 = await appimagepicker(source: ImageSource.gallery);
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
