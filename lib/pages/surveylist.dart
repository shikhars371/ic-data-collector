import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../models/localpropertydata.dart';
import './surveyinfo.dart';
import '../models/surveyAssignment.dart';
import '../controllers/appsync.dart';

class SurveyPage extends StatefulWidget {
  SurveyPage({this.surveyassignment});

  final SurveyAssignment surveyassignment;
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  double progressval = 0.0;

  static double remap(
      double value,
      double originalMinValue,
      double originalMaxValue,
      double translatedMinValue,
      double translatedMaxValue) {
    if (originalMaxValue - originalMinValue == 0) return 0;
    return (value - originalMinValue) /
            (originalMaxValue - originalMinValue) *
            (translatedMaxValue - translatedMinValue) +
        translatedMinValue;
  }

  void _setUploadProgress(int sentBytes, int totalBytes) {
    double __progressValue =
        remap(sentBytes.toDouble(), 0, totalBytes.toDouble(), 0, 1);

    __progressValue = double.parse(__progressValue.toStringAsFixed(2));

    if (__progressValue != progressval)
      setState(() {
        progressval = __progressValue;
      });
  }

  Widget listcard({LocalPropertySurvey surveydata}) {
    bool isprogress = false;
    _setUploadProgress(0, 0);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        text: setapptext(key: 'key_province') + ":-",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: getProvincename(surveydata.province),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        text: setapptext(key: 'key_city') + ":-",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: getCity(surveydata.city),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        text: setapptext(key: 'key_only_block') + ":-",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: surveydata.block,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        text: setapptext(key: 'key_part') + ":-",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: surveydata.part_number,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        text: setapptext(key: 'key_unit_no') + ":-",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: surveydata.unit_number,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      getStatus(surveydata.isdrafted),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: getStatusColor(surveydata.isdrafted)),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.topRight,
              child: Wrap(
                direction: Axis.horizontal,
                children: <Widget>[
                  IconButton(
                    iconSize: 25,
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SurveyInfoPage(
                            surveyAssignment: widget.surveyassignment,
                            localsurveykey: surveydata.local_property_key,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    iconSize: 25,
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title:
                                  Text(setapptext(key: 'key_want_to_delete')),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () async {
                                    DBHelper()
                                        .deletePropertySurvey(
                                            localkey:
                                                surveydata.local_property_key)
                                        .then((_) {
                                      Navigator.pop(context);
                                      Provider.of<DBHelper>(context)
                                          .getpropertysurveys(
                                              taskid:
                                                  widget.surveyassignment.id);
                                      setState(() {});
                                    });
                                  },
                                  child: Text(
                                    setapptext(key: 'key_delete'),
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    setapptext(key: 'key_cancel'),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            );
                          });
                    },
                  ),
                  IconButton(
                    iconSize: 25,
                    icon: Icon(
                        surveydata.isdrafted == 2 ? Icons.check : Icons.sync),
                    onPressed: () async {
                      setState(() {
                        isprogress = true;
                      });
                      if (surveydata.isdrafted == 1) {
                        //completed
                        bool result = await AppSync().fileUpload(
                            propertydata: surveydata,
                            uploadpreogress: _setUploadProgress);
                        if (result) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "Done",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                  content: Text("sync done"),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Ok"),
                                    ),
                                  ],
                                );
                              });
                        }
                        setState(() {
                          isprogress = false;
                        });
                      } else if (surveydata.isdrafted == 0) {
                        //if drafted
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Warning",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                content: Text(
                                    "Please complete the survey before sync."),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Ok"),
                                  ),
                                ],
                              );
                            });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          isprogress
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: LinearProgressIndicator(value: progressval),
                )
              : SizedBox()
        ],
      ),
    );
  }

  Widget syncProgress() {
    
  }

  String getProvincename(String id) {
    var result = "";
    switch (id) {
      case "01-01":
        result = "Kabul";
        break;
      case "06-01":
        result = "Nangarhar";
        break;
      case "33-01":
        result = "Kandahar";
        break;
      case "10-01":
        result = "Bamyan";
        break;
      case "22-01":
        result = "Daikundi";
        break;
      case "17-01":
        result = "Kundoz";
        break;
      case "18-01":
        result = "Balkh";
        break;
      case "30-01":
        result = "Herat";
        break;
      case "03-01":
        result = "Parwan";
        break;
      case "04-01":
        result = "Farah";
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
        result = "Kabul";
        break;
      case "2":
        result = "Jalalabad";
        break;
      case "3":
        result = "Kandahar";
        break;
      case "4":
        result = "Bamyan";
        break;
      case "5":
        result = "Nili";
        break;
      case "6":
        result = "Kundoz";
        break;
      case "7":
        result = "Sharif";
        break;
      case "8":
        result = "Herat";
        break;
      case "9":
        result = "Charikar";
        break;
      case "10":
        result = "Farah";
        break;
      default:
        result = id;
    }
    return result;
  }

  String getStatus(int status) {
    var result = "";
    switch (status) {
      case 0: //Drafted
        result = "Drafted";
        break;
      case 1: //Completed
        result = "Completed";
        break;
      case 2: //Synced
        result = "Synced";
        break;
      default:
        result = "";
    }
    return result;
  }

  Color getStatusColor(int status) {
    Color result = Colors.transparent;
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

  @override
  void initState() {
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: setapptext(key: 'key_add_property'),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate:
                      SurveySearch(surveyassignment: widget.surveyassignment));
            },
          )
        ],
      ),
      body: FutureBuilder(
        future:
            DBHelper().getpropertysurveys(taskid: widget.surveyassignment.id),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.assignment,
          size: 30,
        ),
        onPressed: () async {
          var result = await DBHelper().currentsurveycount(
              assignedcount: widget.surveyassignment.property_to_survey,
              taskid: widget.surveyassignment.id);
          if (result) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      "Warning",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    content: Text(setapptext(key: 'key_survey_excid')),
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
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => SurveyInfoPage(
                  surveyAssignment: widget.surveyassignment,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class SurveySearch extends SearchDelegate<String> {
  final SurveyAssignment surveyassignment;
  SurveySearch({this.surveyassignment});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    String setapptext({String key}) {
      return AppTranslations.of(context).text(key);
    }

    return Container(
      child: query.trim().length > 1
          ? FutureBuilder(
              future: DBHelper().getpropertysurveys(
                  taskid: surveyassignment.id, searchtext: query),
              builder: (context, snapshot) {
                List<LocalPropertySurvey> ls = snapshot.data;
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return ListView.builder(
                    itemCount: ls.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              setapptext(key: 'key_province') +
                                                  ":-",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ls[index].province,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          text: setapptext(key: 'key_city') +
                                              ":-",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ls[index].city,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          text: setapptext(
                                                  key: 'key_only_block') +
                                              ":-",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ls[index].block,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          text: setapptext(key: 'key_part') +
                                              ":-",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ls[index].part_number,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          text: setapptext(key: 'key_unit_no') +
                                              ":-",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ls[index].unit_number,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  children: <Widget>[
                                    IconButton(
                                      iconSize: 25,
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SurveyInfoPage(
                                              surveyAssignment:
                                                  surveyassignment,
                                              localsurveykey:
                                                  ls[index].local_property_key,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      iconSize: 25,
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) {
                                              return CupertinoAlertDialog(
                                                title: Text(setapptext(
                                                    key: 'key_want_to_delete')),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () async {
                                                      DBHelper()
                                                          .deletePropertySurvey(
                                                              localkey: ls[
                                                                      index]
                                                                  .local_property_key)
                                                          .then((_) {
                                                        Navigator.pop(context);
                                                        Provider.of<DBHelper>(
                                                                context)
                                                            .getpropertysurveys(
                                                                taskid: ls[
                                                                        index]
                                                                    .taskid);
                                                      });
                                                    },
                                                    child: Text(
                                                      setapptext(
                                                          key: 'key_delete'),
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      setapptext(
                                                          key: 'key_cancel'),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                    ),
                                    IconButton(
                                      iconSize: 25,
                                      icon: Icon(Icons.sync),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          : SizedBox(),
    );
  }
}
