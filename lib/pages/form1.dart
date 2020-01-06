import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import '../localization/app_translations.dart';
import '../utils/buttomnavbar.dart';
import '../utils/appdrawer.dart';

class Form1Page extends StatefulWidget {
  @override
  _Form1PageState createState() => _Form1PageState();
}

class _Form1PageState extends State<Form1Page> {
  var _formkey = GlobalKey<FormState>();
  bool chkval = false;

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

  Widget fileuploader({String lable}) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: <Widget>[
          Text(
            setapptext(key: lable),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("Click here to upload file (<10 MB)"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Property Registation",
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
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //header
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(177, 201, 224, 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "General Info (PART I)",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //form container
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(176, 174, 171, 1),
                                width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: true,
                                    groupValue: true,
                                    onChanged: (bool) {},
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Lable",
                                      style: TextStyle(),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 10),
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'Hint Text'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //buttom menu container
              Container(
                height: 25,
                color: Theme.of(context).secondaryHeaderColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        print("back");
                      },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.arrow_back_ios),
                            Text(
                              "Back",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("menu");
                      },
                      child: Container(
                        child: IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("next");
                      },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Next",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Column(
//             children: <Widget>[
//               //provider info
//               ExpansionTile(
//                 title: Text(
//                   setapptext(key: 'key_provider_details'),
//                 ),
//                 children: [
//                   formtextfield(labletext: 'key_first_surveyor'),
//                   formtextfield(labletext: 'key_second_surveyor'),
//                   formtextfield(labletext: 'key_name_technical_support'),
//                   RaisedButton(
//                     onPressed: () {},
//                     child: Text("Submit"),
//                   )
//                 ],
//               ),
//               //general info 1
//               ExpansionTile(
//                 title: Text(
//                   setapptext(key: 'key_general_info1'),
//                 ),
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(left: 10, right: 10),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           setapptext(key: 'key_property_disputes'),
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         RadioButtonGroup(
//                           labels: [
//                             setapptext(key: 'key_yes_sir'),
//                             setapptext(key: 'key_no')
//                           ],
//                           onSelected: (String value) {
//                             print(value);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 10, right: 10),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           setapptext(key: 'key_real_person'),
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         RadioButtonGroup(
//                           labels: [
//                             setapptext(key: 'key_present'),
//                             setapptext(key: 'key_absence'),
//                             setapptext(key: 'key_died'),
//                           ],
//                           onSelected: (String value) {
//                             print(value);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 10, right: 10),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           setapptext(key: 'key_is_citizenship'),
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         RadioButtonGroup(
//                           labels: [
//                             setapptext(key: 'key_yes_sir'),
//                             setapptext(key: 'key_no')
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   RaisedButton(
//                     onPressed: () {},
//                     child: Text("Submit"),
//                   )
//                 ],
//               ),
//               //general info 2
//               ExpansionTile(
//                 title: Text(
//                   setapptext(key: 'key_general_info_2'),
//                 ),
//                 children: [
//                   formtextfield(labletext: 'key_property_issues'),
//                   formtextfield(labletext: 'key_municipal_regulation'),
//                   Container(
//                     padding: EdgeInsets.only(left: 10, right: 10, top: 10),
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                           setapptext(key: 'key_natural_factor'),
//                         ),
//                         RadioButtonGroup(
//                           labels: [
//                             setapptext(key: 'key_yes_sir'),
//                             setapptext(key: 'key_no')
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   RaisedButton(
//                     onPressed: null,
//                     child: Text("Submit"),
//                   )
//                 ],
//               ),
//               //The physical state of the property area
//               ExpansionTile(
//                 title: Text(
//                   setapptext(key: 'key_physical_state'),
//                 ),
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(left: 10, right: 10, top: 10),
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                           setapptext(key: 'key_specify_the'),
//                         ),
//                         RadioButtonGroup(
//                           labels: [
//                             setapptext(key: 'key_plan'),
//                             setapptext(key: 'key_unplan')
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 10, right: 10, top: 10),
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                           setapptext(key: 'key_specify_the'),
//                         ),
//                         RadioButtonGroup(
//                           labels: [
//                             setapptext(key: 'key_official'),
//                             setapptext(key: 'key_unofficial')
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 10, right: 10, top: 10),
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                           setapptext(key: 'key_specify_the'),
//                         ),
//                         RadioButtonGroup(
//                           labels: [
//                             setapptext(key: 'key_regular'),
//                             setapptext(key: 'key_disorganized')
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 10, right: 10, top: 10),
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                           setapptext(key: 'key_specify_slope'),
//                         ),
//                         RadioButtonGroup(
//                           labels: [
//                             setapptext(key: 'key_Smooth'),
//                             setapptext(key: 'key_slope_30'),
//                             setapptext(key: 'key_slope_above_30'),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   RaisedButton(
//                     onPressed: null,
//                     child: Text("Submit"),
//                   )
//                 ],
//               ),
//               //property location
//               ExpansionTile(
//                 title: Text(
//                   setapptext(key: 'key_property_location'),
//                 ),
//                 children: [
//                   customDropDown(
//                       headerlable: 'key_select_province',
//                       items: ['1', '2', '3']),
//                   customDropDown(
//                       headerlable: 'key_select_city', items: ['1', '2', '3']),
//                   formtextfield(labletext: 'key_area'),
//                   formtextfield(labletext: 'key_pass'),
//                   formtextfield(labletext: 'key_block'),
//                   formtextfield(labletext: 'key_part_number'),
//                   formtextfield(labletext: 'key_unit_number'),
//                   formtextfield(labletext: 'key_number_of_unit'),
//                   formtextfield(labletext: 'key_state_name'),
//                   formtextfield(labletext: 'key_historycal_site'),
//                   formtextfield(labletext: 'key_land_area'),
//                   Container(
//                     padding: EdgeInsets.only(left: 10, right: 10, top: 10),
//                     child: Column(
//                       children: <Widget>[
//                         Text(setapptext(key: 'key_type_ownership')),
//                         RadioButtonGroup(
//                           labels: [
//                             setapptext(key: 'key_solo'),
//                             setapptext(key: 'key_collective')
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   RaisedButton(
//                     onPressed: () {},
//                     child: Text("Submit"),
//                   )
//                 ],
//               ),
//               //Property Details
//               ExpansionTile(
//                 title: Text(setapptext(key: 'key_property_details')),
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(top: 10, left: 10, right: 10),
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                           setapptext(key: 'key_location_land'),
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         RadioButtonGroup(
//                           labels: [
//                             setapptext(key: 'key_zone_1'),
//                             setapptext(key: 'key_zone_2'),
//                             setapptext(key: 'key_zone_3'),
//                             setapptext(key: 'key_zone_4'),
//                             setapptext(key: 'key_zone_5'),
//                             setapptext(key: 'key_zone_6'),
//                             setapptext(key: 'key_zone_7')
//                           ],
//                           onSelected: (String value) {
//                             print(value);
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(top: 10, left: 10, right: 10),
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                           setapptext(key: 'key_does_properties_document'),
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         RadioButtonGroup(
//                           labels: [
//                             setapptext(key: 'key_yes_sir'),
//                             setapptext(key: 'key_no'),
//                           ],
//                           onSelected: (String value) {
//                             print(value);
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(top: 10, left: 10, right: 10),
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                           setapptext(key: 'key_current_use_property_type'),
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         RadioButtonGroup(
//                           labels: [
//                             setapptext(key: 'key_release'),
//                             setapptext(key: 'key_commercial'),
//                             setapptext(key: 'key_complex'),
//                             setapptext(key: 'key_productive'),
//                             setapptext(key: 'key_govt'),
//                             setapptext(key: 'key_agriculture'),
//                             setapptext(key: 'key_block_score'),
//                             setapptext(key: 'key_demaged'),
//                             setapptext(key: 'key_property_type_specified'),
//                             setapptext(key: 'key_property_type_unspecified'),
//                           ],
//                           onSelected: (String value) {
//                             print(value);
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                   RaisedButton(
//                     onPressed: null,
//                     child: Text("Submit"),
//                   )
//                 ],
//               ),
//               //True personal / judgmental
//               ExpansionTile(
//                 title: Text(
//                   setapptext(key: 'key_true_personal'),
//                 ),
//                 children: [
//                   formtextfield(labletext: 'key_asthma'),
//                   formtextfield(labletext: 'key_surname'),
//                   formtextfield(labletext: 'key_wold'),
//                   formtextfield(labletext: 'key_birth'),
//                   Container(
//                     padding: EdgeInsets.only(top: 10, left: 10, right: 10),
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                           setapptext(key: 'key_gender'),
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         RadioButtonGroup(
//                           labels: [
//                             setapptext(key: 'key_male'),
//                             setapptext(key: 'key_female')
//                           ],
//                           onSelected: (String value) {
//                             print(value);
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                   formtextfield(labletext: 'key_phone'),
//                   formtextfield(labletext: 'key_email'),
//                   fileuploader(lable: 'key_photo_owner'),
//                   formtextfield(labletext: 'key_enter_any_mere'),
//                   RaisedButton(
//                     onPressed: null,
//                     child: Text("Submit"),
//                   )
//                 ],
//               ),
//               //info & photo
//               ExpansionTile(
//                 title: Text(setapptext(key: 'key_information_and_photo')),
//                 children: [
//                   formtextfield(labletext: 'key_machine_gun'),
//                   formtextfield(labletext: 'key_cover_letter'),
//                   formtextfield(labletext: 'Notification page'),
//                   formtextfield(labletext: 'key_reg_no'),
//                   fileuploader(lable: 'key_photo_note1'),
//                   fileuploader(lable: 'key_photo_tips1'),
//                   fileuploader(lable: 'key_photo_tips2'),
//                   RaisedButton(
//                     onPressed: null,
//                     child: Text("Submit"),
//                   )
//                 ],
//               ),
//               //Four limits
//               ExpansionTile(
//                 title: Text(setapptext(key: 'key_four_limits')),
//                 children: [
//                   formtextfield(labletext: 'key_east'),
//                   formtextfield(labletext: 'key_west'),
//                   formtextfield(labletext: 'key_south'),
//                   formtextfield(labletext: 'key_north'),
//                   RaisedButton(
//                     onPressed: null,
//                     child: Text("Submit"),
//                   )
//                 ],
//               ),
//               //details number area
//               ExpansionTile(
//                 title: Text(
//                   setapptext(key: 'key_details_number'),
//                 ),
//                 children: [
//                   formtextfield(labletext: 'key_release_area'),
//                   formtextfield(labletext: 'key_business_area'),
//                   formtextfield(labletext: 'key_total_release_units'),
//                   formtextfield(labletext: 'key_total_business_unit'),
//                   RaisedButton(
//                     onPressed: null,
//                     child: Text("Submit"),
//                   )
//                 ],
//               ),
//               fileuploader(lable: 'key_home_map'),
//               fileuploader(lable: 'key_home_photo'),
//               Container(
//                 padding: EdgeInsets.only(left: 10, right: 10),
//                 child: Column(
//                   children: <Widget>[
//                     Text(
//                       setapptext(key: 'key_registered_property'),
//                     ),
//                     Checkbox(
//                       value: chkval,
//                       onChanged: (bool value) {
//                         setState(() {
//                           chkval = !chkval;
//                         });
//                       },
//                     )
//                   ],
//                 ),
//               ),
//               RaisedButton(
//                 onPressed: () {},
//                 child: Text("Submit"),
//               ),
//               Container(
//                 height: 50,
//               )
//             ],
//           )
