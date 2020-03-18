import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kapp/pages/fourlimit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './task.dart';

class HomeSketchPage extends StatefulWidget {
  HomeSketchPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _HomeSketchPageState createState() => _HomeSketchPageState();
}

class _HomeSketchPageState extends State<HomeSketchPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  FocusNode _area_unit_release_area;
  FocusNode _area_unit_business_area;
  FocusNode _area_unit_total_no_unit;
  FocusNode _area_unit_business_units;

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

  void updatePhotoStatus() {
    if (!(localdata.property_doc_photo_1?.isEmpty ?? true)) {
      localdata.isreldocphoto1 = 1;
    }
    if (!(localdata.property_doc_photo_2?.isEmpty ?? true)) {
      localdata.isreldocphoto2 = 1;
    }
    if (!(localdata.property_doc_photo_3?.isEmpty ?? true)) {
      localdata.isreldocphoto3 = 1;
    }
    if (!(localdata.property_doc_photo_4?.isEmpty ?? true)) {
      localdata.isreldocphoto4 = 1;
    }
    if (!(localdata.odinary_doc_photo1?.isEmpty ?? true)) {
      localdata.isoddocphoto1 = 1;
    }
    if (!(localdata.odinary_doc_photo6?.isEmpty ?? true)) {
      localdata.isoddocphoto6 = 1;
    }
    if (!(localdata.first_partner_name_property_owner?.isEmpty ?? true)) {
      localdata.isfirstpartner_photo = 1;
    }
    if (!(localdata.info_photo_hint_photo_note1?.isEmpty ?? true)) {
      localdata.isinfophotonote1 = 1;
    }
    if (!(localdata.info_photo_hint_photo_tips1?.isEmpty ?? true)) {
      localdata.isinfophototips1 = 1;
    }
    if (!(localdata.info_photo_hint_photo_tips2?.isEmpty ?? true)) {
      localdata.isinfophototips2 = 1;
    }
    if (!(localdata.second_partner_image?.isEmpty ?? true)) {
      localdata.issecond_partner_photo = 1;
    }
    if (!(localdata.second_partner_phote_note1?.isEmpty ?? true)) {
      localdata.issecond_partner_photo_note1 = 1;
    }
    if (!(localdata.second_partner_photo_tips1?.isEmpty ?? true)) {
      localdata.issecond_partner_photo_tips1 = 1;
    }
    if (!(localdata.second_partner_photo_tips2?.isEmpty ?? true)) {
      localdata.issecond_partner_photo_tips2 = 1;
    }
    if (!(localdata.third_partner_image?.isEmpty ?? true)) {
      localdata.isthird_partner_photo = 1;
    }
    if (!(localdata.third_partner_phote_note1?.isEmpty ?? true)) {
      localdata.isthird_partner_photo_note1 = 1;
    }
    if (!(localdata.third_partner_photo_tips1?.isEmpty ?? true)) {
      localdata.isthird_partner_photo_tips1 = 1;
    }
    if (!(localdata.third_partner_photo_tips2?.isEmpty ?? true)) {
      localdata.isthird_partner_photo_tips2 = 1;
    }
    if (!(localdata.fourth_partner_image?.isEmpty ?? true)) {
      localdata.isfourth_partner_photo = 1;
    }
    if (!(localdata.fourth_partner_phote_note1?.isEmpty ?? true)) {
      localdata.isfourth_partner_photo_note1 = 1;
    }
    if (!(localdata.fourth_partner_photo_tips1?.isEmpty ?? true)) {
      localdata.isfourth_partner_photo_tips1 = 1;
    }
    if (!(localdata.fourth_partner_photo_tips2?.isEmpty ?? true)) {
      localdata.isfourth_partner_photo_tips2 = 1;
    }
    if (!(localdata.fifth_partner_image?.isEmpty ?? true)) {
      localdata.isfifth_partner_photo = 1;
    }
    if (!(localdata.fifth_partner_phote_note1?.isEmpty ?? true)) {
      localdata.isfifth_partner_photo_note1 = 1;
    }
    if (!(localdata.fifth_partner_photo_tips1?.isEmpty ?? true)) {
      localdata.isfifth_partner_photo_tips1 = 1;
    }
    if (!(localdata.fifth_partner_photo_tips2?.isEmpty ?? true)) {
      localdata.isfifth_partner_photo_tips2 = 1;
    }
    if (!(localdata.lightning_picture_bell_power?.isEmpty ?? true)) {
      localdata.ismeter_pic_bill_power = 1;
    }
    if (!(localdata.safari_booklet_picture?.isEmpty ?? true)) {
      localdata.issafari_booklet_pic = 1;
    }
    if (!(localdata.home_map?.isEmpty ?? true)) {
      localdata.ishome_sketch_map = 1;
    }
    if (!(localdata.home_photo?.isEmpty ?? true)) {
      localdata.ishome_photo = 1;
    }
  }

  @override
  void initState() {
    localdata = new LocalPropertySurvey();
    localdata = widget.localdata;
    super.initState();
    _area_unit_release_area = new FocusNode();
    _area_unit_business_area = new FocusNode();
    _area_unit_total_no_unit = new FocusNode();
    _area_unit_business_units = new FocusNode();
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
                        formheader(headerlablekey: 'key_final_details'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield(
                                  maxLength: 9,
                                  inputFormatters: [
                                    
                                  ],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  keyboardtype: TextInputType.number,
                                  initvalue: localdata.area_unit_release_area
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.area_unit_release_area,
                                  headerlablekey:
                                      setapptext(key: 'key_release_area'),
                                  fieldfocus: _area_unit_release_area,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _area_unit_release_area.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_area_unit_business_area);
                                  },
                                  radiovalue: localdata.area_unit_release_area
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.area_unit_release_area = value;
                                  },
                                  onChanged: (value) {
                                    localdata.area_unit_release_area = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 9,
                                  inputFormatters: [
                                    
                                  ],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  keyboardtype: TextInputType.number,
                                  initvalue: localdata.area_unit_business_area
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.area_unit_business_area,
                                  headerlablekey:
                                      setapptext(key: 'key_business_area'),
                                  fieldfocus: _area_unit_business_area,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _area_unit_business_area.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_area_unit_total_no_unit);
                                  },
                                  radiovalue: localdata.area_unit_business_area
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.area_unit_business_area = value;
                                  },
                                  onChanged: (value) {
                                    localdata.area_unit_business_area = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 9,
                                  inputFormatters: [
                                    
                                  ],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  keyboardtype: TextInputType.number,
                                  initvalue: localdata.area_unit_total_no_unit
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.area_unit_total_no_unit,
                                  headerlablekey: setapptext(
                                      key: 'key_total_release_units'),
                                  fieldfocus: _area_unit_total_no_unit,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _area_unit_total_no_unit.unfocus();
                                    FocusScope.of(context).requestFocus(
                                        _area_unit_business_units);
                                  },
                                  radiovalue: localdata.area_unit_total_no_unit
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.area_unit_total_no_unit = value;
                                  },
                                  onChanged: (value) {
                                    localdata.area_unit_total_no_unit = value;
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  maxLength: 9,
                                  inputFormatters: [
                                    
                                  ],
                                  enable:
                                      localdata.isdrafted == 2 ? false : true,
                                  keyboardtype: TextInputType.number,
                                  initvalue: localdata.area_unit_business_units
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.area_unit_business_units,
                                  headerlablekey: setapptext(
                                      key: 'key_total_business_unit'),
                                  fieldfocus: _area_unit_business_units,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _area_unit_business_units.unfocus();
                                  },
                                  radiovalue: localdata.area_unit_business_units
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  onSaved: (value) {
                                    localdata.area_unit_business_units = value;
                                  },
                                  onChanged: (value) {
                                    localdata.area_unit_business_units = value;
                                    setState(() {});
                                  }),
                              localdata.isdrafted == 2
                                  ? SizedBox()
                                  : GestureDetector(
                                      onTap: () async {
                                        _formkey.currentState.save();
                                        localdata.other_key = "1";
                                        localdata.isdrafted = 1;
                                        localdata.surveyenddate =
                                            DateTime.now().toString();
                                        updatePhotoStatus();
                                        await DBHelper()
                                            .updatePropertySurvey(localdata,
                                                localdata.local_property_key)
                                            .then((_) {
                                          DBHelper().updateTaskCompleteStatus(
                                              taskid: localdata.taskid);
                                        });
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                TaskPage(),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 5.0,
                                                    color: Colors.black)
                                              ],
                                              color: Colors.blue),
                                          margin: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                          ),
                                          child: Center(
                                            child: Text(
                                              setapptext(key: 'key_submit'),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
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
                                      //back button
                                      backbutton(),
                                      //next button
                                      SizedBox()
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
