import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import '../localization/app_translations.dart';
import '../utils/buttomnavbar.dart';
import '../utils/appdrawer.dart';
import '../models/localpropertydata.dart';

class PropertyRegistationPage extends StatefulWidget {
  PropertyRegistationPage({this.taskid});
  final String taskid;
  @override
  _PropertyRegistationPage createState() => _PropertyRegistationPage();
}

class _PropertyRegistationPage extends State<PropertyRegistationPage> {
  var _formkey = GlobalKey<FormState>();
  String ddprovinceval = "None selected";
  String ddcity = "None selected";
  bool chkval = false;
  int formval = 0;
  LocalPropertySurvey localdata;
  void datasaver() {
    if (formval == 0) {
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();
        setState(() {
          formval += 1;
        });
      }
    } else if (formval == 1) {
      if ((localdata.property_dispte_subject_to?.isEmpty ?? true) ||
          (localdata.real_person_status?.isEmpty ?? true) ||
          (localdata.cityzenship_notice?.isEmpty ?? true)) {
        return;
      } else {
        setState(() {
          formval += 1;
        });
      }
    } else if (formval == 2) {
      _formkey.currentState.save();
      setState(() {
        formval += 1;
      });
    } else if (formval == 3) {
      if ((localdata.status_of_area_plan?.isEmpty ?? true) ||
          (localdata.status_of_area_official?.isEmpty ?? true) ||
          (localdata.status_of_area_regular?.isEmpty ?? true) ||
          (localdata.slope_of_area?.isEmpty ?? true)) {
        return;
      } else {
        setState(() {
          formval += 1;
        });
      }
    } else if (formval == 4) {}
  }

  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  Widget completedcheckbox({bool isCompleted}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          //color: Colors.white,
          shape: BoxShape.rectangle,
          border: Border.all(
              color: isCompleted ? Colors.lightGreen : Colors.black, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: BoxDecoration(
              color: isCompleted ? Colors.lightGreen : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget formcardtextfield(
      {TextInputType keyboardtype,
      String initvalue,
      String headerlablekey,
      bool radiovalue,
      String hinttextkey,
      Function(String) onSaved,
      Function(String) validator,
      Function(String) onChanged}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromRGBO(176, 174, 171, 1), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  completedcheckbox(isCompleted: radiovalue),
                  Flexible(
                    child: Text(
                      setapptext(key: headerlablekey),
                      style: TextStyle(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                child: TextFormField(
                  keyboardType: keyboardtype,
                  initialValue: initvalue?.isEmpty ?? true ? "" : initvalue,
                  decoration: InputDecoration(
                    hintText: hinttextkey?.isEmpty ?? true
                        ? ""
                        : setapptext(key: hinttextkey),
                  ),
                  onSaved: onSaved,
                  validator: validator,
                  onChanged: onChanged,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget formCardRadioButtons(
      {String initvalue,
      bool iscompleted,
      String headerlablekey,
      List<String> radiobtnlables,
      Function(String) radiobtnSelected,
      bool validate = false,
      Function(String, int) onchanged}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromRGBO(176, 174, 171, 1), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  completedcheckbox(isCompleted: iscompleted),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        setapptext(key: headerlablekey),
                        style: TextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                child: RadioButtonGroup(
                  labels: radiobtnlables,
                  onSelected: radiobtnSelected,
                  picked: initvalue?.isEmpty ?? true ? "" : initvalue,
                  onChange: onchanged,
                ),
              ),
              validate
                  ? Center(
                      child: Text(
                        "Required",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget formCardDropdown(
      {bool iscompleted,
      String headerlablekey,
      List<String> dropdownitems,
      Function(String) onSaved,
      String value,
      bool validate = false,
      Function(String) onChanged}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromRGBO(176, 174, 171, 1), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  completedcheckbox(isCompleted: iscompleted),
                  Flexible(
                    child: Text(
                      setapptext(key: headerlablekey),
                      style: TextStyle(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: DropdownButtonFormField<String>(
                    items: dropdownitems.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: onChanged,
                    onSaved: onSaved,
                    value: value,
                  ),
                ),
              ),
              validate
                  ? Center(
                      child: Text(
                        "Required",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget formCardFileuploader({bool isCompleted, String headerlablekey}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromRGBO(176, 174, 171, 1), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  completedcheckbox(isCompleted: isCompleted),
                  Flexible(
                    child: Text(
                      setapptext(key: headerlablekey),
                      style: TextStyle(),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {},
                          child: Text("Click here to upload file (<10 MB)"),
                        )
                      ],
                    ),
                  )

                  //     IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.file_upload),
                  //   iconSize: 30,
                  //   alignment: Alignment.center,
                  // ),
                  )
            ],
          ),
        ),
      ),
    );
  }

  Widget draftbutton({Function onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(blurRadius: 5.0, color: Colors.black)],
            color: Colors.blue),
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 3.5,
          right: MediaQuery.of(context).size.width / 3.5,
        ),
        child: Center(
          child: Text(
            'Save as Draft',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget formheader({String headerlablekey}) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(177, 201, 224, 1),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            setapptext(key: headerlablekey),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  //please enter the names of the providers
  Widget form1() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              headerlablekey: 'key_first_surveyor',
              radiovalue:
                  localdata.first_surveyor_name?.isEmpty ?? true ? false : true,
              hinttextkey: 'key_enter_1st_surveyor',
              initvalue: localdata.first_surveyor_name,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {
                localdata.first_surveyor_name = value.trim();
              },
              onChanged: (value) {
                localdata.first_surveyor_name = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              headerlablekey: 'key_second_surveyor',
              radiovalue: localdata.senond_surveyor_name?.isEmpty ?? true
                  ? false
                  : true,
              hinttextkey: 'key_enter_1st_surveyor',
              initvalue: localdata.senond_surveyor_name,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {
                localdata.senond_surveyor_name = value.trim();
              },
              onChanged: (value) {
                localdata.senond_surveyor_name = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              headerlablekey: 'key_name_technical_support',
              radiovalue: localdata.technical_support_name?.isEmpty ?? true
                  ? false
                  : true,
              hinttextkey: 'key_enter_1st_surveyor',
              initvalue: localdata.technical_support_name,
              onSaved: (value) {
                localdata.technical_support_name = value.trim();
              },
              onChanged: (value) {
                localdata.technical_support_name = value.trim();
                setState(() {});
              }),
        ],
      ),
    );
  }

  //general info 1
  Widget form2() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardRadioButtons(
              iscompleted: localdata.property_dispte_subject_to?.isEmpty ?? true
                  ? false
                  : true,
              headerlablekey: 'key_property_disputes',
              initvalue: localdata.property_dispte_subject_to?.isEmpty ?? true
                  ? ""
                  : localdata.property_dispte_subject_to,
              radiobtnlables: [
                setapptext(key: 'key_yes_sir'),
                setapptext(key: 'key_no')
              ],
              radiobtnSelected: (String value) {
                localdata.property_dispte_subject_to = value;
              },
              onchanged: (value, index) {
                localdata.property_dispte_subject_to = value;
                setState(() {});
              },
              validate: localdata.property_dispte_subject_to?.isEmpty ?? true
                  ? true
                  : false),
          formCardRadioButtons(
              iscompleted:
                  localdata.real_person_status?.isEmpty ?? true ? false : true,
              headerlablekey: 'key_real_person',
              radiobtnlables: [
                setapptext(key: 'key_present'),
                setapptext(key: 'key_absence'),
                setapptext(key: 'key_died')
              ],
              radiobtnSelected: (String value) {
                localdata.real_person_status = value;
              },
              initvalue: localdata.real_person_status?.isEmpty ?? true
                  ? ""
                  : localdata.real_person_status,
              onchanged: (value, index) {
                localdata.real_person_status = value;
                setState(() {});
              },
              validate:
                  localdata.real_person_status?.isEmpty ?? true ? true : false),
          formCardRadioButtons(
              iscompleted:
                  localdata.cityzenship_notice?.isEmpty ?? true ? false : true,
              headerlablekey: 'key_is_citizenship',
              radiobtnlables: [
                setapptext(key: 'key_yes_sir'),
                setapptext(key: 'key_no')
              ],
              radiobtnSelected: (String value) {
                localdata.cityzenship_notice = value;
              },
              initvalue: localdata.cityzenship_notice?.isEmpty ?? true
                  ? ""
                  : localdata.cityzenship_notice,
              onchanged: (value, index) {
                localdata.cityzenship_notice = value;
                setState(() {});
              },
              validate:
                  localdata.cityzenship_notice?.isEmpty ?? true ? true : false),
        ],
      ),
    );
  }

  //general info 2
  Widget form3() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              initvalue: localdata.issue_regarding_property?.isEmpty ?? true
                  ? ""
                  : localdata.issue_regarding_property,
              headerlablekey: 'key_property_issues',
              radiovalue: localdata.issue_regarding_property?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.issue_regarding_property = value.trim();
              }),
          formcardtextfield(
              initvalue: localdata.municipality_ref_number?.isEmpty ?? true
                  ? ""
                  : localdata.municipality_ref_number,
              headerlablekey: 'key_municipal_regulation',
              radiovalue: localdata.municipality_ref_number?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.municipality_ref_number = value.trim();
              }),
          formCardRadioButtons(
              iscompleted:
                  localdata.natural_threaten?.isEmpty ?? true ? false : true,
              initvalue: localdata.natural_threaten?.isEmpty ?? true
                  ? ""
                  : localdata.natural_threaten,
              headerlablekey: 'key_natural_factor',
              radiobtnlables: [
                setapptext(key: 'key_yes_sir'),
                setapptext(key: 'key_no')
              ],
              radiobtnSelected: (String value) {
                localdata.natural_threaten = value.trim();
              },
              onchanged: (value, index) {
                localdata.natural_threaten = value.trim();
                setState(() {});
              }),
        ],
      ),
    );
  }

  //the physical state of the property area
  Widget form4() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardRadioButtons(
              initvalue: localdata.status_of_area_plan?.isEmpty ?? true
                  ? ""
                  : localdata.status_of_area_plan,
              iscompleted:
                  localdata.status_of_area_plan?.isEmpty ?? true ? false : true,
              headerlablekey: 'key_specify_the',
              radiobtnlables: [
                setapptext(key: 'key_plan'),
                setapptext(key: 'key_unplan')
              ],
              radiobtnSelected: (String value) {
                localdata.status_of_area_plan = value;
              },
              onchanged: (value, index) {
                localdata.status_of_area_plan = value;
                setState(() {});
              },
              validate: localdata.status_of_area_plan?.isEmpty ?? true
                  ? true
                  : false),
          formCardRadioButtons(
              initvalue: localdata.status_of_area_official?.isEmpty ?? true
                  ? ""
                  : localdata.status_of_area_official,
              iscompleted: localdata.status_of_area_official?.isEmpty ?? true
                  ? false
                  : true,
              headerlablekey: 'key_specify_the',
              radiobtnlables: [
                setapptext(key: 'key_official'),
                setapptext(key: 'key_unofficial')
              ],
              radiobtnSelected: (String value) {
                localdata.status_of_area_official = value;
              },
              onchanged: (value, index) {
                localdata.status_of_area_official = value;
                setState(() {});
              },
              validate: localdata.status_of_area_official?.isEmpty ?? true
                  ? true
                  : false),
          formCardRadioButtons(
              initvalue: localdata.status_of_area_regular?.isEmpty ?? true
                  ? ""
                  : localdata.status_of_area_regular,
              iscompleted: localdata.status_of_area_regular?.isEmpty ?? true
                  ? false
                  : true,
              headerlablekey: 'key_specify_the',
              radiobtnlables: [
                setapptext(key: 'key_regular'),
                setapptext(key: 'key_disorganized')
              ],
              radiobtnSelected: (String value) {
                localdata.status_of_area_regular = value;
              },
              onchanged: (value, index) {
                localdata.status_of_area_regular = value;
                setState(() {});
              },
              validate: localdata.status_of_area_regular?.isEmpty ?? true
                  ? true
                  : false),
          formCardRadioButtons(
              initvalue: localdata.slope_of_area?.isEmpty ?? true
                  ? ""
                  : localdata.slope_of_area,
              iscompleted:
                  localdata.slope_of_area?.isEmpty ?? true ? false : true,
              headerlablekey: 'key_specify_slope',
              radiobtnlables: [
                setapptext(key: 'key_Smooth'),
                setapptext(key: 'key_slope_30'),
                setapptext(key: 'key_slope_above_30')
              ],
              radiobtnSelected: (String value) {
                localdata.slope_of_area = value;
              },
              onchanged: (value, index) {
                localdata.slope_of_area = value;
                setState(() {});
              },
              validate:
                  localdata.slope_of_area?.isEmpty ?? true ? true : false),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget form5() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardDropdown(
              iscompleted: localdata.province?.isEmpty ?? true ? false : true,
              headerlablekey: 'key_select_province',
              dropdownitems: [
                'None selected',
                'Cable',
                'Nangarhar',
                'Kandahar',
                'Bamyan',
                'daikundi',
                'Kunduz',
                'Balkh',
                'Herat',
                'Parwan',
                'Farah'
              ],
              onChanged: (value) {
                localdata.province = value;

                setState(() {
                  ddprovinceval = value;
                });
              },
              onSaved: (value) {
                localdata.province = value;
              },
              value: localdata.province?.isEmpty ?? true
                  ? ddprovinceval
                  : localdata.province,
              validate: (localdata.province?.isEmpty ?? true) ||
                      (localdata.province == "None selected")
                  ? true
                  : false),
          formCardDropdown(
              iscompleted: localdata.city?.isEmpty ?? true ? false : true,
              headerlablekey: 'key_select_city',
              dropdownitems: [
                'None selected',
                'cable',
                'jalal Abad',
                'kandahar',
                'Bamyan',
                'Indigo',
                'kunduz',
                'Mazar Sharif',
                'Herat',
                'Charger',
                'Farah'
              ],
              onChanged: (value) {
                localdata.city = value;
                setState(() {
                  ddcity = value;
                });
              },
              onSaved: (value) {
                localdata.city = value;
              },
              value: localdata.city?.isEmpty ?? true ? ddcity : localdata.city,
              validate: (localdata.city?.isEmpty ?? true) ||
                      (localdata.city == "None selected")
                  ? true
                  : false),
          formcardtextfield(
              keyboardtype: TextInputType.number,
              initvalue: localdata.area?.isEmpty ?? true ? "" : localdata.area,
              headerlablekey: 'key_area',
              radiovalue: localdata.area?.isEmpty ?? true ? false : true,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                } else if (value.length > 2) {
                  return "Two digit allowed";
                }
              },
              onSaved: (value) {
                localdata.area = value.trim();
              },
              onChanged: (value) {
                localdata.area = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              keyboardtype: TextInputType.number,
              initvalue: localdata.pass?.isEmpty ?? true ? "" : localdata.pass,
              headerlablekey: 'key_pass',
              radiovalue: localdata.pass?.isEmpty ?? true ? false : true,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                } else if (value.length > 2) {
                  return "two digits allowed";
                }
              },
              onSaved: (value) {
                localdata.pass = value.trim();
              },
              onChanged: (value) {
                localdata.pass = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              keyboardtype: TextInputType.number,
              initvalue:
                  localdata.block?.isEmpty ?? true ? "" : localdata.block,
              headerlablekey: 'key_block',
              radiovalue: localdata.block?.isEmpty ?? true ? false : true,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                } else if (value.length > 3) {
                  return "three digits allowed";
                }
              },
              onSaved: (value) {
                localdata.block = value.trim();
              },
              onChanged: (value) {
                localdata.block = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              keyboardtype: TextInputType.number,
              initvalue: localdata.part_number?.isEmpty ?? true
                  ? ""
                  : localdata.part_number,
              headerlablekey: 'key_part_number',
              radiovalue: localdata.part_number?.isEmpty ?? true ? false : true,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                } else if (value.length > 3) {
                  return "three digit allowed";
                }
              },
              onSaved: (value) {
                localdata.part_number = value.trim();
              },
              onChanged: (value) {
                localdata.part_number = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              keyboardtype: TextInputType.number,
              initvalue: localdata.unit_number?.isEmpty ?? true
                  ? ""
                  : localdata.unit_number,
              headerlablekey: 'key_unit_number',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {
                localdata.unit_number = value.trim();
              },
              onChanged: (value) {
                localdata.unit_number = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              headerlablekey: 'key_number_of_unit',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_state_name',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_historycal_site',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_land_area',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_type_ownership',
              radiobtnlables: [
                setapptext(key: 'key_solo'),
                setapptext(key: 'key_collective')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),
          draftbutton(),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget form6() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_location_land',
              radiobtnlables: [
                setapptext(key: 'key_zone_1'),
                setapptext(key: 'key_zone_2'),
                setapptext(key: 'key_zone_3'),
                setapptext(key: 'key_zone_4'),
                setapptext(key: 'key_zone_5'),
                setapptext(key: 'key_zone_6'),
                setapptext(key: 'key_zone_7')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_does_properties_document',
              radiobtnlables: [
                setapptext(key: 'key_yes_sir'),
                setapptext(key: 'key_no'),
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_current_use_property_type',
              radiobtnlables: [
                setapptext(key: 'key_release'),
                setapptext(key: 'key_commercial'),
                setapptext(key: 'key_complex'),
                setapptext(key: 'key_productive'),
                setapptext(key: 'key_govt'),
                setapptext(key: 'key_agriculture'),
                setapptext(key: 'key_block_score'),
                setapptext(key: 'key_demaged'),
                setapptext(key: 'key_property_type_specified'),
                setapptext(key: 'key_property_type_unspecified'),
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),

          ///release
          ///start
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_Type_of_redeemable_property',
              radiobtnlables: [
                setapptext(key: 'key_Palace'),
                setapptext(key: 'key_Lease_Apartment'),
                setapptext(key: 'key_Four_walls_no_building'),
                setapptext(key: 'key_Under_Construction_Repairs')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),

          ///end
          ///commercial
          ///start
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_Proprietary_Properties',
              radiobtnlables: [
                setapptext(key: 'key_shop'),
                setapptext(key: 'key_Barber'),
                setapptext(key: 'key_hotel_restaurant'),
                setapptext(key: 'key_Restaurant'),
                setapptext(key: 'key_Serai'),
                setapptext(key: 'key_Warehouse'),
                setapptext(key: 'key_Tail_Tank'),
                setapptext(key: 'key_Pharmacy'),
                setapptext(key: 'key_Bathroom'),
                setapptext(key: 'key_Another'),
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),

          ///end
          ///complex (Release / Business)
          ///start
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_redeemable_property',
              radiobtnlables: [
                setapptext(key: 'key_Palace'),
                setapptext(key: 'key_Lease_Apartment'),
                setapptext(key: 'key_Four_walls_no_building'),
                setapptext(key: 'key_Under_Construction_Repairs')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),

          ///end
          ///governmental
          ///start
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_govt_proprty',
              radiobtnlables: [
                setapptext(key: 'key_School_Startup'),
                setapptext(key: 'key_Secondary_school'),
                setapptext(key: 'key_Great_school'),
                setapptext(key: 'key_University'),
                setapptext(key: 'key_Learning_Center'),
                setapptext(key: 'key_hospital'),
                setapptext(key: 'key_clinic'),
                setapptext(key: 'key_Playground'),
                setapptext(key: 'key_Park'),
                setapptext(key: 'key_Military_area'),
                setapptext(key: 'key_mosque'),
                setapptext(key: 'key_Graveyard'),
                setapptext(key: 'key_Pilgrimage'),
                setapptext(key: 'key_Another')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),

          ///end
          ///Property Type - Other (specified)
          ///start
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_type_of_currentuse',
              radiobtnlables: [
                setapptext(key: 'key_Car_station'),
                setapptext(key: 'key_Enough_National_Station'),
                setapptext(key: 'key_air_square'),
                setapptext(key: 'key_Road'),
                setapptext(key: 'key_Wasteland'),
                setapptext(key: 'key_agriculture'),
                setapptext(key: 'key_Green_area'),
                setapptext(key: 'key_Jungle'),
                setapptext(key: 'key_abc'),
                setapptext(key: 'key_Sea'),
                setapptext(key: 'key_Empty_land')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),

          ///end
          ///Property Type - Other (unspecified)
          ///start
          formcardtextfield(
              headerlablekey: 'key_current_usage',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),

          ///end
          draftbutton(),

          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget form7() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              headerlablekey: 'key_name',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_surname',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_wold',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_birth',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_gender',
              radiobtnlables: [
                setapptext(key: 'key_male'),
                setapptext(key: 'key_female')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),
          formcardtextfield(
              headerlablekey: 'key_phone',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_email',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formCardFileuploader(
              isCompleted: false, headerlablekey: 'key_photo_owner'),
          formcardtextfield(
              headerlablekey: 'key_enter_any_mere',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          draftbutton(),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget form8() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              headerlablekey: 'key_machine_gun',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_cover_letter',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_notification_page',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_reg_no',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formCardFileuploader(
              isCompleted: false, headerlablekey: 'key_photo_note1'),
          formCardFileuploader(
              isCompleted: false, headerlablekey: 'key_photo_tips1'),
          formCardFileuploader(
              isCompleted: false, headerlablekey: 'key_photo_tips2'),
          draftbutton(),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget form9() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
            child: Text(
              setapptext(key: 'key_fourlimit_note'),
            ),
          ),
          formcardtextfield(
              headerlablekey: 'key_east',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_west',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_south',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_north',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          draftbutton(),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget form10() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              headerlablekey: 'key_release_area',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_business_area',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_total_release_units',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_total_business_unit',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          draftbutton(),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget form11() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardFileuploader(
              isCompleted: false, headerlablekey: 'key_home_map'),
          formCardFileuploader(
              isCompleted: false, headerlablekey: 'key_home_photo'),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(176, 174, 171, 1), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Radio(
                          value: false,
                          groupValue: true,
                          onChanged: (bool) {},
                        ),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_registered_property'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 10),
                        child: Checkbox(
                          value: chkval,
                          onChanged: (bool value) {
                            setState(() {
                              chkval = !chkval;
                            });
                          },
                        ))
                  ],
                ),
              ),
            ),
          ),
          draftbutton(),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  //Document Type and Verification Circuit Documents
  Widget form12() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_doc_type',
              radiobtnlables: [
                setapptext(key: 'key_religious'),
                setapptext(key: 'key_customary'),
                setapptext(key: 'key_official_decree')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),

          ///Specifications of the religious document
          ///begin
          formcardtextfield(
              headerlablekey: 'key_Issued_on',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_Place_of_Issue',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_Property_Number',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_Document_Cover',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_Document_Page',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_Document_Registration_Number',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_Land_area_in_Qawwala',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formCardFileuploader(
              isCompleted: false,
              headerlablekey: 'key_Property_Document_Photo-1'),
          formCardFileuploader(
              isCompleted: false,
              headerlablekey: 'key_Property_Document_Photo-2'),
          formCardFileuploader(
              isCompleted: false,
              headerlablekey: 'key_Property_Document_Photo-3'),
          formCardFileuploader(
              isCompleted: false,
              headerlablekey: 'key_Property_Document_Photo-4'),

          ///end
          ///Ordinary Document Specifications
          ///start
          formCardFileuploader(
              isCompleted: false, headerlablekey: 'key_photo-1'),
          formCardFileuploader(
              isCompleted: false, headerlablekey: 'key_photo-1'),

          ///end
          draftbutton(),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  //It is lightning
  Widget form13() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              headerlablekey: 'key_Meter_number',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_Common_name',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_father_name',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formCardFileuploader(
              isCompleted: false, headerlablekey: 'key_Picture_of_Bell_Power'),
        ],
      ),
    );
  }

  //Safari Booklet Specifications
  Widget form14() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              headerlablekey: 'key_Common_name',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_father_name',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_Safari_Machine_Gun_Number',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_Issued_Date',
              radiovalue: false,
              hinttextkey: 'key_way_to_enter',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formCardFileuploader(
              isCompleted: false,
              headerlablekey: 'key_Picture_of_Safari_Booklet'),
        ],
      ),
    );
  }

  //Type of property user
  Widget form15() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_the_owner',
              radiobtnlables: [
                setapptext(key: 'key_yes_sir'),
                setapptext(key: 'key_no')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_Master_rent',
              radiobtnlables: [
                setapptext(key: 'key_yes_sir'),
                setapptext(key: 'key_no')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_master_recipient',
              radiobtnlables: [
                setapptext(key: 'key_yes_sir'),
                setapptext(key: 'key_no')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_master_no_longer',
              radiobtnlables: [
                setapptext(key: 'key_yes_sir'),
                setapptext(key: 'key_no')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),
          formcardtextfield(
              headerlablekey: 'key_specify_misconduct',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          //if yes
        ],
      ),
    );
  }

  //building
  Widget form16() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_does_property_building',
              radiobtnlables: [
                setapptext(key: 'key_yes_sir'),
                setapptext(key: 'key_no')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),

          ///new building
          ///start
          formCardDropdown(
              iscompleted: false,
              headerlablekey: 'key_building_use',
              dropdownitems: [
                setapptext(key: 'key_release'),
                setapptext(key: 'key_commercial'),
                setapptext(key: 'key_govt'),
                setapptext(key: 'key_productive'),
                setapptext(key: 'key_general')
              ],
              onChanged: (value) {}),
          formCardDropdown(
              iscompleted: false,
              headerlablekey: 'key_building_category',
              dropdownitems: [
                setapptext(key: 'key_Modern_Concrete'),
                setapptext(key: 'key_Half_cream_and_half_baked'),
                setapptext(key: 'key_Cream'),
                setapptext(key: 'key_metal'),
                setapptext(key: 'key_Another')
              ],
              onChanged: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_choose_another',
              hinttextkey: '',
              radiovalue: false,
              onSaved: (value) {},
              validator: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_Number_of_floors',
              hinttextkey: '',
              radiovalue: false,
              onSaved: (value) {},
              validator: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_Unit_Size',
              hinttextkey: '',
              radiovalue: false,
              onSaved: (value) {},
              validator: (value) {})

          ///end
        ],
      ),
    );
  }

  //Type of use
  Widget form17() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_Type_of_use',
              radiobtnlables: [
                setapptext(key: 'key_release'),
                setapptext(key: 'key_commercial'),
                setapptext(key: 'key_complex'),
                setapptext(key: 'key_govt'),
                setapptext(key: 'key_agriculture'),
                setapptext(key: 'key_public_land'),
                setapptext(key: 'key_Another')
              ])
        ],
      ),
    );
  }

  //Business License
  Widget form18() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              headerlablekey: 'key_how_many_business',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_howmany_business_license',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_Another',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
        ],
      ),
    );
  }

  Widget backbutton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          formval -= 1;
        });
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
    );
  }

  Widget nextbutton() {
    return GestureDetector(
      onTap: () {
        datasaver();
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
    );
  }

  @override
  void initState() {
    localdata = new LocalPropertySurvey();
    localdata.taskid = widget.taskid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Property Registation",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ///header
              if (formval == 0) ...[
                formheader(headerlablekey: 'key_provider_details')
              ] else if (formval == 1) ...[
                formheader(headerlablekey: 'key_general_info1')
              ] else if (formval == 2) ...[
                formheader(headerlablekey: 'key_general_info_2')
              ] else if (formval == 3) ...[
                formheader(headerlablekey: 'key_physical_state')
              ] else if (formval == 4) ...[
                formheader(headerlablekey: 'key_property_location')
              ] else if (formval == 5) ...[
                formheader(headerlablekey: 'key_property_details')
              ] else if (formval == 6) ...[
                formheader(headerlablekey: 'key_true_personal')
              ] else if (formval == 7) ...[
                formheader(headerlablekey: 'key_information_and_photo')
              ] else if (formval == 8) ...[
                formheader(headerlablekey: 'key_four_limits')
              ] else if (formval == 9) ...[
                formheader(headerlablekey: 'key_details_number')
              ] else if (formval == 10) ...[
                formheader(headerlablekey: 'key_uploads')
              ],
              //form container
              if (formval == 0) ...[
                form1()
              ] else if (formval == 1) ...[
                form2()
              ] else if (formval == 2) ...[
                form3()
              ] else if (formval == 3) ...[
                form4()
              ] else if (formval == 4) ...[
                form5()
              ] else if (formval == 5) ...[
                form6()
              ] else if (formval == 6) ...[
                form7()
              ] else if (formval == 7) ...[
                form8()
              ] else if (formval == 8) ...[
                form9()
              ] else if (formval == 9) ...[
                form10()
              ] else ...[
                form11()
              ],
              //buttom menu container
              if (formval == 0) ...[
                Divider(
                  color: Colors.blueAccent,
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //back button
                      SizedBox(),
                      //next button
                      nextbutton()
                    ],
                  ),
                )
              ] else if (formval == 10) ...[
                Divider(
                  color: Colors.blueAccent,
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //back button
                      backbutton(),
                      //next button
                      SizedBox()
                    ],
                  ),
                )
              ] else ...[
                Divider(
                  color: Colors.blueAccent,
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[backbutton(), nextbutton()],
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
