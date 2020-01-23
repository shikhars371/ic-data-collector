import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapp/controllers/auth.dart';
import 'package:provider/provider.dart';

import '../localization/app_translations.dart';
import './propertyregistation.dart';
import '../utils/db_helper.dart';

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
                    iconSize: 16,
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
                    iconSize: 16,
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
                                    await DBHelper().deletePropertySurvey(
                                        localkey: localsurveyid);
                                    Navigator.pop(context);
                                    setState(() {});
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
                    iconSize: 16,
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
            onPressed: () {},
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
              builder: (BuildContext context) => PropertyRegistationPage(
                taskid: widget.id,
              ),
            ),
          );
        },
      ),
    );
  }
}
