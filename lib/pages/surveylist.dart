import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localization/app_translations.dart';
import './propertyregistation.dart';

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
      {String id,
      String status,
      Color statuscolor,
      String provinance,
      String nahia,
      String gozar,
      String area}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
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
                    Text("Unit No.-",style: TextStyle(fontSize: 16),),
                    Text("Part No.-",style: TextStyle(fontSize: 16)),
                    Text("  Block No.-",style: TextStyle(fontSize: 16)),
                    //Text("data"),
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
                      onPressed: () {},
                    ),
                    IconButton(
                      iconSize: 16,
                      icon: Icon(Icons.delete),
                      onPressed: () {},
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
      ),
    );
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return listcard();
                },
              ),
            )
          ],
        ),
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
