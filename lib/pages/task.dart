import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../localization/app_translations.dart';
import '../utils/appdrawer.dart';
import '../controllers/task.dart';
import './surveylist.dart';
import '../utils/navigation_service.dart';
import '../utils/route_paths.dart' as routes;
import '../utils/locator.dart';
import '../utils/db_helper.dart';
import '../models/surveyAssignment.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<TaskModel>(context).getAssignments();
    });
    super.initState();
  }

  String workstatus({int completestatus, int startedstatus, int syncstatus}) {
    String result = "";
    if (startedstatus != null && completestatus != null && syncstatus != null) {
      if (startedstatus == 0) {
        result = "Not Started";
      } else if (startedstatus != 0 && completestatus == 0) {
        result = "In Progress";
      } else if (completestatus != 0) {
        result = "Completed";
      } else if (syncstatus != 0) {
        result = "Synced";
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
      {String id,
      String status,
      Color statuscolor,
      String provinance,
      String nahia,
      String gozar,
      String area,
      String assigndate}) {
    return GestureDetector(
      onTap: () {
        _navigationService.navigateTo(routeName: routes.SurveyRoute, parms: id);
      },
      child: Card(
        elevation: 3.0,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(242, 239, 230, 1),
          ),
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  provinance + "-" + nahia + "-" + gozar + "-" + area,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Assigned Date -" +
                      DateFormat.yMd().format(
                        DateTime.parse(assigndate),
                      ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  status,
                  style: TextStyle(
                      color: statuscolor, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
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
                Expanded(
                  child: ListView.builder(
                    itemCount: data?.isEmpty ?? true ? 0 : data.length,
                    itemBuilder: (context, index) {
                      return listcard(
                        id: data[index].id?.isEmpty ?? true
                            ? ""
                            : data[index].id,
                        provinance: data[index].province?.isEmpty ?? true
                            ? ""
                            : data[index].province,
                        nahia: data[index].nahia?.isEmpty ?? true
                            ? ""
                            : data[index].nahia,
                        gozar: data[index].gozar?.isEmpty ?? true
                            ? ""
                            : data[index].gozar,
                        area: data[index].property_to_survey == null
                            ? 0
                            : data[index].property_to_survey.toString(),
                        assigndate: data[index].startDate?.isEmpty ?? true
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
                      );
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
      //  Consumer<TaskModel>(
      //   builder: (context, data, child) {
      //     return data.state == AppState.Busy
      //         ? Center(
      //             child: CircularProgressIndicator(),
      //           )
      //         : Column(
      //             children: <Widget>[
      //               Expanded(
      //                 child: ListView.builder(
      //                   itemCount: data.surveyAssignments?.isEmpty ?? true
      //                       ? 0
      //                       : data.surveyAssignments.length,
      //                   itemBuilder: (context, index) {
      //                     return listcard(
      //                       id: data.surveyAssignments[index].id?.isEmpty ??
      //                               true
      //                           ? ""
      //                           : data.surveyAssignments[index].id,
      //                       provinance: data.surveyAssignments[index].province
      //                                   ?.isEmpty ??
      //                               true
      //                           ? ""
      //                           : data.surveyAssignments[index].province,
      //                       nahia:
      //                           data.surveyAssignments[index].nahia?.isEmpty ??
      //                                   true
      //                               ? ""
      //                               : data.surveyAssignments[index].nahia,
      //                       gozar:
      //                           data.surveyAssignments[index].gozar?.isEmpty ??
      //                                   true
      //                               ? ""
      //                               : data.surveyAssignments[index].gozar,
      //                       area: data.surveyAssignments[index]
      //                                   .property_to_survey ==
      //                               null
      //                           ? 0
      //                           : data
      //                               .surveyAssignments[index].property_to_survey
      //                               .toString(),
      //                       assigndate: data.surveyAssignments[index].startDate
      //                                   ?.isEmpty ??
      //                               true
      //                           ? ""
      //                           : data.surveyAssignments[index].startDate,
      //                       status: workstatus(
      //                           completestatus:
      //                               data.surveyAssignments[index].iscompleted,
      //                           startedstatus:
      //                               data.surveyAssignments[index].isstatrted,
      //                           syncstatus:
      //                               data.surveyAssignments[index].issynced),
      //                       statuscolor: workstatuscolor(
      //                           completestatus:
      //                               data.surveyAssignments[index].iscompleted,
      //                           startedstatus:
      //                               data.surveyAssignments[index].isstatrted,
      //                           syncstatus:
      //                               data.surveyAssignments[index].issynced),
      //                     );
      //                   },
      //                 ),
      //               )
      //             ],
      //           );
      //   },
      // ),
    );
  }
}
