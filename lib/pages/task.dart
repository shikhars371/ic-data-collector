import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:connectivity/connectivity.dart';
import 'package:kapp/utils/db_helper.dart';

import '../localization/app_translations.dart';
import '../utils/appdrawer.dart';
import '../controllers/task.dart';
import '../utils/navigation_service.dart';
import '../utils/route_paths.dart' as routes;
import '../utils/locator.dart';
import '../models/surveyAssignment.dart';
import '../utils/showappdialog.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  void checkNotificationReport() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var result = await DBHelper().isSyncedTwoDatsBefore();
      if (result) {
        showDialogSingleButton(
            context: context,
            title: setapptext(key: 'key_warning'),
            buttonLabel: setapptext(key: 'key_ok'),
            message: setapptext(key: 'key_notify_no_sync'));
      }
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      checkNotificationReport();
    });
    super.initState();
  }

  String workstatus({int completestatus, int startedstatus, int syncstatus}) {
    String result = "";
    if (startedstatus != null && completestatus != null && syncstatus != null) {
      if (startedstatus == 0) {
        result = setapptext(key: 'key_not_started');
      } else if (startedstatus != 0 && completestatus == 0) {
        result = setapptext(key: 'key_in_progress');
      } else if (completestatus != 0) {
        result = setapptext(key: 'key_completed');
      } else if (syncstatus != 0) {
        result = setapptext(key: 'key_synced');
      }
    }
    return result;
  }

  Color workstatuscolor(
      {int completestatus, int startedstatus, int syncstatus}) {
    Color result = Colors.transparent;
    if (startedstatus != null && completestatus != null && syncstatus != null) {
      if (startedstatus == 0) {
        result = Color.fromRGBO(189, 148, 36, 1);
      } else if (startedstatus != 0 && completestatus == 0) {
        result = Colors.lightGreen;
      } else if (completestatus != 0) {
        result = Colors.green;
      } else if (syncstatus != 0) {
        result = Colors.lightBlue;
      }
    }
    return result;
  }

  Widget listcard(
      {SurveyAssignment id,
      String status,
      Color statuscolor,
      String assigndate,
      String totalTask,
      String completedTask}) {
    return Card(
      elevation: 3.0,
      child: Container(
        decoration: BoxDecoration(
            //color: Color.fromRGBO(242, 239, 230, 1),
            ),
        padding: EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                id.province + "-" + id.nahia + "-" + id.gozar + "-" + id.block,
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
                    Text(
                      "$completedTask/$totalTask",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                _navigationService.navigateTo(
                    routeName: routes.SurveyRoute, parms: id);
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

  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          setapptext(key: 'key_task'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: TaskModel().getAssignments(),
        builder: (context, AsyncSnapshot<List<SurveyAssignment>> assignments) {
          if (assignments.connectionState == ConnectionState.done &&
              assignments.hasData) {
            List<SurveyAssignment> data = assignments.data;
            return Column(
              children: <Widget>[
                data.isEmpty ?? true
                    ? Expanded(
                        child: Center(
                          child: Text(
                            setapptext(key: 'key_no_survey'),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: data?.isEmpty ?? true ? 0 : data.length,
                          itemBuilder: (context, index) {
                            return listcard(
                                id: data[index] == null
                                    ? new SurveyAssignment()
                                    : data[index],
                                assigndate:
                                    data[index].startDate?.isEmpty ?? true
                                        ? ""
                                        : data[index].startDate,
                                status: workstatus(
                                    completestatus: data[index].iscompleted,
                                    startedstatus: data[index].isstatrted,
                                    syncstatus: data[index].issynced),
                                statuscolor: workstatuscolor(
                                    completestatus: data[index].iscompleted,
                                    startedstatus: data[index].isstatrted,
                                    syncstatus: data[index].issynced),
                                totalTask:
                                    data[index].property_to_survey.toString(),
                                completedTask: data[index].noOfCompletedTask ==
                                        null
                                    ? 0
                                    : data[index].noOfCompletedTask.toString());
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
