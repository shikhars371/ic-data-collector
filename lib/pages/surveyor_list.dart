import 'dart:convert';
import 'package:kapp/localization/app_translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/appdrawer.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'surveylist.dart';

class SurveyoerList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SurveyorList();
}

class _SurveyorList extends State<SurveyoerList> {
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }
  List surveyList;
  bool _prograssbar = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchJobs();
  }

  void _fetchJobs() async {
    var preferences = await SharedPreferences.getInstance();
    var role_id = preferences.getString("new_role_id");
    final jobsListAPIUrl =
        'http://13.234.225.179:3002/users?role_id=${role_id}';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      final data1 = json.decode(response.body);
      print("surveylist ============ $data1");
      setState(() {
        surveyList = data1["data"];
        _prograssbar = false;
      });
      // return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_prograssbar) {
      print("=====datalength ============ ,${surveyList.length},$_prograssbar");
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
                                                setapptext(key: 'key_surveyor_list'),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        drawer: AppDrawer(),
        body: _prograssbar == true
            ? new Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: surveyList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: new InkWell(
                      onTap: () {
                        print("tapped");
                      },
                      child: Container(
                          width: 100.0,
                          height: 100.0,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  new Text(
                                    "Surveyor Name:- ${surveyList[index]["first_name"]} ${surveyList[index]["last_name"]}",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                  // new Text(
                                      // "Survey-Emailid:- ${surveyList[index]["email"]}",
                                      // style: TextStyle(fontSize: 12.0)),
                                ],
                              ),
                              new RaisedButton(
                                color: Colors.blue,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SurveyPage(
                                                surveyDetails:
                                                    surveyList[index],
                                                surveyList: surveyList,
                                              )));
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red)),
                                child: new Text(
                                  setapptext(key: 'key_continue'),
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          )),
                    ),
                  );
                }));
  }
}
