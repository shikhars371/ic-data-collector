import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localization/app_translations.dart';
import '../models/localpropertydata.dart';
import '../utils/db_helper.dart';
import '../controllers/auth.dart';
import './generalinfoone.dart';
import '../widgets/appformcards.dart';

class SurveyInfoPage extends StatefulWidget {
  SurveyInfoPage({this.localdata, this.taskid, this.localsurveykey});
  final LocalPropertySurvey localdata;
  final String taskid;
  final String localsurveykey;
  @override
  _SurveyInfoPageState createState() => _SurveyInfoPageState();
}

class _SurveyInfoPageState extends State<SurveyInfoPage> {
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
          localdata.taskid = widget.taskid;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => GeneralInfoOnePage(
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
              setapptext(key: 'key_next'),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
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
    if (widget.localdata != null) {
      localdata = widget.localdata;
    }
    if (!(widget.localsurveykey?.isEmpty ?? true)) {
      Future.delayed(Duration.zero).then((_) {
        Provider.of<DBHelper>(context).getSingleProperty(
            taskid: widget.taskid, localkey: widget.localsurveykey);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!(widget.localsurveykey?.isEmpty ?? true)) {
      localdata = Provider.of<DBHelper>(context).singlepropertysurveys;
      localdata.editmode = 1;
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
                              formcardtextfield(
                                  headerlablekey:
                                      setapptext(key: 'key_first_surveyor'),
                                  radiovalue:
                                      localdata.first_surveyor_name?.isEmpty ??
                                              true
                                          ? false
                                          : true,
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
                                      localdata.first_surveyor_name?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.first_surveyor_name,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return setapptext(
                                          key: 'key_field_not_blank');
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.first_surveyor_name =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.first_surveyor_name =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  headerlablekey:
                                      setapptext(key: 'key_second_surveyor'),
                                  radiovalue:
                                      localdata.senond_surveyor_name?.isEmpty ??
                                              true
                                          ? false
                                          : true,
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
                              formcardtextfield(
                                  headerlablekey: setapptext(
                                      key: 'key_name_technical_support'),
                                  radiovalue: localdata.technical_support_name
                                              ?.isEmpty ??
                                          true
                                      ? false
                                      : true,
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
