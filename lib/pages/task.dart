import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localization/app_translations.dart';
import '../utils/buttomnavbar.dart';
import '../utils/appdrawer.dart';
import '../controllers/task.dart';
import './surveylist.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<TaskModel>(context).getAssignments();
    });
    super.initState();
  }

  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  @override
  Widget build(BuildContext context) {
    Widget customDropDown({String headerlable, List<String> items}) {
      return Container(
        child: Column(
          children: <Widget>[
            Text(
              setapptext(key: headerlable),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: DropdownButtonFormField(
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String value) {
                  value = value;
                },
                //onSaved: ,
              ),
            )
          ],
        ),
      );
    }

    Widget listcard(
        {String status,
        Color statuscolor,
        String provinance,
        String nahia,
        String gozar,
        String area}) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => SurveyPage(),
            ),
          );
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
      drawer: AppDrawer(),
      body: Consumer<TaskModel>(
        builder: (context, data, child) {
          return data.state == AppState.Busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: <Widget>[
                    Container(
                      child: customDropDown(
                          headerlable: 'Task Filter',
                          items: ['Assigned', 'Processing', 'Completed']),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return listcard(
                              status: 'Processing',
                              statuscolor: Colors.lightGreen,
                              provinance: 'test',
                              nahia: 'test',
                              gozar: 'test',
                              area: '12');
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
