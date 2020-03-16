import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kapp/pages/lightinginfo.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './typepropertyuser.dart';

class SafariBookletPage extends StatefulWidget {
  SafariBookletPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _SafariBookletPageState createState() => _SafariBookletPageState();
}

class _SafariBookletPageState extends State<SafariBookletPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  FocusNode _safari_booklet_common_name;
  FocusNode _safari_booklet_father_name;
  FocusNode _safari_booklet_machinegun_no;
  FocusNode _safari_booklet_issue_date;
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
                  child: TypePropertyUserPage(
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
                child: LightingInfoPage(
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
    _safari_booklet_common_name = new FocusNode();
    _safari_booklet_father_name = new FocusNode();
    _safari_booklet_machinegun_no = new FocusNode();
    _safari_booklet_issue_date = new FocusNode();
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
                        formheader(headerlablekey: 'key_safari_info'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield(
                                maxLength: 120,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(120),
                                    WhitelistingTextInputFormatter(
                                        RegExp(r'^[a-zA-Z0-9. ]*$'))
                                  ],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .safari_booklet_common_name
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.safari_booklet_common_name,
                                  headerlablekey:
                                      setapptext(key: 'key_Common_name'),
                                  fieldfocus: _safari_booklet_common_name,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _safari_booklet_common_name.unfocus();
                                    FocusScope.of(context).requestFocus(
                                        _safari_booklet_father_name);
                                  },
                                  radiovalue: localdata
                                              .safari_booklet_common_name
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  // hinttextkey:
                                  //     setapptext(key: 'key_enter_1st_surveyor'),
                                  validator: (value) {
                                    if (value.isNotEmpty) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.safari_booklet_common_name =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.safari_booklet_common_name =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                maxLength: 120,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(120),
                                    WhitelistingTextInputFormatter(
                                        RegExp(r'^[a-zA-Z0-9. ]*$'))
                                  ],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .safari_booklet_father_name
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.safari_booklet_father_name,
                                  headerlablekey:
                                      setapptext(key: 'key_subscriber_father'),
                                  fieldfocus: _safari_booklet_father_name,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _safari_booklet_father_name.unfocus();
                                    FocusScope.of(context).requestFocus(
                                        _safari_booklet_machinegun_no);
                                  },
                                  radiovalue: localdata
                                              .safari_booklet_father_name
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  // hinttextkey:
                                  //     setapptext(key: 'key_enter_1st_surveyor'),
                                  validator: (value) {
                                    if (value.isNotEmpty) {
                                      if (!RegExp(r'^[a-zA-Z_ ]*$')
                                          .hasMatch(value)) {
                                        return setapptext(
                                            key: 'key_text_format_error');
                                      }
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.safari_booklet_father_name =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.safari_booklet_father_name =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                maxLength: 120,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(120),
                                    WhitelistingTextInputFormatter(
                                        RegExp(r'^[a-zA-Z0-9. ]*$'))
                                  ],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .safari_booklet_machinegun_no
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.safari_booklet_machinegun_no,
                                  headerlablekey: setapptext(
                                      key: 'key_Safari_Machine_Gun_Number'),
                                  fieldfocus: _safari_booklet_machinegun_no,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _safari_booklet_machinegun_no.unfocus();
                                    FocusScope.of(context).requestFocus(
                                        _safari_booklet_issue_date);
                                  },
                                  radiovalue: localdata
                                              .safari_booklet_machinegun_no
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  // hinttextkey:
                                  //     setapptext(key: 'key_enter_1st_surveyor'),
                                  // validator: (value) {
                                  //   if (value.trim().isEmpty) {
                                  //     return setapptext(
                                  //         key: 'key_field_not_blank');
                                  //   }
                                  // },
                                  onSaved: (value) {
                                    localdata.safari_booklet_machinegun_no =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.safari_booklet_machinegun_no =
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
                                                            .safari_booklet_issue_date
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_Issued_on'),
                                                overflow: TextOverflow.visible,
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
                                                    DatePicker.showDatePicker(
                                                        context,
                                                        onChanged: (date) {
                                                      localdata
                                                              .safari_booklet_issue_date =
                                                          DateFormat(
                                                                  'yyyy/MM/dd')
                                                              .format(date)
                                                              .toString();
                                                      setState(() {});
                                                    }, onConfirm: (date) {
                                                      localdata
                                                              .safari_booklet_issue_date =
                                                          DateFormat(
                                                                  'yyyy/MM/dd')
                                                              .format(date)
                                                              .toString();
                                                      setState(() {});
                                                    });
                                                  },
                                            child: AbsorbPointer(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(localdata
                                                                .safari_booklet_issue_date
                                                                ?.isEmpty ??
                                                            true
                                                        ? setapptext(
                                                            key: 'kwy_notset')
                                                        : localdata
                                                            .safari_booklet_issue_date),
                                                    IconButton(
                                                        icon: Icon(
                                                            Icons.date_range),
                                                        onPressed: () {
                                                          DatePicker
                                                              .showDatePicker(
                                                                  context,
                                                                  onChanged:
                                                                      (date) {
                                                            localdata
                                                                    .safari_booklet_issue_date =
                                                                DateFormat(
                                                                        'yyyy/MM/dd')
                                                                    .format(
                                                                        date)
                                                                    .toString();
                                                            setState(() {});
                                                          }, onConfirm: (date) {
                                                            localdata
                                                                    .safari_booklet_issue_date =
                                                                DateFormat(
                                                                        'yyyy/MM/dd')
                                                                    .format(
                                                                        date)
                                                                    .toString();
                                                            setState(() {});
                                                          });
                                                        })
                                                  ]),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Divider(
                                            color: Colors.black,
                                          ),
                                        ),
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
                                                            .safari_booklet_picture
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key:
                                                        'key_Picture_of_Safari_Booklet'),
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
                                                              try {
                                                                localdata
                                                                        .safari_booklet_picture =
                                                                    await appimagepicker();
                                                                setState(() {});
                                                              } catch (e) {
                                                                print(e);
                                                              }
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
                                                          .safari_booklet_picture
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(
                                                        setapptext(
                                                            key:
                                                                'key_no_image'),
                                                      ),
                                                    )
                                                  : (File(localdata
                                                              .safari_booklet_picture)
                                                          .existsSync())
                                                      ? Image.file(
                                                          File(localdata
                                                              .safari_booklet_picture),
                                                        )
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
