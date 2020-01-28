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
import './typeofuse.dart';
import './propertydetails.dart';

class DocVerificationPage extends StatefulWidget {
  DocVerificationPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _DocVerificationPageState createState() => _DocVerificationPageState();
}

class _DocVerificationPageState extends State<DocVerificationPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  FocusNode _issued_on;
FocusNode _place_of_issue;
FocusNode _property_number;
FocusNode _document_cover;
FocusNode _document_page;
FocusNode _doc_reg_number;
FocusNode _land_area_qawwala;
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
          await DBHelper()
              .updatePropertySurvey(localdata, localdata.local_property_key);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => TypeOfUsePage(
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
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => PropertyDetailsPage(
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
    _issued_on = new FocusNode();
_place_of_issue = new FocusNode();
_property_number = new FocusNode();
_document_cover = new FocusNode();
_document_page = new FocusNode();
_doc_reg_number = new FocusNode();
_land_area_qawwala = new FocusNode();
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
                        formheader(headerlablekey: 'key_doc_type_verification'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formCardDropdown(
                                  value:
                                      localdata.document_type?.isEmpty ?? true
                                          ? "0"
                                          : localdata.document_type,
                                  iscompleted:
                                      ((localdata.document_type?.isEmpty ??
                                                  true) ||
                                              (localdata.document_type == "0"))
                                          ? false
                                          : true,
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
                                      return "required";
                                    }
                                  }),

                              ///Specifications of the religious document
                              ///begin
                              if (localdata.document_type == "1") ...[
                                formcardtextfield(
                                  keyboardtype: TextInputType.datetime,
                                  initvalue:
                                      localdata.issued_on?.isEmpty ?? true
                                          ? ""
                                          : localdata.issued_on,
                                  headerlablekey:
                                      setapptext(key: 'key_Issued_on'),
                                      fieldfocus: _issued_on,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _issued_on.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_place_of_issue);
                                  },
                                  hinttextkey:
                                      setapptext(key: 'key_date_format'),
                                  radiovalue:
                                      localdata.issued_on?.isEmpty ?? true
                                          ? false
                                          : true,
                                  onSaved: (value) {
                                    localdata.issued_on = value;
                                  },
                                  onChanged: (value) {
                                    localdata.issued_on = value;
                                    setState(() {});
                                  },
                                ),
                                formcardtextfield(
                                    initvalue:
                                        localdata.place_of_issue?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.place_of_issue,
                                    headerlablekey:
                                        setapptext(key: 'key_Place_of_Issue'),
                                        fieldfocus: _place_of_issue,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _place_of_issue.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_property_number);
                                  },
                                    radiovalue:
                                        localdata.place_of_issue?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.place_of_issue = value;
                                    },
                                    onChanged: (value) {
                                      localdata.place_of_issue = value;
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    initvalue:
                                        localdata.property_number?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.property_number,
                                    headerlablekey:
                                        setapptext(key: 'key_Property_Number'),
                                        fieldfocus: _property_number,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _property_number.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_document_cover);
                                  },
                                    radiovalue:
                                        localdata.property_number?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.property_number = value;
                                    },
                                    onChanged: (value) {
                                      localdata.property_number = value;
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    initvalue:
                                        localdata.document_cover?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.document_cover,
                                    headerlablekey:
                                        setapptext(key: 'key_Document_Cover'),
                                        fieldfocus: _document_cover,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _document_cover.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_document_page);
                                  },
                                    radiovalue:
                                        localdata.document_cover?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.document_cover = value;
                                    },
                                    onChanged: (value) {
                                      localdata.document_cover = value;
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    initvalue:
                                        localdata.document_page?.isEmpty ?? true
                                            ? ""
                                            : localdata.document_page,
                                    headerlablekey:
                                        setapptext(key: 'key_Document_Page'),
                                        fieldfocus: _document_page,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _document_page.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_doc_reg_number);
                                  },
                                    radiovalue:
                                        localdata.document_page?.isEmpty ?? true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.document_page = value;
                                    },
                                    onChanged: (value) {
                                      localdata.document_page = value;
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    initvalue:
                                        localdata.doc_reg_number?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.doc_reg_number,
                                    headerlablekey: setapptext(
                                        key:
                                            'key_Document_Registration_Number'),
                                            fieldfocus: _doc_reg_number,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _doc_reg_number.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_land_area_qawwala);
                                  },
                                    radiovalue:
                                        localdata.doc_reg_number?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.doc_reg_number = value;
                                    },
                                    onChanged: (value) {
                                      localdata.doc_reg_number = value;
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    initvalue:
                                        localdata.land_area_qawwala?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.land_area_qawwala,
                                    headerlablekey: setapptext(
                                        key: 'key_Land_area_in_Qawwala'),
                                        fieldfocus: _land_area_qawwala,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _land_area_qawwala.unfocus(); },
                                    radiovalue:
                                        localdata.land_area_qawwala?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    onSaved: (value) {
                                      localdata.land_area_qawwala = value;
                                    },
                                    onChanged: (value) {
                                      localdata.land_area_qawwala = value;
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
                                                      ? false
                                                      : true),
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
                                                        "Click here to capture image. (< 10MB)"),
                                                    onPressed: () async {
                                                      localdata
                                                              .property_doc_photo_1 =
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
                                                          .property_doc_photo_1
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text("No image"),
                                                    )
                                                  : Image.file(File(localdata
                                                      .property_doc_photo_1)),
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
                                                      ? false
                                                      : true),
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
                                                    child: Text(
                                                        "Click here to capture image. (< 10MB)"),
                                                    onPressed: () async {
                                                      localdata
                                                              .property_doc_photo_2 =
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
                                                          .property_doc_photo_2
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text("No image"),
                                                    )
                                                  : Image.file(File(localdata
                                                      .property_doc_photo_2)),
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
                                                      ? false
                                                      : true),
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
                                                    child: Text(
                                                        "Click here to capture image. (< 10MB)"),
                                                    onPressed: () async {
                                                      localdata
                                                              .property_doc_photo_3 =
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
                                                          .property_doc_photo_3
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text("No image"),
                                                    )
                                                  : Image.file(File(localdata
                                                      .property_doc_photo_3)),
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
                                                      ? false
                                                      : true),
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
                                                    child: Text(
                                                        "Click here to capture image. (< 10MB)"),
                                                    onPressed: () async {
                                                      localdata
                                                              .property_doc_photo_4 =
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
                                                          .property_doc_photo_4
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text("No image"),
                                                    )
                                                  : Image.file(File(localdata
                                                      .property_doc_photo_4)),
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
                                                      ? false
                                                      : true),
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
                                                    child: Text(
                                                        "Click here to capture image. (< 10MB)"),
                                                    onPressed: () async {
                                                      localdata
                                                              .odinary_doc_photo1 =
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
                                                          .odinary_doc_photo1
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text("No image"),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .odinary_doc_photo1),
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
                                                      ? false
                                                      : true),
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
                                                    child: Text(
                                                        "Click here to capture image. (< 10MB)"),
                                                    onPressed: () async {
                                                      localdata
                                                              .odinary_doc_photo6 =
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
                                                          .odinary_doc_photo6
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text("No image"),
                                                    )
                                                  : Image.file(
                                                      File(localdata
                                                          .odinary_doc_photo6),
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
