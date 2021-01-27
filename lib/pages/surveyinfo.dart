import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

import '../localization/app_translations.dart';
import '../models/localpropertydata.dart';
import '../utils/db_helper.dart';
import '../utils/appstate.dart';
import './generalinfoone.dart';
import '../widgets/appformcards.dart';
import '../models/surveyAssignment.dart';

class SurveyInfoPage extends StatefulWidget {
  SurveyInfoPage(
      {this.localdata,
      this.localsurveykey,
      this.surveyAssignment,
      this.surveyDetails,
      this.surveyList});
  final LocalPropertySurvey localdata;
  final String localsurveykey;
  final SurveyAssignment surveyAssignment;
  final surveyDetails;
  List surveyList;
  @override
  _SurveyInfoPageState createState() =>
      _SurveyInfoPageState(surveyDetails, surveyList);
}

class _SurveyInfoPageState extends State<SurveyInfoPage> {
  _SurveyInfoPageState(this.surveyDetails, this.surveyList);
  final surveyDetails;
  List surveyList;
  String defaultSurveyId1;
  String currentSurveyId;
  String currentSurveyName;
  bool display1 = true;
  Widget wrapContaint({String titel, String subtitel}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Text(titel),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Text(
            subtitel,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  FocusNode _firstsurveyor;
  FocusNode _secondsurveyor;
  FocusNode _technicalsupport;
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
          if (widget.localdata != null) {
            localdata = widget.localdata;
          }
          if (widget.surveyAssignment != null) {
            localdata.taskid = widget.surveyAssignment.id;
          }
          if (localdata.editmode == 1) {
            localdata = Provider.of<DBHelper>(context).singlepropertysurveys;
            localdata.editmode = 1;
          }
          if (widget.surveyAssignment != null) {
            localdata.first_surveyor_name = surveyDetails.first_name;
            localdata.senond_surveyor_name =
                widget.surveyAssignment.surveyortwoname;
            localdata.technical_support_name =
                widget.surveyAssignment.teamleadname;
            localdata.province = widget.surveyAssignment.province;
            localdata.city = widget.surveyAssignment.municpality;
            localdata.area = widget.surveyAssignment.nahia;
            localdata.pass = widget.surveyAssignment.gozar;
            localdata.block = widget.surveyAssignment.block;
            localdata.surveyoroneid = widget.surveyAssignment.surveyor1;
            localdata.surveyortwoid = widget.surveyAssignment.surveyor2;
            localdata.surveyleadid = widget.surveyAssignment.teamlead;
            localdata.other_key =
                (widget.surveyAssignment.reworkstatus?.isEmpty ?? true)
                    ? "Survey Completed"
                    : widget.surveyAssignment.reworkstatus;
          }
          Navigator.pushReplacement(
            context,
            PageTransition(
                child: GeneralInfoOnePage(
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

  String getProvincename(String id) {
    var result = "";
    switch (id) {
      case "01-01":
        result = setapptext(key: 'key_kabul');
        break;
      case "06-01":
        result = setapptext(key: 'key_nangarhar');
        break;
      case "33-01":
        result = setapptext(key: 'key_Kandahar');
        break;
      case "10-01":
        result = setapptext(key: 'key_Bamyan');
        break;
      case "22-01":
        result = setapptext(key: 'key_Daikundi');
        break;
      case "17-01":
        result = setapptext(key: 'key_Kundoz');
        break;
      case "18-01":
        result = setapptext(key: 'key_Balkh');
        break;
      case "30-01":
        result = setapptext(key: 'key_Herat');
        break;
      case "03-01":
        result = setapptext(key: 'key_Parwan');
        break;
      case "04-01":
        result = setapptext(key: 'key_Farah');
        break;
      default:
        result = id;
    }
    return result;
  }

  String getCity(String id) {
    var result = "";
    switch (id) {
      case "1":
        result = setapptext(key: 'key_kabul');
        break;
      case "2":
        result = setapptext(key: 'key_Jalalabad');
        break;
      case "3":
        result = setapptext(key: 'key_Kandahar');
        break;
      case "4":
        result = setapptext(key: 'key_Bamyan');
        break;
      case "5":
        result = setapptext(key: 'key_Nili');
        break;
      case "6":
        result = setapptext(key: 'key_Kundoz');
        break;
      case "7":
        result = setapptext(key: 'key_Sharif');
        break;
      case "8":
        result = setapptext(key: 'key_Herat');
        break;
      case "9":
        result = setapptext(key: 'key_Charikar');
        break;
      case "10":
        result = setapptext(key: 'key_Farah');
        break;
      default:
        result = id;
    }
    return result;
  }

  Widget completedcheckbox({bool isCompleted}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          //color: Colors.white,
          shape: BoxShape.rectangle,
          border: Border.all(
              color: isCompleted ? Colors.lightGreen : Colors.black, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: BoxDecoration(
              color: isCompleted ? Colors.lightGreen : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    localdata = new LocalPropertySurvey();
    _firstsurveyor = new FocusNode();
    _secondsurveyor = new FocusNode();
    _technicalsupport = new FocusNode();
    localdata.taskid = surveyDetails["_id"];

  
    print(
        "current survery details ====== ${currentSurveyId},${currentSurveyName}");
    print("survery list ====== ${surveyList}");
    defaultSurveyId1 = '';
    if (widget.localdata != null) {
      localdata = widget.localdata;
    }
    if (widget.surveyAssignment != null) {
      localdata.first_surveyor_name = widget.surveyAssignment.surveyoronename;
      localdata.senond_surveyor_name = widget.surveyAssignment.surveyortwoname;
      localdata.technical_support_name = widget.surveyAssignment.teamleadname;
    }
    if (!(widget.localsurveykey?.isEmpty ?? true)) {
      Future.delayed(Duration.zero).then((_) {
        Provider.of<DBHelper>(context).getSingleProperty(
            taskid: widget.surveyAssignment.id,
            localkey: widget.localsurveykey);
      });
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!(widget.localsurveykey?.isEmpty ?? true)) {
      localdata = Provider.of<DBHelper>(context).singlepropertysurveys;
      localdata.editmode = 1;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("++++++++++++++++++++${surveyDetails["first_name"]}");
    if (!(widget.localsurveykey?.isEmpty ?? true)) {
      localdata = Provider.of<DBHelper>(context).singlepropertysurveys;
      localdata.editmode = 1;
      localdata.first_surveyor_name = widget.surveyAssignment.surveyoronename;
      localdata.senond_surveyor_name = widget.surveyAssignment.surveyortwoname;
      localdata.technical_support_name = widget.surveyAssignment.teamleadname;
    }
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
          // localdata = dbdata.singlepropertysurveys;
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
                        formheader(headerlablekey: 'key_provider_details'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              localdata.editmode == 1
                                  ? Wrap(
                                      runAlignment: WrapAlignment.spaceBetween,
                                      runSpacing: 20,
                                      spacing: 20,
                                      children: <Widget>[
                                        wrapContaint(
                                            titel:
                                                setapptext(key: 'key_province'),
                                            subtitel: getProvincename(
                                                localdata.province?.isEmpty ??
                                                        true
                                                    ? ""
                                                    : localdata.province)),
                                        wrapContaint(
                                            titel: setapptext(
                                                key: 'key_municipality'),
                                            subtitel: getCity(
                                                localdata.city?.isEmpty ?? true
                                                    ? ""
                                                    : localdata.city)),
                                        wrapContaint(
                                            titel: setapptext(key: 'key_nahia'),
                                            subtitel:
                                                localdata.area?.isEmpty ?? true
                                                    ? ""
                                                    : localdata.area),
                                        wrapContaint(
                                            titel: setapptext(key: 'key_gozar'),
                                            subtitel:
                                                localdata.pass?.isEmpty ?? true
                                                    ? ""
                                                    : localdata.pass),
                                        wrapContaint(
                                            titel: setapptext(
                                                key: 'key_only_block'),
                                            subtitel:
                                                localdata.block?.isEmpty ?? true
                                                    ? ""
                                                    : localdata.block),
                                        wrapContaint(
                                            titel:
                                                setapptext(key: 'key_parcel'),
                                            subtitel: localdata
                                                        .part_number?.isEmpty ??
                                                    true
                                                ? ""
                                                : localdata.part_number),
                                        wrapContaint(
                                            titel:
                                                setapptext(key: 'key_unit_no'),
                                            subtitel: localdata
                                                        .unit_number?.isEmpty ??
                                                    true
                                                ? ""
                                                : localdata.unit_number),
                                      ],
                                    )
                                  // ? Container(
                                  //     padding:
                                  //         EdgeInsets.only(left: 15, right: 15),
                                  //     child: Column(
                                  //       children: <Widget>[
                                  //         Row(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.spaceBetween,
                                  //           children: <Widget>[
                                  //             Flexible(
                                  //               fit: FlexFit.tight,
                                  //               flex: 3,
                                  //               child: Wrap(
                                  //                 direction: Axis.vertical,
                                  //                 children: <Widget>[
                                  //                   Text(setapptext(
                                  //                       key: 'key_province')),
                                  //                   Text(
                                  //                     getProvincename(localdata
                                  //                                 .province
                                  //                                 ?.isEmpty ??
                                  //                             true
                                  //                         ? ""
                                  //                         : localdata.province),
                                  //                     style: TextStyle(
                                  //                         fontWeight:
                                  //                             FontWeight.bold),
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             Flexible(
                                  //               fit: FlexFit.tight,
                                  //               flex: 3,
                                  //               child: Wrap(
                                  //                 direction: Axis.vertical,
                                  //                 children: <Widget>[
                                  //                   Text(setapptext(
                                  //                       key: 'key_city')),
                                  //                   Text(
                                  //                     getCity(localdata.city
                                  //                                 ?.isEmpty ??
                                  //                             true
                                  //                         ? ""
                                  //                         : localdata.city),
                                  //                     style: TextStyle(
                                  //                         fontWeight:
                                  //                             FontWeight.bold),
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             Flexible(
                                  //               fit: FlexFit.tight,
                                  //               child: Wrap(
                                  //                 direction: Axis.vertical,
                                  //                 children: <Widget>[
                                  //                   Text(setapptext(
                                  //                       key: 'key_only_block')),
                                  //                   Text(
                                  //                     localdata.block
                                  //                                 ?.isEmpty ??
                                  //                             true
                                  //                         ? ""
                                  //                         : localdata.block,
                                  //                     style: TextStyle(
                                  //                         fontWeight:
                                  //                             FontWeight.bold),
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             )
                                  //           ],
                                  //         ),
                                  //         SizedBox(
                                  //           height: 15,
                                  //         ),
                                  //         Row(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.spaceBetween,
                                  //           children: <Widget>[
                                  //             Flexible(
                                  //               fit: FlexFit.tight,
                                  //               flex: 3,
                                  //               child: Wrap(
                                  //                 direction: Axis.vertical,
                                  //                 children: <Widget>[
                                  //                   Text(setapptext(
                                  //                       key: 'key_part')),
                                  //                   Text(
                                  //                     localdata.part_number
                                  //                                 ?.isEmpty ??
                                  //                             true
                                  //                         ? ""
                                  //                         : localdata
                                  //                             .part_number,
                                  //                     style: TextStyle(
                                  //                         fontWeight:
                                  //                             FontWeight.bold),
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             Flexible(
                                  //               fit: FlexFit.tight,
                                  //               flex: 3,
                                  //               child: Wrap(
                                  //                 direction: Axis.vertical,
                                  //                 children: <Widget>[
                                  //                   Text(setapptext(
                                  //                       key: 'key_unit_no')),
                                  //                   Text(
                                  //                     localdata.unit_number
                                  //                                 ?.isEmpty ??
                                  //                             true
                                  //                         ? ""
                                  //                         : localdata
                                  //                             .unit_number,
                                  //                     style: TextStyle(
                                  //                         fontWeight:
                                  //                             FontWeight.bold),
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             Flexible(
                                  //                 fit: FlexFit.tight,
                                  //                 child: SizedBox())
                                  //           ],
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   )
                                  : SizedBox(),
                              formcardtextfield1(
                                  enable: false,
                                  fieldrequired: true,
                                  surveyList: surveyList,
                                  headerlablekey:
                                      setapptext(key: 'key_first_surveyor'),
                                  radiovalue:
                                      localdata.first_surveyor_name?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  hinttextkey:
                                      setapptext(key: 'key_enter_1st_surveyor'),
                                  fieldfocus: _firstsurveyor,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _firstsurveyor.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_secondsurveyor);
                                  },
                                  initvalue:
                                      surveyDetails["first_name"]?.isEmpty ??
                                              true
                                          ? ""
                                          : surveyDetails["first_name"],
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return setapptext(
                                          key: 'key_field_not_blank');
                                    }
                                  },
                                  onSaved: (value) {
                                    print("+++++++++++++++++++++3333++$value");
                                    localdata.first_surveyor_name =
                                        value.trim();
                                    localdata.taskid =
                                        value.trim();
                                        setState(() {
                                      // display1 = false;
                                    });
                                  },
                                  onChanged: (value) {
                                    print("+++++++++22+++++++$value");
                                    localdata.first_surveyor_name =
                                        value.trim();
                                    localdata.taskid =
                                        value.trim();
                                    setState(() {
                                      // display1 = false;
                                    });
                                    print(
                                        "+++++++++++++++++++++3333++,${localdata.first_surveyor_name}");
                                  }),
                              formcardtextfield1(
                                  enable: false,
                                  fieldrequired: true,
                                  surveyList: surveyList,
                                  headerlablekey:
                                      setapptext(key: 'key_second_surveyor'),
                                  radiovalue:
                                      localdata.senond_surveyor_name?.isEmpty ??
                                              true
                                          ? CheckColor.Black
                                          : CheckColor.Green,
                                  hinttextkey:
                                      setapptext(key: 'key_enter_1st_surveyor'),
                                  fieldfocus: _secondsurveyor,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _secondsurveyor.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_technicalsupport);
                                  },
                                  initvalue:
                                      localdata.senond_surveyor_name?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.senond_surveyor_name,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return setapptext(
                                          key: 'key_field_not_blank');
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.senond_surveyor_name =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.senond_surveyor_name =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield1(
                                  enable: false,
                                  fieldrequired: true,
                                  surveyList: surveyList,
                                  headerlablekey: setapptext(
                                      key: 'key_name_technical_support'),
                                  radiovalue: localdata.technical_support_name
                                              ?.isEmpty ??
                                          true
                                      ? CheckColor.Black
                                      : CheckColor.Green,
                                  hinttextkey:
                                      setapptext(key: 'key_enter_1st_surveyor'),
                                  fieldfocus: _technicalsupport,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _technicalsupport.unfocus();
                                  },
                                  initvalue: localdata.technical_support_name
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.technical_support_name,
                                  validator: (value) {},
                                  onSaved: (value) {
                                    localdata.technical_support_name =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.technical_support_name =
                                        value.trim();
                                    setState(() {});
                                  }),
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
                                      SizedBox(),
                                      //next button
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
