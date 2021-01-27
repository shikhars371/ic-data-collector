import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/appdrawer.dart';
import '../localization/app_translations.dart';
import '../controllers/reworktask.dart';
import '../models/reworkassignment.dart';
import './reworklist.dart';

class ReworkTaskPage extends StatefulWidget {
  @override
  _ReworkTaskPageState createState() => _ReworkTaskPageState();
}

class _ReworkTaskPageState extends State<ReworkTaskPage> {
  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  String workstatus({int status}) {
    String result = "";
    if (status != null) {
      if (status == 0) {
        result = setapptext(key: 'key_not_started');
      } else if (status == 1) {
        result = setapptext(key: 'key_in_progress');
      } else if (status == 2) {
        result = setapptext(key: 'key_completed');
      } else if (status == 3) {
        result = setapptext(key: 'key_synced');
      }
    }
    return result;
  }

  Color workstatuscolor({int status}) {
    Color result = Colors.transparent;
    if (status != null) {
      if (status == 0) {
        result = Color.fromRGBO(189, 148, 36, 1);
      } else if (status == 1) {
        result = Colors.lightGreen;
      } else if (status == 2) {
        result = Colors.green;
      } else if (status == 3) {
        result = Colors.lightBlue;
      }
    }
    return result;
  }

  Widget listcard(
      {ReworkAssignment id,
      String status,
      Color statuscolor,
      String provinance,
      String nahia,
      String gozar,
      String assigndate}) {
    return Card(
      elevation: 3.0,
      child: Container(
        decoration: BoxDecoration(
            //color: Color.fromRGBO(242, 239, 230, 1),
            ),
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                id.province + "-" + id.nahia + "-" + id.gozar+"-"+id.block,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Wrap(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Text(
                      setapptext(key: 'key_assigned_date'),
                    ),
                    Text(
                      DateFormat.yMd().format(
                        DateTime.parse(assigndate),
                      ),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Wrap(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Text(
                      setapptext(key: 'key_status'),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                          color: statuscolor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => RewokListPage(
                      sid: id,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(blurRadius: 5.0, color: Colors.black)
                      ],
                      color: Colors.blue),
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 3.5,
                    right: MediaQuery.of(context).size.width / 3.5,
                  ),
                  child: Center(
                    child: Text(
                      setapptext(key: 'key_continue'),
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          setapptext(key: 'key_rework'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: ReworkTask().getReworkAssignments(),
        builder: (context, AsyncSnapshot<List<ReworkAssignment>> assignments) {
          if (assignments.connectionState == ConnectionState.done &&
              assignments.hasData) {
            List<ReworkAssignment> data = assignments.data;
            return Column(
              children: <Widget>[
                data.isEmpty ?? true
                    ? Expanded(
                        child: Center(
                          child: Text(setapptext(key: 'key_no_survey'),style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: data?.isEmpty ?? true ? 0 : data.length,
                          itemBuilder: (context, index) {
                            return listcard(
                                id: data[index] == null
                                    ? new ReworkAssignment()
                                    : data[index],
                                provinance:
                                    data[index].province?.isEmpty ?? true
                                        ? ""
                                        : data[index].province,
                                nahia: data[index].nahia?.isEmpty ?? true
                                    ? ""
                                    : data[index].nahia,
                                gozar: data[index].gozar?.isEmpty ?? true
                                    ? ""
                                    : data[index].gozar,
                                assigndate:
                                    data[index].createdate?.isEmpty ?? true
                                        ? ""
                                        : data[index].createdate,
                                status:
                                    workstatus(status: data[index].appstatus),
                                statuscolor: workstatuscolor(
                                    status: data[index].appstatus));
                          },
                        ),
                      )
              ],
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
