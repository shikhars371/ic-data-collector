import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:persian_date/persian_date.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;
import 'package:image_picker/image_picker.dart';

import '../models/localpropertydata.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './typeofuse.dart';
import './propertydetails.dart';
import '../utils/appstate.dart';
import '../utils/language_service.dart';
import '../utils/locator.dart';

class DocVerificationPage extends StatefulWidget {
  DocVerificationPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _DocVerificationPageState createState() => _DocVerificationPageState();
}

class _DocVerificationPageState extends State<DocVerificationPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  bool enable = false;
  TextEditingController _proareaowner;
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
          if (localdata.document_type == "1") {
            if (localdata.issued_on?.isEmpty ?? true) {
              setState(() {
                enable = true;
              });
            } else {
              _formkey.currentState.save();
              if (localdata.isdrafted != 2) {
                await DBHelper().updatePropertySurvey(
                    localdata, localdata.local_property_key);
              }
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: TypeOfUsePage(
                        localdata: localdata,
                      ),
                      type: PageTransitionType.rightToLeft));
            }
          } else {
            _formkey.currentState.save();
            await DBHelper()
                .updatePropertySurvey(localdata, localdata.local_property_key);
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: TypeOfUsePage(
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
                child: PropertyDetailsPage(
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
    _proareaowner = new TextEditingController(
        text: localdata.land_area_qawwala?.isEmpty ?? true
            ? ""
            : localdata.land_area_qawwala);
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
                        formheader(headerlablekey: 'key_doc_type_verification'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formCardDropdown(
                                  fieldrequired: true,
                                  enable:
                                      localdata.isdrafted == 2 ? true : false,
                                  value:
                                      localdata.document_type?.isEmpty ?? true
                                          ? "0"
                                          : localdata.document_type,
                                  iscompleted:
                                      ((localdata.document_type?.isEmpty ??
                                                  true) ||
                                              (localdata.document_type == "0"))
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  headerlablekey:
                                      setapptext(key: 'key_doc_type'),
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_religious'),
                                        value: "1"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_customary'),
                                        value: "2"),
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_official_decree'),
                                        value: "3")
                                  ],
                                  onSaved: (String value) {
                                    localdata.document_type = value;
                                  },
                                  onChanged: (value) {
                                    localdata.document_type = value;
                                    localdata.issued_on = null;
                                    localdata.place_of_issue = null;
                                    localdata.property_number = null;
                                    localdata.document_cover = null;
                                    localdata.document_page = null;
                                    localdata.doc_reg_number = null;
                                    localdata.land_area_qawwala = null;
                                    localdata.property_doc_photo_1 = null;
                                    localdata.property_doc_photo_2 = null;
                                    localdata.property_doc_photo_3 = null;
                                    localdata.property_doc_photo_4 = null;
                                    localdata.odinary_doc_photo1 = null;
                                    localdata.odinary_doc_photo6 = null;

                                    setState(() {});
                                  },
                                  validate: (value) {
                                    if ((value.isEmpty) || value == "0") {
                                      return setapptext(key: 'key_required');
                                    }
                                  }),

                              ///Specifications of the religious document
                              ///begin
                              if (localdata.document_type == "1") ...[
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
                                            color: Color.fromRGBO(
                                                176, 174, 171, 1),
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
                                                              .issued_on
                                                              ?.isEmpty ??
                                                          true
                                                      ? CheckColor.Black
                                                      : CheckColor.Green),
                                              Text(
                                                '*',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 18),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  setapptext(
                                                      key: 'key_Issued_on'),
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true,
                                                  maxLines: 2,
                                                  style: TextStyle(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8, top: 8),
                                            child: GestureDetector(
                                              onTap: localdata.isdrafted == 2
                                                  ? null
                                                  : () {
                                                      PersianDate now =
                                                          PersianDate();
                                                      DatePicker.showDatePicker(
                                                        context,
                                                        maxYear: now.year,
                                                        onChanged:
                                                            (year, month, day) {
                                                          localdata.issued_on =
                                                              intl.DateFormat(
                                                                      'yyyy/MM/dd')
                                                                  .format(
                                                                    DateTime(
                                                                        year,
                                                                        month,
                                                                        day),
                                                                  )
                                                                  .toString();
                                                          setState(() {
                                                            enable = false;
                                                          });
                                                        },
                                                        onConfirm:
                                                            (year, month, day) {
                                                          localdata.issued_on =
                                                              intl.DateFormat(
                                                                      'yyyy/MM/dd')
                                                                  .format(
                                                                    DateTime(
                                                                        year,
                                                                        month,
                                                                        day),
                                                                  )
                                                                  .toString();
                                                          setState(() {
                                                            enable = false;
                                                          });
                                                        },
                                                      );
                                                    },
                                              child: AbsorbPointer(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(localdata.issued_on
                                                                ?.isEmpty ??
                                                            true
                                                        ? setapptext(
                                                            key: 'kwy_notset')
                                                        : localdata.issued_on),
                                                    IconButton(
                                                        icon: Icon(
                                                            Icons.date_range),
                                                        onPressed: () {})
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Divider(
                                              color: enable
                                                  ? Colors.red
                                                  : Colors.black,
                                            ),
                                          ),
                                          enable
                                              ? Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            bottom: 8),
                                                    child: Text(
                                                      setapptext(
                                                          key: "key_required"),
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox()
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
                                    initvalue:
                                        localdata.place_of_issue?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.place_of_issue,
                                    headerlablekey:
                                        setapptext(key: 'key_Place_of_Issue'),
                                    radiovalue:
                                        localdata.place_of_issue?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.place_of_issue = value;
                                    },
                                    onChanged: (value) {
                                      localdata.place_of_issue = value;
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    maxLength: 120,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    initvalue:
                                        localdata.property_number?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.property_number,
                                    headerlablekey:
                                        setapptext(key: 'key_Property_Number'),
                                    radiovalue:
                                        localdata.property_number?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.property_number = value;
                                    },
                                    onChanged: (value) {
                                      localdata.property_number = value;
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    maxLength: 120,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    initvalue:
                                        localdata.document_cover?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.document_cover,
                                    headerlablekey:
                                        setapptext(key: 'key_Document_Cover'),
                                    radiovalue:
                                        localdata.document_cover?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.document_cover = value;
                                    },
                                    onChanged: (value) {
                                      localdata.document_cover = value;
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    maxLength: 120,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    initvalue:
                                        localdata.document_page?.isEmpty ?? true
                                            ? ""
                                            : localdata.document_page,
                                    headerlablekey:
                                        setapptext(key: 'key_Document_Page'),
                                    radiovalue:
                                        localdata.document_page?.isEmpty ?? true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.document_page = value;
                                    },
                                    onChanged: (value) {
                                      localdata.document_page = value;
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    maxLength: 120,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    initvalue:
                                        localdata.doc_reg_number?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.doc_reg_number,
                                    headerlablekey: setapptext(
                                        key:
                                            'key_Document_Registration_Number'),
                                    radiovalue:
                                        localdata.doc_reg_number?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.doc_reg_number = value;
                                    },
                                    onChanged: (value) {
                                      localdata.doc_reg_number = value;
                                      setState(() {});
                                    }),
                                // formcardtextfield(
                                //     maxLength: 120,
                                //     inputFormatters: [],
                                //     enable:
                                //         localdata.isdrafted == 2 ? false : true,
                                //     initvalue:
                                //         localdata.land_area_qawwala?.isEmpty ??
                                //                 true
                                //             ? ""
                                //             : localdata.land_area_qawwala,
                                //     headerlablekey: setapptext(
                                //         key: 'key_Land_area_in_Qawwala'),
                                //     radiovalue:
                                //         localdata.land_area_qawwala?.isEmpty ??
                                //                 true
                                //             ? CheckColor.Black
                                //             : CheckColor.Green,
                                //     onSaved: (value) {
                                //       localdata.land_area_qawwala = value;
                                //     },
                                //     onChanged: (value) {
                                //       localdata.land_area_qawwala = value;
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
                                            color: Color.fromRGBO(
                                                176, 174, 171, 1),
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
                                                              .land_area_qawwala
                                                              ?.isEmpty ??
                                                          true
                                                      ? CheckColor.Black
                                                      : CheckColor.Green),
                                              SizedBox(),
                                              Flexible(
                                                child: Container(
                                                  child: Text(
                                                    setapptext(
                                                        key:
                                                            'key_Land_area_in_Qawwala'),
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
                                              textDirection: locator<
                                                              LanguageService>()
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
                                                localdata.land_area_qawwala =
                                                    value.trim();
                                              },

                                              onChanged: (value) {
                                                localdata.land_area_qawwala =
                                                    value.trim();
                                                setState(() {});
                                              },
                                              onFieldSubmitted: (value) {
                                                localdata.land_area_qawwala =
                                                    value.trim();
                                                setState(() {});
                                              },
                                              maxLength: 120,
                                              controller: _proareaowner,

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
                                            color: Color.fromRGBO(
                                                176, 174, 171, 1),
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
                                                              .property_doc_photo_1
                                                              ?.isEmpty ??
                                                          true
                                                      ? CheckColor.Black
                                                      : CheckColor.Green),
                                              Flexible(
                                                child: Text(
                                                  setapptext(
                                                      key:
                                                          'key_Property_Document_Photo-1'),
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
                                                    child: Text(
                                                      setapptext(
                                                          key:
                                                              'key_capture_image'),
                                                    ),
                                                    onPressed:
                                                        localdata.isdrafted == 2
                                                            ? null
                                                            : () async {
                                                                tempval = localdata
                                                                    .land_area_qawwala;

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
                                                                              padding: EdgeInsets.all(8),
                                                                              //decoration: BoxDecoration(color: Colors.blue),
                                                                              child: Text(
                                                                                "Pick the image",
                                                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            Divider(),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                localdata.property_doc_photo_1 = await appimagepicker(source: ImageSource.camera);
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                              },
                                                                              child: Text(
                                                                                "Use Camera",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                            Divider(),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                localdata.property_doc_photo_1 = await appimagepicker(source: ImageSource.gallery);
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                              },
                                                                              child: Text(
                                                                                "Use Gallery",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 20,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      );
                                                                    });
                                                                setState(() {});
                                                                localdata
                                                                        .land_area_qawwala =
                                                                    tempval;
                                                                _proareaowner
                                                                        .text =
                                                                    tempval;
                                                                setState(() {});
                                                              },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
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
                                                            .property_doc_photo_1
                                                            ?.isEmpty ??
                                                        true
                                                    ? Center(
                                                        child: Text(setapptext(
                                                            key:
                                                                'key_no_image')),
                                                      )
                                                    : Image.file(
                                                        File(localdata
                                                            .property_doc_photo_1),
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
                                            color: Color.fromRGBO(
                                                176, 174, 171, 1),
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
                                                              .property_doc_photo_2
                                                              ?.isEmpty ??
                                                          true
                                                      ? CheckColor.Black
                                                      : CheckColor.Green),
                                              Flexible(
                                                child: Text(
                                                  setapptext(
                                                      key:
                                                          'key_Property_Document_Photo-2'),
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
                                                                              padding: EdgeInsets.all(8),
                                                                              //decoration: BoxDecoration(color: Colors.blue),
                                                                              child: Text(
                                                                                "Pick the image",
                                                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            Divider(),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                localdata.property_doc_photo_2 = await appimagepicker(source: ImageSource.camera);
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                              },
                                                                              child: Text(
                                                                                "Use Camera",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                            Divider(),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                localdata.property_doc_photo_2 = await appimagepicker(source: ImageSource.gallery);
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                              },
                                                                              child: Text(
                                                                                "Use Gallery",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 20,
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
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
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
                                                            .property_doc_photo_2
                                                            ?.isEmpty ??
                                                        true
                                                    ? Center(
                                                        child: Text(setapptext(
                                                            key:
                                                                'key_no_image')),
                                                      )
                                                    : Image.file(File(localdata
                                                        .property_doc_photo_2)),
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
                                            color: Color.fromRGBO(
                                                176, 174, 171, 1),
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
                                                              .property_doc_photo_3
                                                              ?.isEmpty ??
                                                          true
                                                      ? CheckColor.Black
                                                      : CheckColor.Green),
                                              Flexible(
                                                child: Text(
                                                  setapptext(
                                                      key:
                                                          'key_Property_Document_Photo-3'),
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
                                                                              padding: EdgeInsets.all(8),
                                                                              //decoration: BoxDecoration(color: Colors.blue),
                                                                              child: Text(
                                                                                "Pick the image",
                                                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            Divider(),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                localdata.property_doc_photo_3 = await appimagepicker(source: ImageSource.camera);
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                              },
                                                                              child: Text(
                                                                                "Use Camera",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                            Divider(),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                localdata.property_doc_photo_3 = await appimagepicker(source: ImageSource.gallery);
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                              },
                                                                              child: Text(
                                                                                "Use Gallery",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 20,
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
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
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
                                                            .property_doc_photo_3
                                                            ?.isEmpty ??
                                                        true
                                                    ? Center(
                                                        child: Text(setapptext(
                                                            key:
                                                                'key_no_image')),
                                                      )
                                                    : Image.file(File(localdata
                                                        .property_doc_photo_3)),
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
                                            color: Color.fromRGBO(
                                                176, 174, 171, 1),
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
                                                              .property_doc_photo_4
                                                              ?.isEmpty ??
                                                          true
                                                      ? CheckColor.Black
                                                      : CheckColor.Green),
                                              Flexible(
                                                child: Text(
                                                  setapptext(
                                                      key:
                                                          'key_Property_Document_Photo-4'),
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
                                                                              padding: EdgeInsets.all(8),
                                                                              //decoration: BoxDecoration(color: Colors.blue),
                                                                              child: Text(
                                                                                "Pick the image",
                                                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            Divider(),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                localdata.property_doc_photo_4 = await appimagepicker(source: ImageSource.camera);
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                              },
                                                                              child: Text(
                                                                                "Use Camera",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                            Divider(),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                localdata.property_doc_photo_4 = await appimagepicker(source: ImageSource.gallery);
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                              },
                                                                              child: Text(
                                                                                "Use Gallery",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 20,
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
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
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
                                                            .property_doc_photo_4
                                                            ?.isEmpty ??
                                                        true
                                                    ? Center(
                                                        child: Text(setapptext(
                                                            key:
                                                                'key_no_image')),
                                                      )
                                                    : Image.file(File(localdata
                                                        .property_doc_photo_4)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],

                              ///end
                              ///Ordinary Document Specifications
                              ///start
                              if (localdata.document_type == "2" ||
                                  localdata.document_type == "3") ...[
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
                                            color: Color.fromRGBO(
                                                176, 174, 171, 1),
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
                                                              .odinary_doc_photo1
                                                              ?.isEmpty ??
                                                          true
                                                      ? CheckColor.Black
                                                      : CheckColor.Green),
                                              Flexible(
                                                child: Text(
                                                  setapptext(
                                                      key: 'key_photo-1'),
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
                                                                              padding: EdgeInsets.all(8),
                                                                              //decoration: BoxDecoration(color: Colors.blue),
                                                                              child: Text(
                                                                                "Pick the image",
                                                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            Divider(),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                localdata.odinary_doc_photo1 = await appimagepicker(source: ImageSource.camera);
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                              },
                                                                              child: Text(
                                                                                "Use Camera",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                            Divider(),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                localdata.odinary_doc_photo1 = await appimagepicker(source: ImageSource.gallery);
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                              },
                                                                              child: Text(
                                                                                "Use Gallery",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 20,
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
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
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
                                                            .odinary_doc_photo1
                                                            ?.isEmpty ??
                                                        true
                                                    ? Center(
                                                        child: Text(setapptext(
                                                            key:
                                                                'key_no_image')),
                                                      )
                                                    : Image.file(
                                                        File(localdata
                                                            .odinary_doc_photo1),
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
                                            color: Color.fromRGBO(
                                                176, 174, 171, 1),
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
                                                              .odinary_doc_photo6
                                                              ?.isEmpty ??
                                                          true
                                                      ? CheckColor.Black
                                                      : CheckColor.Green),
                                              Flexible(
                                                child: Text(
                                                  setapptext(
                                                      key: 'key_photo-2'),
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
                                                                              padding: EdgeInsets.all(8),
                                                                              //decoration: BoxDecoration(color: Colors.blue),
                                                                              child: Text(
                                                                                "Pick the image",
                                                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            Divider(),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                localdata.odinary_doc_photo6 = await appimagepicker(source: ImageSource.camera);
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                              },
                                                                              child: Text(
                                                                                "Use Camera",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                            Divider(),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                localdata.odinary_doc_photo6 = await appimagepicker(source: ImageSource.gallery);
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                              },
                                                                              child: Text(
                                                                                "Use Gallery",
                                                                                style: TextStyle(color: Colors.blue, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 20,
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
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
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
                                                            .odinary_doc_photo6
                                                            ?.isEmpty ??
                                                        true
                                                    ? Center(
                                                        child: Text(setapptext(
                                                            key:
                                                                'key_no_image')),
                                                      )
                                                    : Image.file(
                                                        File(localdata
                                                            .odinary_doc_photo6),
                                                      ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],

                              ///end

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
