import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import '../localization/app_translations.dart';

class Form1Page extends StatefulWidget {
  @override
  _Form1PageState createState() => _Form1PageState();
}

class _Form1PageState extends State<Form1Page> {
  var _formkey = GlobalKey<FormState>();

  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  Widget formtextfield(
      {String labletext,
      void Function(String) onsave,
      void Function(String) validator}) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: setapptext(key: labletext),
        ),
        textInputAction: TextInputAction.continueAction,
        onSaved: onsave,
        validator: validator,
      ),
    );
  }

  Widget customDropDown({String headerlable}) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            setapptext(key: headerlable),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: DropdownButtonFormField(
              items: <String>['1', '2', '3'].map((String value) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form1"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              //provider info
              ExpansionTile(
                title: Text(
                  setapptext(key: 'key_provider_details'),
                ),
                children: [
                  formtextfield(labletext: 'key_first_surveyor'),
                  formtextfield(labletext: 'key_second_surveyor'),
                  formtextfield(labletext: 'key_name_technical_support'),
                  RaisedButton(
                    onPressed: () {},
                    child: Text("Submit"),
                  )
                ],
              ),
              //general info 1
              ExpansionTile(
                title: Text(
                  setapptext(key: 'key_general_info1'),
                ),
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          setapptext(key: 'key_property_disputes'),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        RadioButtonGroup(
                          labels: [
                            setapptext(key: 'key_yes_sir'),
                            setapptext(key: 'key_no')
                          ],
                          onSelected: (String value) {
                            print(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          setapptext(key: 'key_real_person'),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        RadioButtonGroup(
                          labels: [
                            setapptext(key: 'key_present'),
                            setapptext(key: 'key_absence'),
                            setapptext(key: 'key_died'),
                          ],
                          onSelected: (String value) {
                            print(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          setapptext(key: 'key_is_citizenship'),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        RadioButtonGroup(
                          labels: [
                            setapptext(key: 'key_yes_sir'),
                            setapptext(key: 'key_no')
                          ],
                        )
                      ],
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text("Submit"),
                  )
                ],
              ),
              //general info 2
              ExpansionTile(
                title: Text(
                  setapptext(key: 'key_general_info_2'),
                ),
                children: [
                  formtextfield(labletext: 'key_property_issues'),
                  formtextfield(labletext: 'key_municipal_regulation'),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          setapptext(key: 'key_natural_factor'),
                        ),
                        RadioButtonGroup(
                          labels: [
                            setapptext(key: 'key_yes_sir'),
                            setapptext(key: 'key_no')
                          ],
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    onPressed: null,
                    child: Text("Submit"),
                  )
                ],
              ),
              //The physical state of the property area
              ExpansionTile(
                title: Text(
                  setapptext(key: 'key_physical_state'),
                ),
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          setapptext(key: 'key_specify_the'),
                        ),
                        RadioButtonGroup(
                          labels: [
                            setapptext(key: 'key_plan'),
                            setapptext(key: 'key_unplan')
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          setapptext(key: 'key_specify_the'),
                        ),
                        RadioButtonGroup(
                          labels: [
                            setapptext(key: 'key_official'),
                            setapptext(key: 'key_unofficial')
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          setapptext(key: 'key_specify_the'),
                        ),
                        RadioButtonGroup(
                          labels: [
                            setapptext(key: 'key_regular'),
                            setapptext(key: 'key_disorganized')
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          setapptext(key: 'key_specify_slope'),
                        ),
                        RadioButtonGroup(
                          labels: [
                            setapptext(key: 'key_Smooth'),
                            setapptext(key: 'key_slope_30'),
                            setapptext(key: 'key_slope_above_30'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    onPressed: null,
                    child: Text("Submit"),
                  )
                ],
              ),
              //property location
              ExpansionTile(
                title: Text(
                  setapptext(key: 'key_property_location'),
                ),
                children: [
                  customDropDown(headerlable: 'key_select_province'),
                  RaisedButton(
                    onPressed: () {},
                    child: Text("Submit"),
                  )
                ],
              ),
              // ExpansionTile(
              //   title: Text('Property Details'),
              //   children: [
              //     TextField(
              //       decoration: InputDecoration(hintText: 'input1'),
              //     ),
              //     TextField(
              //       decoration: InputDecoration(hintText: 'input2'),
              //     ),
              //     TextField(
              //       decoration: InputDecoration(hintText: 'input3'),
              //     ),
              //     RaisedButton(
              //       onPressed: null,
              //       child: Text("Submit"),
              //     )
              //   ],
              // ),
              // ExpansionTile(
              //   title: Text('Personal Fame / First Partner'),
              //   children: [
              //     TextField(
              //       decoration: InputDecoration(hintText: 'input1'),
              //     ),
              //     TextField(
              //       decoration: InputDecoration(hintText: 'input2'),
              //     ),
              //     TextField(
              //       decoration: InputDecoration(hintText: 'input3'),
              //     ),
              //     RaisedButton(
              //       onPressed: null,
              //       child: Text("Submit"),
              //     )
              //   ],
              // ),
              // ExpansionTile(
              //   title: Text('Information and photo hint'),
              //   children: [
              //     TextField(
              //       decoration: InputDecoration(hintText: 'input1'),
              //     ),
              //     TextField(
              //       decoration: InputDecoration(hintText: 'input2'),
              //     ),
              //     TextField(
              //       decoration: InputDecoration(hintText: 'input3'),
              //     ),
              //     RaisedButton(
              //       onPressed: null,
              //       child: Text("Submit"),
              //     )
              //   ],
              // ),
              // ExpansionTile(
              //   title: Text('Four limits'),
              //   children: [
              //     TextField(
              //       decoration: InputDecoration(hintText: 'input1'),
              //     ),
              //     TextField(
              //       decoration: InputDecoration(hintText: 'input2'),
              //     ),
              //     TextField(
              //       decoration: InputDecoration(hintText: 'input3'),
              //     ),
              //     RaisedButton(
              //       onPressed: null,
              //       child: Text("Submit"),
              //     )
              //   ],
              // ),
              // ExpansionTile(
              //   title: Text(
              //       'Details of the number and area of ​​units (if the current use is mixed-use and commercial, fill the following sections).'),
              //   children: [
              //     TextField(
              //       decoration: InputDecoration(hintText: 'input1'),
              //     ),
              //     TextField(
              //       decoration: InputDecoration(hintText: 'input2'),
              //     ),
              //     TextField(
              //       decoration: InputDecoration(hintText: 'input3'),
              //     ),
              //     RaisedButton(
              //       onPressed: null,
              //       child: Text("Submit"),
              //     )
              //   ],
              // ),
              // Container(
              //   child: Column(
              //     children: <Widget>[
              //       Align(
              //         alignment: Alignment.topLeft,
              //         child: Text("Home / sketch map"),
              //       ),
              //       RaisedButton(
              //         onPressed: () {},
              //         child: Text("Click here to upload file"),
              //       )
              //     ],
              //   ),
              // ),
              // Container(
              //   child: Column(
              //     children: <Widget>[
              //       Align(
              //         alignment: Alignment.topLeft,
              //         child: Text("Home photo"),
              //       ),
              //       RaisedButton(
              //         onPressed: () {},
              //         child: Text("Click here to upload file"),
              //       )
              //     ],
              //   ),
              // ),
              // Container(
              //   child: Column(
              //     children: <Widget>[
              //       Text(
              //           "Registered Property Fertilizer: (Unit-Block-Gateway-District-City-Province)"),
              //       Radio(
              //         groupValue: '',
              //         onChanged: null,
              //         value: '',
              //       )
              //     ],
              //   ),
              // ),
              // Container(
              //   child: RaisedButton(
              //     onPressed: () {},
              //     child: Text("submit"),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
