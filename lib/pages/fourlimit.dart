import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kapp/pages/firstpartnerinfo.dart';
import 'package:kapp/pages/homesketch.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../models/localpropertydata.dart';
import '../utils/appstate.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './lightinginfo.dart';
import './buildinginfo.dart';
import '../pages/infophotonint.dart';
import '../pages/otherpartnerinfo.dart';
import '../utils/language_service.dart';
import '../utils/locator.dart';

class FourLimitPage extends StatefulWidget {
  FourLimitPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _FourLimitPageState createState() => _FourLimitPageState();
}

class _FourLimitPageState extends State<FourLimitPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  TextEditingController _north;
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
          if (localdata.current_use_of_property == "6") {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: BuildingInfoPage(
                      localdata: localdata,
                    ),
                    type: PageTransitionType.rightToLeft));
          } else if (localdata.current_use_of_property == "7") {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: HomeSketchPage(
                      localdata: localdata,
                    ),
                    type: PageTransitionType.rightToLeft));
          } else if (localdata.current_use_of_property == "10") {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: HomeSketchPage(
                      localdata: localdata,
                    ),
                    type: PageTransitionType.rightToLeft));
          } else {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: LightingInfoPage(
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
        if (localdata.property_type == "1") {
          if (localdata.cityzenship_notice == "2") {
            Navigator.pushReplacement(
              context,
              PageTransition(
                  child: FirstPartnerPage(
                    localdata: localdata,
                  ),
                  type: PageTransitionType.leftToRight),
            );
          } else {
            Navigator.pushReplacement(
              context,
              PageTransition(
                  child: InfoPhotoHintPage(
                    localdata: localdata,
                  ),
                  type: PageTransitionType.leftToRight),
            );
          }
        } else {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: OtherPartnerInfoPage(
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
    _north = new TextEditingController(
        text: localdata.fore_limits_north?.isEmpty ?? true
            ? ""
            : localdata.fore_limits_north);
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
                        formheader(headerlablekey: 'key_four_limits'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield(
                                  maxLength: 256,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.boundaryinfonote?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.boundaryinfonote,
                                  headerlablekey:
                                      setapptext(key: 'key_property_note'),
                                  radiovalue:
                                      localdata.boundaryinfonote?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.boundaryinfonote = value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.boundaryinfonote = value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fore_limits_east?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fore_limits_east,
                                  headerlablekey: setapptext(key: 'key_east'),
                                  radiovalue:
                                      localdata.fore_limits_east?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  fieldrequired: true,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return setapptext(
                                          key: 'key_field_not_blank');
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.fore_limits_east = value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.fore_limits_east = value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fore_limits_west?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fore_limits_west,
                                  headerlablekey: setapptext(key: 'key_west'),
                                  radiovalue:
                                      localdata.fore_limits_west?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  fieldrequired: true,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return setapptext(
                                          key: 'key_field_not_blank');
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.fore_limits_west = value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.fore_limits_west = value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 120,
                                  inputFormatters: [],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  initvalue:
                                      localdata.fore_limits_south?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fore_limits_south,
                                  headerlablekey: setapptext(key: 'key_south'),
                                  radiovalue:
                                      localdata.fore_limits_south?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  fieldrequired: true,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return setapptext(
                                          key: 'key_field_not_blank');
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.fore_limits_south = value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.fore_limits_south = value.trim();
                                    setState(() {});
                                  }),
                              // formcardtextfield(
                              //     maxLength: 120,
                              //     inputFormatters: [],
                              //     enable:
                              //         localdata.isdrafted == 2 ? false : true,
                              //     initvalue:
                              //         localdata.fore_limits_north?.isEmpty ??
                              //                 true
                              //             ? ""
                              //             : localdata.fore_limits_north,
                              //     headerlablekey: setapptext(key: 'key_north'),
                              //     radiovalue:
                              //         localdata.fore_limits_north?.isEmpty ??
                              //                 true
                              //             ? CheckColor.Black
                              //             : CheckColor.Green,
                              //     fieldrequired: true,
                              //     validator: (value) {
                              //       if (value.trim().isEmpty) {
                              //         return setapptext(
                              //             key: 'key_field_not_blank');
                              //       }
                              //     },
                              //     onSaved: (value) {
                              //       localdata.fore_limits_north = value.trim();
                              //     },
                              //     onChanged: (value) {
                              //       localdata.fore_limits_north = value.trim();
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
                                                            .fore_limits_north
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
                                              child: Container(
                                                child: Text(
                                                  setapptext(key: 'key_north'),
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
                                            controller: _north,
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
                                              localdata.fore_limits_north =
                                                  value.trim();
                                            },
                                            validator: (value) {
                                              if (value.trim().isEmpty) {
                                                return setapptext(
                                                    key: 'key_field_not_blank');
                                              }
                                            },
                                            onChanged: (value) {
                                              localdata.fore_limits_north =
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
                                                isCompleted: localdata.home_map
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(key: 'key_home_map'),
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
                                                                  .fore_limits_north;

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
                                                                              localdata.home_map = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.home_map = await appimagepicker(source: ImageSource.gallery);
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
                                                                      .fore_limits_north =
                                                                  tempval;
                                                              _north.text =
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
                                                          .home_map?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : File(localdata.home_map)
                                                          .existsSync()
                                                      ? Image.file(
                                                          File(localdata
                                                              .home_map),
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
                                                            .home_photo
                                                            ?.isEmpty ??
                                                        true
                                                    ? CheckColor.Black
                                                    : CheckColor.Green),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key: 'key_home_photo'),
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
                                                                              localdata.home_photo = await appimagepicker(source: ImageSource.camera);
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
                                                                              localdata.home_photo = await appimagepicker(source: ImageSource.gallery);
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
                                              child: localdata.home_photo
                                                          ?.isEmpty ??
                                                      true
                                                  ? Center(
                                                      child: Text(setapptext(
                                                          key: 'key_no_image')),
                                                    )
                                                  : File(localdata.home_photo)
                                                          .existsSync()
                                                      ? Image.file(
                                                          File(localdata
                                                              .home_photo),
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
