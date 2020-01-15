import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localization/app_translations.dart';
import '../utils/buttomnavbar.dart';
import '../utils/appdrawer.dart';
import '../controllers/task.dart';
import './surveylist.dart';
import '../utils/navigation_service.dart';
import '../utils/route_paths.dart' as routes;
import '../utils/locator.dart';
import '../utils/db_helper.dart';

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

  Widget listcard(
      {String id,
      String status,
      Color statuscolor,
      String provinance,
      String nahia,
      String gozar,
      String area}) {
    return GestureDetector(
      onTap: () {
        _navigationService.navigateTo(routeName: routes.SurveyRoute);
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
                alignment: Alignment.topRight,
                child: Text(
                  status,
                  style: TextStyle(
                      color: statuscolor, fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Provinance :$provinance"),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Nahia :$nahia"),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Gozar :$gozar"),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text("No od Area :$area"),
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
        title: Text(
          setapptext(key: 'key_task'),
          style: TextStyle(
              //color: Color.fromRGBO(192, 65, 25, 1),
              fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).secondaryHeaderColor
                ]),
          ),
        ),
      ),
      bottomNavigationBar: appbuttomnavbar(context),
      //drawer: AppDrawer(),
      body: Consumer<TaskModel>(
        builder: (context, data, child) {
          return data.state == AppState.Busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: <Widget>[
                    // Container(
                    //   child: customDropDown(
                    //       headerlable: 'Task Filter',
                    //       items: ['Assigned', 'Processing', 'Completed']),
                    // ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.surveyAssignments?.isEmpty ?? true
                            ? 0
                            : data.surveyAssignments.length,
                        itemBuilder: (context, index) {
                          return listcard(
                              id: data.surveyAssignments[index].id?.isEmpty ??
                                      true
                                  ? ""
                                  : data.surveyAssignments[index].id,
                              status: 'Processing',
                              statuscolor: Colors.lightGreen,
                              provinance: data.surveyAssignments[index]
                                          .provinceId?.isEmpty ??
                                      true
                                  ? ""
                                  : data.surveyAssignments[index].provinceId,
                              nahia: data.surveyAssignments[index].nahiaId
                                          ?.isEmpty ??
                                      true
                                  ? ""
                                  : data.surveyAssignments[index].nahiaId,
                              gozar: data.surveyAssignments[index].gozarId
                                          ?.isEmpty ??
                                      true
                                  ? ""
                                  : data.surveyAssignments[index].gozarId,
                              area: data.surveyAssignments[index]
                                          .propertyToSurvey ==
                                      0
                                  ? ""
                                  : data
                                      .surveyAssignments[index].propertyToSurvey
                                      .toString());
                        },
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
