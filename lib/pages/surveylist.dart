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
              Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                    ],
                  ),
                ),
              )
            ],
          ),
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
            icon: Icon(Icons.add),
            tooltip: "add new property",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => PropertyRegistationPage(),
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 0,
              itemBuilder: (context, index) {
                return listcard();
              },
            ),
          )
        ],
      ),
    );
  }
}
