import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kapp/pages/fourlimit.dart';
import 'package:kapp/pages/homesketch.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

import '../models/localpropertydata.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './typepropertyuser.dart';
import '../utils/appstate.dart';

class BuildingInfoPage extends StatefulWidget {
  BuildingInfoPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _BuildingInfoPageState createState() => _BuildingInfoPageState();
}

class _BuildingInfoPageState extends State<BuildingInfoPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();

  ///for validation
  ///
  CheckColor fsthavingbuilding = CheckColor.Black;

  ///

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
                child: HomeSketchPage(
                  localdata: localdata,
                ),
                type: PageTransitionType.rightToLeft),
          );
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
        if (localdata.current_use_of_property == "6") {
          Navigator.pushReplacement(
            context,
            PageTransition(
                child: FourLimitPage(
                  localdata: localdata,
                ),
                type: PageTransitionType.leftToRight),
          );
        } else {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: TypePropertyUserPage(
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
                        formheader(headerlablekey: 'key_building_info'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formCardDropdown(
                                  fieldrequired: true,
                                  enable:
                                      localdata.isdrafted == 2 ? true : false,
                                  value: localdata.fst_have_building?.isEmpty ??
                                          true
                                      ? "0"
                                      : localdata.fst_have_building,
                                  iscompleted: ((localdata
                                                  .fst_have_building?.isEmpty ??
                                              true) ||
                                          (localdata.fst_have_building == "0"))
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  headerlablekey: setapptext(
                                      key: 'key_does_property_building'),
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_yes_sir'),
                                        value: "1"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_no'),
                                        value: "2")
                                  ],
                                  onSaved: (String value) {
                                    localdata.fst_have_building = value;
                                  },
                                  onChanged: (value) {
                                    localdata.fst_have_building = value;
                                    setState(() {
                                      localdata.fst_building_use = null;
                                      localdata.fst_building_category = null;
                                      localdata.fst_specifyif_other = null;
                                      localdata.fst_no_of_floors = null;
                                      localdata.fst_cubie_meter = null;
                                      localdata.snd_have_building = null;
                                      localdata.snd_building_use = null;
                                      localdata.snd_building_category = null;
                                      localdata.snd_no_of_floors = null;
                                      localdata.snd_cubie_meter = null;
                                      localdata.trd_have_building = null;
                                      localdata.snd_building_category = null;
                                      localdata.snd_specifyif_other = null;
                                      localdata.snd_no_of_floors = null;
                                      localdata.snd_cubie_meter = null;
                                      localdata.trd_have_building = null;
                                      localdata.trd_building_use = null;
                                      localdata.trd_building_category = null;
                                      localdata.trd_specifyif_other = null;
                                      localdata.trd_no_of_floors = null;
                                      localdata.trd_cubie_meter = null;
                                      localdata.forth_have_building = null;
                                      localdata.forth_building_use = null;
                                      localdata.forth_building_category = null;
                                      localdata.forth_specifyif_other = null;
                                      localdata.forth_no_of_floors = null;
                                      localdata.forth_cubie_meter = null;
                                      localdata.fth_have_building = null;
                                      localdata.fth_building_use = null;
                                      localdata.fth_building_category = null;
                                      localdata.fth_specifyif_other = null;
                                      localdata.fth_no_of_floors = null;
                                      localdata.fth_cubie_meter = null;
                                      fsthavingbuilding = ((localdata
                                                      .fst_have_building
                                                      ?.isEmpty ??
                                                  true) ||
                                              (localdata.fst_have_building ==
                                                  "0"))
                                          ? CheckColor.Black
                                          : CheckColor.Green;
                                    });
                                  },
                                  validate: (value) {
                                    if ((value.isEmpty) || value == "0") {
                                      return setapptext(key: 'key_required');
                                    }
                                  }),

                              ///first building
                              ///start
                              if (localdata.fst_have_building == "1") ...[
                                Container(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  child: Center(
                                    child: Text(
                                      setapptext(key: 'key_fst_building_info'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                formCardDropdown(
                                  fieldrequired: true,
                                  enable:
                                      localdata.isdrafted == 2 ? true : false,
                                  iscompleted: ((localdata
                                                  .fst_building_use?.isEmpty ??
                                              true) ||
                                          (localdata.fst_building_use == "0"))
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  headerlablekey:
                                      setapptext(key: 'key_building_use'),
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_release'),
                                        value: "1"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_commercial'),
                                        value: "2"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_govt'),
                                        value: "3"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_productive'),
                                        value: "4"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_general'),
                                        value: "5"),
                                  ],
                                  onChanged: (value) {
                                    localdata.fst_building_use = value;
                                    setState(() {});
                                  },
                                  onSaved: (value) {
                                    localdata.fst_building_use = value;
                                  },
                                  value: localdata.fst_building_use?.isEmpty ??
                                          true
                                      ? "0"
                                      : localdata.fst_building_use,
                                  validate: (value) {
                                    if ((value.isEmpty) || value == "0") {
                                      return setapptext(key: 'key_required');
                                    }
                                  },
                                ),
                                formCardDropdown(
                                    fieldrequired: true,
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    iscompleted: ((localdata
                                                    .fst_building_category
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.fst_building_category ==
                                                "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey: setapptext(
                                        key: 'key_building_category'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Modern_Concrete'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Concrete'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(
                                              key:
                                                  'key_Half_cream_and_half_baked'),
                                          value: "3"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Cream'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_metal'),
                                          value: "5"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_other1'),
                                          value: "6"),
                                    ],
                                    onChanged: (value) {
                                      localdata.fst_building_category = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.fst_building_category = value;
                                    },
                                    value: localdata.fst_building_category
                                                ?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.fst_building_category,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formcardtextfield(
                                    maxLength: 120,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    initvalue: localdata
                                                .fst_specifyif_other?.isEmpty ??
                                            true
                                        ? ""
                                        : localdata.fst_specifyif_other,
                                    headerlablekey:
                                        setapptext(key: 'key_choose_another'),
                                    hinttextkey: '',
                                    radiovalue: localdata
                                                .fst_specifyif_other?.isEmpty ??
                                            true
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.fst_specifyif_other =
                                          value.trim();
                                    },
                                    onChanged: (value) {
                                      localdata.fst_specifyif_other =
                                          value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    maxLength: 3,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.fst_no_of_floors?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.fst_no_of_floors,
                                    headerlablekey:
                                        setapptext(key: 'key_Number_of_floors'),
                                    hinttextkey: '',
                                    radiovalue:
                                        localdata.fst_no_of_floors?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.fst_no_of_floors = value.trim();
                                    },
                                    fieldrequired: true,
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.fst_no_of_floors = value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    maxLength: 6,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.fst_cubie_meter?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.fst_cubie_meter,
                                    headerlablekey:
                                        setapptext(key: 'key_Unit_Size'),
                                    hinttextkey: '',
                                    radiovalue:
                                        localdata.fst_cubie_meter?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.fst_cubie_meter = value.trim();
                                    },
                                    fieldrequired: true,
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.fst_cubie_meter = value.trim();
                                      setState(() {});
                                    }),
                                formCardDropdown(
                                    fieldrequired: true,
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    value:
                                        localdata.snd_have_building?.isEmpty ??
                                                true
                                            ? "0"
                                            : localdata.snd_have_building,
                                    iscompleted: ((localdata.snd_have_building
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.snd_have_building ==
                                                "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey:
                                        setapptext(key: 'key_add_building'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_yes_sir'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_no'),
                                          value: "2")
                                    ],
                                    onSaved: (String value) {
                                      localdata.snd_have_building = value;
                                    },
                                    onChanged: (value) {
                                      localdata.snd_have_building = value;
                                      setState(() {
                                        localdata.snd_building_use = null;
                                        localdata.snd_building_category = null;
                                        localdata.snd_specifyif_other = null;
                                        localdata.snd_no_of_floors = null;
                                        localdata.snd_cubie_meter = null;
                                        localdata.trd_have_building = null;
                                        localdata.trd_building_use = null;
                                        localdata.trd_building_category = null;
                                        localdata.trd_specifyif_other = null;
                                        localdata.trd_no_of_floors = null;
                                        localdata.trd_cubie_meter = null;
                                        localdata.forth_have_building = null;
                                        localdata.forth_building_use = null;
                                        localdata.forth_building_category =
                                            null;
                                        localdata.forth_specifyif_other = null;
                                        localdata.forth_no_of_floors = null;
                                        localdata.forth_cubie_meter = null;
                                        localdata.fth_have_building = null;
                                        localdata.fth_building_use = null;
                                        localdata.fth_building_category = null;
                                        localdata.fth_specifyif_other = null;
                                        localdata.fth_no_of_floors = null;
                                        localdata.fth_cubie_meter = null;
                                      });
                                    },
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                              ],

                              ///end
                              ///second building
                              ///start
                              if (localdata.snd_have_building == "1") ...[
                                Container(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  child: Center(
                                    child: Text(
                                      setapptext(
                                          key: 'key_second_building_info'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                formCardDropdown(
                                    fieldrequired: true,
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    iscompleted: ((localdata.snd_building_use
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.snd_building_use == "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey:
                                        setapptext(key: 'key_building_use'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_release'),
                                          value: "1"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_commercial'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_govt'),
                                          value: "3"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_productive'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_general'),
                                          value: "5"),
                                    ],
                                    onChanged: (value) {
                                      localdata.snd_building_use = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.snd_building_use = value;
                                    },
                                    value:
                                        localdata.snd_building_use?.isEmpty ??
                                                true
                                            ? "0"
                                            : localdata.snd_building_use,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formCardDropdown(
                                    fieldrequired: true,
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    iscompleted: ((localdata
                                                    .snd_building_category
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.snd_building_category ==
                                                "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey: setapptext(
                                        key: 'key_building_category'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Modern_Concrete'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Concrete'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(
                                              key:
                                                  'key_Half_cream_and_half_baked'),
                                          value: "3"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Cream'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_metal'),
                                          value: "5"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_other1'),
                                          value: "6"),
                                    ],
                                    onChanged: (value) {
                                      localdata.snd_building_category = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.snd_building_category = value;
                                    },
                                    value: localdata.snd_building_category
                                                ?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.snd_building_category,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formcardtextfield(
                                    maxLength: 120,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    initvalue: localdata
                                                .snd_specifyif_other?.isEmpty ??
                                            true
                                        ? ""
                                        : localdata.snd_specifyif_other,
                                    headerlablekey:
                                        setapptext(key: 'key_choose_another'),
                                    hinttextkey: '',
                                    radiovalue: localdata
                                                .snd_specifyif_other?.isEmpty ??
                                            true
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.snd_specifyif_other =
                                          value.trim();
                                    },
                                    onChanged: (value) {
                                      localdata.snd_specifyif_other =
                                          value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    maxLength: 3,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.snd_no_of_floors?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.snd_no_of_floors,
                                    headerlablekey:
                                        setapptext(key: 'key_Number_of_floors'),
                                    radiovalue:
                                        localdata.snd_no_of_floors?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.snd_no_of_floors = value.trim();
                                    },
                                    fieldrequired: true,
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.snd_no_of_floors = value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    maxLength: 6,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.snd_cubie_meter?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.snd_cubie_meter,
                                    headerlablekey:
                                        setapptext(key: 'key_Unit_Size'),
                                    radiovalue:
                                        localdata.snd_cubie_meter?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.snd_cubie_meter = value.trim();
                                    },
                                    fieldrequired: true,
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.snd_cubie_meter = value.trim();
                                      setState(() {});
                                    }),
                                formCardDropdown(
                                    fieldrequired: true,
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    value:
                                        localdata.trd_have_building?.isEmpty ??
                                                true
                                            ? "0"
                                            : localdata.trd_have_building,
                                    iscompleted: ((localdata.trd_have_building
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.trd_have_building ==
                                                "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey:
                                        setapptext(key: 'key_add_building'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_yes_sir'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_no'),
                                          value: "2")
                                    ],
                                    onSaved: (String value) {
                                      localdata.trd_have_building = value;
                                    },
                                    onChanged: (value) {
                                      localdata.trd_have_building = value;
                                      setState(() {
                                        localdata.trd_building_use = null;
                                        localdata.trd_building_category = null;
                                        localdata.trd_specifyif_other = null;
                                        localdata.trd_no_of_floors = null;
                                        localdata.trd_cubie_meter = null;
                                        localdata.forth_have_building = null;
                                        localdata.forth_building_use = null;
                                        localdata.forth_building_category =
                                            null;
                                        localdata.forth_specifyif_other = null;
                                        localdata.forth_no_of_floors = null;
                                        localdata.forth_cubie_meter = null;
                                        localdata.fth_have_building = null;
                                        localdata.fth_building_use = null;
                                        localdata.fth_building_category = null;
                                        localdata.fth_specifyif_other = null;
                                        localdata.fth_no_of_floors = null;
                                        localdata.fth_cubie_meter = null;
                                      });
                                    },
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                              ],

                              ///end
                              ///third building
                              ///start
                              if (localdata.trd_have_building == "1") ...[
                                Container(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  child: Center(
                                    child: Text(
                                      setapptext(
                                          key: 'key_third_building_info'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                formCardDropdown(
                                    fieldrequired: true,
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    iscompleted: ((localdata.trd_building_use
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.trd_building_use == "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey:
                                        setapptext(key: 'key_building_use'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_release'),
                                          value: "1"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_commercial'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_govt'),
                                          value: "3"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_productive'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_general'),
                                          value: "5"),
                                    ],
                                    onChanged: (value) {
                                      localdata.trd_building_use = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.trd_building_use = value;
                                    },
                                    value:
                                        localdata.trd_building_use?.isEmpty ??
                                                true
                                            ? "0"
                                            : localdata.trd_building_use,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formCardDropdown(
                                    fieldrequired: true,
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    iscompleted: ((localdata
                                                    .trd_building_category
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.trd_building_category ==
                                                "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey: setapptext(
                                        key: 'key_building_category'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Modern_Concrete'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Concrete'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(
                                              key:
                                                  'key_Half_cream_and_half_baked'),
                                          value: "3"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Cream'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_metal'),
                                          value: "5"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_other1'),
                                          value: "6"),
                                    ],
                                    onChanged: (value) {
                                      localdata.trd_building_category = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.trd_building_category = value;
                                    },
                                    value: localdata.trd_building_category
                                                ?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.trd_building_category,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formcardtextfield(
                                    maxLength: 120,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    initvalue: localdata
                                                .trd_specifyif_other?.isEmpty ??
                                            true
                                        ? ""
                                        : localdata.trd_specifyif_other,
                                    headerlablekey:
                                        setapptext(key: 'key_choose_another'),
                                    hinttextkey: '',
                                    radiovalue: localdata
                                                .trd_specifyif_other?.isEmpty ??
                                            true
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.trd_specifyif_other =
                                          value.trim();
                                    },
                                    onChanged: (value) {
                                      localdata.trd_specifyif_other =
                                          value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    maxLength: 3,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.trd_no_of_floors?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.trd_no_of_floors,
                                    headerlablekey:
                                        setapptext(key: 'key_Number_of_floors'),
                                    hinttextkey: '',
                                    radiovalue:
                                        localdata.trd_no_of_floors?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.trd_no_of_floors = value.trim();
                                    },
                                    fieldrequired: true,
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.trd_no_of_floors = value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    maxLength: 6,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.trd_cubie_meter?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.trd_cubie_meter,
                                    headerlablekey:
                                        setapptext(key: 'key_Unit_Size'),
                                    hinttextkey: '',
                                    radiovalue:
                                        localdata.trd_cubie_meter?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.trd_cubie_meter = value.trim();
                                    },
                                    fieldrequired: true,
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.trd_cubie_meter = value.trim();
                                      setState(() {});
                                    }),
                                formCardDropdown(
                                    fieldrequired: true,
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    value: localdata
                                                .forth_have_building?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.forth_have_building,
                                    iscompleted: ((localdata.forth_have_building
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.forth_have_building ==
                                                "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey:
                                        setapptext(key: 'key_add_building'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_yes_sir'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_no'),
                                          value: "2")
                                    ],
                                    onSaved: (String value) {
                                      localdata.forth_have_building = value;
                                    },
                                    onChanged: (value) {
                                      localdata.forth_have_building = value;
                                      setState(() {
                                        localdata.forth_building_use = null;
                                        localdata.forth_building_category =
                                            null;
                                        localdata.forth_specifyif_other = null;
                                        localdata.forth_no_of_floors = null;
                                        localdata.forth_cubie_meter = null;
                                        localdata.fth_have_building = null;
                                        localdata.fth_building_use = null;
                                        localdata.fth_building_category = null;
                                        localdata.fth_specifyif_other = null;
                                        localdata.fth_no_of_floors = null;
                                        localdata.fth_cubie_meter = null;
                                      });
                                    },
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                              ],

                              ///end

                              ///forth building
                              ///start
                              if (localdata.forth_have_building == "1") ...[
                                Container(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  child: Center(
                                    child: Text(
                                      setapptext(
                                          key: 'key_fourth_building_info'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                formCardDropdown(
                                    fieldrequired: true,
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    iscompleted: ((localdata.forth_building_use
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.forth_building_use ==
                                                "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey:
                                        setapptext(key: 'key_building_use'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_release'),
                                          value: "1"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_commercial'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_govt'),
                                          value: "3"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_productive'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_general'),
                                          value: "5"),
                                    ],
                                    onChanged: (value) {
                                      localdata.forth_building_use = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.forth_building_use = value;
                                    },
                                    value:
                                        localdata.forth_building_use?.isEmpty ??
                                                true
                                            ? "0"
                                            : localdata.forth_building_use,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formCardDropdown(
                                    fieldrequired: true,
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    iscompleted: ((localdata
                                                    .forth_building_category
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata
                                                    .forth_building_category ==
                                                "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey: setapptext(
                                        key: 'key_building_category'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Modern_Concrete'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Concrete'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(
                                              key:
                                                  'key_Half_cream_and_half_baked'),
                                          value: "3"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Cream'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_metal'),
                                          value: "5"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_other1'),
                                          value: "6"),
                                    ],
                                    onChanged: (value) {
                                      localdata.forth_building_category = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.forth_building_category = value;
                                    },
                                    value: localdata.forth_building_category
                                                ?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.forth_building_category,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formcardtextfield(
                                    maxLength: 120,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    initvalue: localdata.forth_specifyif_other
                                                ?.isEmpty ??
                                            true
                                        ? ""
                                        : localdata.forth_specifyif_other,
                                    headerlablekey:
                                        setapptext(key: 'key_choose_another'),
                                    hinttextkey: '',
                                    radiovalue: localdata.forth_specifyif_other
                                                ?.isEmpty ??
                                            true
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.forth_specifyif_other =
                                          value.trim();
                                    },
                                    onChanged: (value) {
                                      localdata.forth_specifyif_other =
                                          value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    maxLength: 3,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.forth_no_of_floors?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.forth_no_of_floors,
                                    headerlablekey:
                                        setapptext(key: 'key_Number_of_floors'),
                                    hinttextkey: '',
                                    radiovalue:
                                        localdata.forth_no_of_floors?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.forth_no_of_floors =
                                          value.trim();
                                    },
                                    fieldrequired: true,
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.forth_no_of_floors =
                                          value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    maxLength: 6,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.forth_cubie_meter?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.forth_cubie_meter,
                                    headerlablekey:
                                        setapptext(key: 'key_Unit_Size'),
                                    hinttextkey: '',
                                    radiovalue:
                                        localdata.forth_cubie_meter?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.forth_cubie_meter =
                                          value.trim();
                                    },
                                    fieldrequired: true,
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.forth_cubie_meter =
                                          value.trim();
                                      setState(() {});
                                    }),
                                formCardDropdown(
                                    fieldrequired: true,
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    value:
                                        localdata.fth_have_building?.isEmpty ??
                                                true
                                            ? "0"
                                            : localdata.fth_have_building,
                                    iscompleted: ((localdata.fth_have_building
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.fth_have_building ==
                                                "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey:
                                        setapptext(key: 'key_add_building'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_yes_sir'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_no'),
                                          value: "2")
                                    ],
                                    onSaved: (String value) {
                                      localdata.fth_have_building = value;
                                    },
                                    onChanged: (value) {
                                      localdata.fth_have_building = value;
                                      setState(() {
                                        localdata.fth_building_use = null;
                                        localdata.fth_building_category = null;
                                        localdata.fth_specifyif_other = null;
                                        localdata.fth_no_of_floors = null;
                                        localdata.fth_cubie_meter = null;
                                      });
                                    },
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                              ],

                              ///end

                              ///fifth building
                              ///start
                              if (localdata.fth_have_building == "1") ...[
                                Container(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  child: Center(
                                    child: Text(
                                      setapptext(
                                          key: 'key_fifth_builging_info'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                formCardDropdown(
                                  fieldrequired: true,
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    iscompleted: ((localdata.fth_building_use
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.fth_building_use == "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey:
                                        setapptext(key: 'key_building_use'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_release'),
                                          value: "1"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_commercial'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_govt'),
                                          value: "3"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_productive'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_general'),
                                          value: "5"),
                                    ],
                                    onChanged: (value) {
                                      localdata.fth_building_use = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.fth_building_use = value;
                                    },
                                    value:
                                        localdata.fth_building_use?.isEmpty ??
                                                true
                                            ? "0"
                                            : localdata.fth_building_use,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formCardDropdown(
                                  fieldrequired: true,
                                    enable:
                                        localdata.isdrafted == 2 ? true : false,
                                    iscompleted: ((localdata
                                                    .fth_building_category
                                                    ?.isEmpty ??
                                                true) ||
                                            (localdata.fth_building_category ==
                                                "0"))
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    headerlablekey: setapptext(
                                        key: 'key_building_category'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_Modern_Concrete'),
                                          value: "1"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Concrete'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(
                                              key:
                                                  'key_Half_cream_and_half_baked'),
                                          value: "3"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Cream'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_metal'),
                                          value: "5"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_other1'),
                                          value: "6"),
                                    ],
                                    onChanged: (value) {
                                      localdata.fth_building_category = value;
                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.fth_building_category = value;
                                    },
                                    value: localdata.fth_building_category
                                                ?.isEmpty ??
                                            true
                                        ? "0"
                                        : localdata.fth_building_category,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return setapptext(key: 'key_required');
                                      }
                                    }),
                                formcardtextfield(
                                    maxLength: 120,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    initvalue: localdata
                                                .fth_specifyif_other?.isEmpty ??
                                            true
                                        ? ""
                                        : localdata.fth_specifyif_other,
                                    headerlablekey:
                                        setapptext(key: 'key_choose_another'),
                                    hinttextkey: '',
                                    radiovalue: localdata
                                                .fth_specifyif_other?.isEmpty ??
                                            true
                                        ? CheckColor.Black
                                        : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.fth_specifyif_other =
                                          value.trim();
                                    },
                                    onChanged: (value) {
                                      localdata.fth_specifyif_other =
                                          value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    maxLength: 3,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.fth_no_of_floors?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.fth_no_of_floors,
                                    headerlablekey:
                                        setapptext(key: 'key_Number_of_floors'),
                                    radiovalue:
                                        localdata.fth_no_of_floors?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.fth_no_of_floors = value.trim();
                                    },
                                    fieldrequired: true,
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.fth_no_of_floors = value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    maxLength: 6,
                                    inputFormatters: [],
                                    enable:
                                        localdata.isdrafted == 2 ? false : true,
                                    keyboardtype: TextInputType.number,
                                    initvalue:
                                        localdata.fth_cubie_meter?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.fth_cubie_meter,
                                    headerlablekey:
                                        setapptext(key: 'key_Unit_Size'),
                                    hinttextkey: '',
                                    radiovalue:
                                        localdata.fth_cubie_meter?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                    onSaved: (value) {
                                      localdata.fth_cubie_meter = value.trim();
                                    },
                                    fieldrequired: true,
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onChanged: (value) {
                                      localdata.fth_cubie_meter = value.trim();
                                      setState(() {});
                                    })
                              ],

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
