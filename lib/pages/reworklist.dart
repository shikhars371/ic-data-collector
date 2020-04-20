import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/reworkassignment.dart';
import '../localization/app_translations.dart';
import '../models/localpropertydata.dart';
import './surveyinfo.dart';
import '../utils/db_helper.dart';
import '../models/surveyAssignment.dart';
import './surveylist.dart';

class RewokListPage extends StatefulWidget {
  RewokListPage({this.sid});
  final ReworkAssignment sid;
  @override
  _RewokListPageState createState() => _RewokListPageState();
}

class _RewokListPageState extends State<RewokListPage> {
  SurveyAssignment surveyAssignment;
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  Widget listcard({LocalPropertySurvey surveydata}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.all(5.0),
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(getProvincename(surveydata.province) +
                    "-" +
                    getCity(surveydata.city) +
                    "-" +
                    surveydata.area +
                    "-" +
                    surveydata.pass +
                    "-" +
                    surveydata.block +
                    "-" +
                    surveydata.part_number +
                    "-" +
                    surveydata.unit_number),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      getStatus(surveydata.isdrafted),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: getStatusColor(surveydata.isdrafted),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        ///edit icon
                        surveydata.isdrafted == 2
                            ? IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SurveyInfoPage(
                                        surveyAssignment: surveyAssignment,
                                        localsurveykey:
                                            surveydata.local_property_key,
                                      ),
                                    ),
                                  );
                                })
                            : IconButton(
                                iconSize: 25,
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SurveyInfoPage(
                                        surveyAssignment: surveyAssignment,
                                        localsurveykey:
                                            surveydata.local_property_key,
                                      ),
                                    ),
                                  );
                                },
                              ),
                        //upload icon
                        surveydata.isdrafted == 2
                            ? SizedBox()
                            : IconButton(
                                iconSize: 25,
                                icon: Icon(
                                  Icons.file_upload,
                                  color: surveydata.isdrafted == 0
                                      ? Colors.grey
                                      : Colors.green,
                                ),
                                onPressed: () async {
                                  if (surveydata.isdrafted == 1) {
                                    //completed
                                    var result = await showDialog<bool>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return UploadData(
                                              propertydata: surveydata);
                                        });
                                    if (!(result)) {
                                      setState(() {});
                                    }
                                  } else if (surveydata.isdrafted == 0) {
                                    //if drafted
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              setapptext(key: 'key_warning'),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            ),
                                            content: Text(setapptext(
                                                key: 'key_comp_sync')),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  setapptext(key: 'key_ok'),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                },
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            ListTile(
              isThreeLine: true,
              title: Text(setapptext(key: 'key_enter_any_mere')),
              subtitle: Text(widget.sid.remarks),
            )
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

  String getStatus(int status) {
    var result = setapptext(key: 'key_Drafted');
    switch (status) {
      case 0: //Drafted
        result = setapptext(key: 'key_Drafted');
        break;
      case 1: //Completed
        result = setapptext(key: 'key_completed');
        break;
      case 2: //Synced
        result = setapptext(key: 'key_synced');
        break;
      default:
        result = "";
    }
    return result;
  }

  Color getStatusColor(int status) {
    Color result = Color.fromRGBO(189, 148, 36, 1);
    switch (status) {
      case 0: //Drafted
        result = Color.fromRGBO(189, 148, 36, 1);
        break;
      case 1: //Completed
        result = Colors.lightGreen;
        break;
      case 2: //Synced
        result = Colors.lightBlue;
        break;
    }
    return result;
  }

  void convertToSurveyAssignment({ReworkAssignment reworkAssignment}) {
    surveyAssignment = new SurveyAssignment();
    surveyAssignment.id = reworkAssignment.sid;
    surveyAssignment.teamlead = reworkAssignment.surveylead;
    surveyAssignment.teamleadname = reworkAssignment.surveyleadname;
    surveyAssignment.surveyor1 = reworkAssignment.surveyor1;
    surveyAssignment.surveyoronename = reworkAssignment.surveyoronename;
    surveyAssignment.surveyor2 = reworkAssignment.surveyor2;
    surveyAssignment.surveyortwoname = reworkAssignment.surveyortwoname;
    surveyAssignment.province = reworkAssignment.province;
    surveyAssignment.municpality = reworkAssignment.municipality;
    surveyAssignment.nahia = reworkAssignment.nahia;
    surveyAssignment.gozar = reworkAssignment.gozar;
    surveyAssignment.block = reworkAssignment.block;
    surveyAssignment.startDate = reworkAssignment.createdate;
    surveyAssignment.taskStatus = reworkAssignment.surveystatus;
    surveyAssignment.reworkstatus = reworkAssignment.status;
  }

  @override
  void initState() {
    convertToSurveyAssignment(reworkAssignment: widget.sid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          setapptext(key: 'key_survey_list'),
          style: TextStyle(
              //color: Color.fromRGBO(192, 65, 25, 1),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: DBHelper().getpropertysurveys(
            localkey: (widget.sid.province +
                widget.sid.municipality +
                widget.sid.nahia +
                widget.sid.gozar +
                widget.sid.block +
                widget.sid.parcelno +
                widget.sid.unit)),
        builder:
            (context, AsyncSnapshot<List<LocalPropertySurvey>> surveydata) {
          if (surveydata.connectionState == ConnectionState.done &&
              surveydata.hasData) {
            List<LocalPropertySurvey> dbdata = surveydata.data;
            return SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: dbdata?.isEmpty ?? true ? 0 : dbdata.length,
                      itemBuilder: (context, index) {
                        return listcard(surveydata: dbdata[index]);
                      },
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
