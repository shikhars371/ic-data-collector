import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kapp/pages/fourlimit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../models/localpropertydata.dart';
import '../utils/appstate.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './safaribooklet.dart';
import '../utils/language_service.dart';
import '../utils/locator.dart';

class LightingInfoPage extends StatefulWidget {
  LightingInfoPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _LightingInfoPageState createState() => _LightingInfoPageState();
}

class _LightingInfoPageState extends State<LightingInfoPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  TextEditingController _subfather;
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
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: SafariBookletPage(
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
                child: FourLimitPage(
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
    _subfather = new TextEditingController(
        text: localdata.lightning_father_name?.isEmpty ?? true
            ? ""
            : localdata.lightning_father_name);
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
                        formheader(headerlablekey: 'key_lightning'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.lightning_meter_no?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.lightning_meter_no,
                                  headerlablekey:
                                      setapptext(key: 'key_meter_number'),
                                  radiovalue:
                                      localdata.lightning_meter_no?.isEmpty ??
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
                                    localdata.lightning_meter_no = value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.lightning_meter_no = value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue: localdata
                                              .lightning_common_name?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.lightning_common_name,
                                  headerlablekey:
                                      setapptext(key: 'key_Common_name'),
                                  radiovalue: localdata
                                              .lightning_common_name?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  // hinttextkey:
                                  //     setapptext(key: 'key_enter_1st_surveyor'),
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.lightning_common_name =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.lightning_common_name =
                                        value.trim();
                                    setState(() {});
                                  }),
                              // formcardtextfield(
                              //     maxLength: 120,
                              //     inputFormatters: [],
                              //     enable:
                              //         localdata.isdrafted == 2 ? false : true,
                              //     initvalue: localdata
                              //                 .lightning_father_name?.isEmpty ??
                              //             true
                              //         ? ""
                              //         : localdata.lightning_father_name,
                              //     headerlablekey:
                              //         setapptext(key: 'key_subscriber_father'),
                              //     radiovalue: localdata
                              //                 .lightning_father_name?.isEmpty ??
                              //             true
                              //         ? CheckColor.Black
                              //         : CheckColor.Green,
                              //     // hinttextkey:
                              //     //     setapptext(key: 'key_enter_1st_surveyor'),
                              //     validator: (value) {},
                              //     onSaved: (value) {
                              //       localdata.lightning_father_name =
                              //           value.trim();
                              //     },
                              //     onChanged: (value) {
                              //       localdata.lightning_father_name =
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
                                                            .lightning_father_name
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
                                                          'key_subscriber_father'),
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
                                            controller: _subfather,
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
                                              localdata.lightning_father_name =
                                                  value.trim();
                                            },
                                            onChanged: (value) {
                                              localdata.lightning_father_name =
                                                  value.trim();
                                              setState(() {});
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
                                                            .lightning_picture_bell_power
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key:
                                                        'key_Picture_of_Bell_Power'),
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
                                                                  .lightning_father_name;

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
                                                                              localdata.lightning_picture_bell_power = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.lightning_picture_bell_power = await appimagepicker(source: ImageSource.gallery);
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
                                                                      .lightning_father_name =
                                                                  tempval;
                                                              _subfather.text =
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
                                                          .lightning_picture_bell_power
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : File(localdata
                                                              .lightning_picture_bell_power)
                                                          .existsSync()
                                                      ? Image.file(
                                                          File(localdata
                                                              .lightning_picture_bell_power),
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
