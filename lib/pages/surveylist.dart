import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localization/app_translations.dart';
import './propertyregistation.dart';
import '../utils/db_helper.dart';
import '../controllers/auth.dart';
import '../models/localpropertydata.dart';
import './surveyinfo.dart';

class SurveyPage extends StatefulWidget {
  SurveyPage({this.id});
  final String id;
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  Widget listcard(
      {String localsurveyid,
      String status,
      Color statuscolor,
      String provinance,
      String city,
      String block,
      String part,
      String unitno}) {
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
                            text: provinance,
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
                            text: city,
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
                            text: block,
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
                            text: part,
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
                            text: unitno,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
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
                              PropertyRegistationPage(
                            taskid: widget.id,
                            surveylocalkey: localsurveyid,
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
                              title: Text('Are you want to delete ?'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () async {
                                    DBHelper()
                                        .deletePropertySurvey(
                                            localkey: localsurveyid)
                                        .then((_) {
                                      Navigator.pop(context);
                                      Provider.of<DBHelper>(context)
                                          .getpropertysurveys(
                                              taskid: widget.id);
                                      setState(() {});
                                    });
                                  },
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
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
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<DBHelper>(context).getpropertysurveys(taskid: widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Survey List",
          style: TextStyle(
              //color: Color.fromRGBO(192, 65, 25, 1),
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: "add new property",
            onPressed: () {
              showSearch(
                  context: context, delegate: SurveySearch(taskid: widget.id));
            },
          )
        ],
      ),
      body: Consumer<DBHelper>(
        builder: (context, dbdata, child) {
          return dbdata.state == AppState.Busy
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          itemCount: dbdata.propertysurveys?.isEmpty ?? true
                              ? 0
                              : dbdata.propertysurveys.length,
                          itemBuilder: (context, index) {
                            return listcard(
                                localsurveyid: dbdata
                                    .propertysurveys[index].local_property_key,
                                provinance:
                                    dbdata.propertysurveys[index].province,
                                city: dbdata.propertysurveys[index].city,
                                block: dbdata.propertysurveys[index].block,
                                part: dbdata.propertysurveys[index].part_number,
                                unitno:
                                    dbdata.propertysurveys[index].unit_number);
                          },
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.assignment,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => SurveyInfoPage(
                taskid: widget.id,
              ),
            ),
          );
        },
      ),
    );
  }
}

class SurveySearch extends SearchDelegate<String> {
  final String taskid;
  SurveySearch({this.taskid});

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
              future: DBHelper()
                  .getpropertysurveys(taskid: taskid, searchtext: query),
              builder: (context, snapshot) {
                List<LocalPropertySurvey> ls = snapshot.data;
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return ListView.builder(
                    itemCount: ls.length,
                    itemBuilder: (context,index){
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
                                      text: setapptext(key: 'key_province') +
                                          ":-",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ls[index].province,
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
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ls[index].city,
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
                                      text: setapptext(key: 'key_only_block') +
                                          ":-",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ls[index].block,
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
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ls[index].part_number,
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
                                      text:
                                          setapptext(key: 'key_unit_no') + ":-",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ls[index].unit_number,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
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
                                            PropertyRegistationPage(
                                          taskid: ls[index].taskid,
                                          surveylocalkey: ls[index].local_property_key,
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
                                            title: Text(
                                                'Are you want to delete ?'),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () async {
                                                  DBHelper()
                                                      .deletePropertySurvey(
                                                          localkey:
                                                              ls[index].local_property_key)
                                                      .then((_) {
                                                    Navigator.pop(context);
                                                    Provider.of<DBHelper>(
                                                            context)
                                                        .getpropertysurveys(
                                                            taskid: ls[index].taskid);
                                                    
                                                  });
                                                },
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Cancel",
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
