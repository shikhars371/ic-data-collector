import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../localization/app_translations.dart';
import '../models/localpropertydata.dart';
import '../utils/db_helper.dart';
import '../controllers/auth.dart';
import './surveylist.dart';
import './task.dart';

class Dpvalue {
  String name;
  String value;
  Dpvalue({this.name, this.value});
}

class PropertyRegistationPage extends StatefulWidget {
  PropertyRegistationPage({this.taskid, this.surveylocalkey});
  final String taskid;
  final String surveylocalkey;
  @override
  _PropertyRegistationPage createState() => _PropertyRegistationPage();
}

class _PropertyRegistationPage extends State<PropertyRegistationPage> {
  var _formkey = GlobalKey<FormState>();
  String ddprovinceval = "0";
  String ddfstbuildinguse = "None selected";
  String ddfstbuildingCategory = "None selected";
  String ddScndbuildinguse = "None selected";
  String ddScndbuildingCategory = "None selected";
  String ddThirdbuildinguse = "None selected";
  String ddThirdbuildingCategory = "None selected";
  String ddForthbuildinguse = "None selected";
  String ddForthbuildingCategory = "None selected";
  String ddFifthbuildinguse = "None selected";
  String ddFifthbuildingCategory = "None selected";
  String ddcity = "0";
  bool chkval = false;
  int formval = 0;
  String propertylocalkey;
  LocalPropertySurvey localdata;
  File f;

  Future<String> appimagepicker() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    var apppath = await getApplicationDocumentsDirectory();
    var filename = image.path.split("/").last;
    var localfile = await image.copy('${apppath.path}/$filename');
    return localfile.path;
  }

  Widget backbutton() {
    return GestureDetector(
      onTap: () {
        if (!(propertylocalkey?.isEmpty ?? true)) {
          if (formval == 5) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    SurveyPage(id: widget.taskid),
              ),
            );
          }
        }
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

  void datasaver() async {
    if (formval == 0) {
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();
        setState(() {
          formval += 1;
        });
      }
    } else if (formval == 1) {
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();
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
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();
        setState(() {
          formval += 1;
        });
      }
    } else if (formval == 4) {
      if (!(_formkey.currentState.validate())) {
        return;
      } else {
        _formkey.currentState.save();
        int svval = await DBHelper().addPropertySurvey(localdata);
        if (svval != 0) {
          propertylocalkey = localdata.province.trim() +
              localdata.city.trim() +
              localdata.area.trim() +
              localdata.pass.trim() +
              localdata.block.trim() +
              localdata.part_number.trim() +
              localdata.unit_number.trim();
          setState(() {
            formval += 1;
          });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Warning",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  content: Text(
                      "This property Data already exist. So please go back and edit that or delete the existing and create new."),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Ok"),
                    ),
                  ],
                );
              });
        }
      }
    } else if (formval == 5) {
      if ((localdata.property_have_document?.isEmpty ?? true) ||
          (localdata.current_use_of_property?.isEmpty ?? true)) {
        return;
      } else {
        _formkey.currentState.save();
        if (localdata.property_have_document == "1") {
          await DBHelper().updatePropertySurvey(localdata, propertylocalkey);
          setState(() {
            formval += 1;
          });
        } else {
          if ((localdata.current_use_of_property == "2") ||
              (localdata.current_use_of_property == "3")) {
            await DBHelper().updatePropertySurvey(localdata, propertylocalkey);
            setState(() {
              formval = 8;
            });
          } else {
            await DBHelper().updatePropertySurvey(localdata, propertylocalkey);
            setState(() {
              formval = 9;
            });
          }
        }
      }
    } else if (formval == 6) {
      if (!(localdata.document_type?.isEmpty ?? true)) {
        _formkey.currentState.save();
        await DBHelper().updatePropertySurvey(localdata, propertylocalkey);
        setState(() {
          formval += 1;
        });
      }
      return;
    } else if (formval == 7) {
      await DBHelper().updatePropertySurvey(localdata, propertylocalkey);
      if ((localdata.current_use_of_property == "2") ||
          (localdata.current_use_of_property == "3")) {
        setState(() {
          formval += 1;
        });
      } else {
        setState(() {
          formval = 9;
        });
      }
    } else if (formval == 8) {
      _formkey.currentState.save();
      await DBHelper().updatePropertySurvey(localdata, propertylocalkey);
      setState(() {
        formval += 1;
      });
    } else if (formval == 9) {
      if (!(_formkey.currentState.validate())) {
        return;
      } else {
        if (!(localdata.first_partner_name_gender?.isEmpty ?? true)) {
          _formkey.currentState.save();
          await DBHelper().updatePropertySurvey(localdata, propertylocalkey);
          setState(() {
            formval += 1;
          });
        } else {
          return;
        }
      }
    } else if (formval == 10) {
      _formkey.currentState.save();
      await DBHelper().updatePropertySurvey(localdata, propertylocalkey);
      if (localdata.property_type == "1") {
        setState(() {
          formval = 12;
        });
      } else {
        setState(() {
          formval += 1;
        });
      }
    } else if (formval == 11) {
      _formkey.currentState.save();
      await DBHelper().updatePropertySurvey(localdata, propertylocalkey);
      setState(() {
        formval += 1;
      });
    } else if (formval == 12) {
      if (!(_formkey.currentState.validate())) {
        return;
      } else {
        _formkey.currentState.save();
        await DBHelper().updatePropertySurvey(localdata, propertylocalkey);
        if (localdata.current_use_of_property == "6") {
          setState(() {
            formval = 16;
          });
        } else if (localdata.current_use_of_property == "7") {
          setState(() {
            formval = 17;
          });
        } else if (localdata.current_use_of_property == "10") {
          setState(() {
            formval = 17;
          });
        } else {
          setState(() {
            formval = 13;
          });
        }
      }
    } else if (formval == 13) {
      _formkey.currentState.save();
      await DBHelper().updatePropertySurvey(localdata, propertylocalkey);
      setState(() {
        formval += 1;
      });
    } else if (formval == 14) {
      _formkey.currentState.save();
      await DBHelper().updatePropertySurvey(localdata, propertylocalkey);
      setState(() {
        formval += 1;
      });
    } else if (formval == 15) {
      _formkey.currentState.save();
      await DBHelper().updatePropertySurvey(localdata, propertylocalkey);
      setState(() {
        formval += 1;
      });
    } else if (formval == 16) {
      if (!(_formkey.currentState.validate())) {
        return;
      } else {
        _formkey.currentState.save();
        await DBHelper().updatePropertySurvey(localdata, propertylocalkey);
        setState(() {
          formval += 1;
        });
      }
    } else if (formval == 17) {
      _formkey.currentState.save();
      await DBHelper().updatePropertySurvey(localdata, propertylocalkey);
      setState(() {
        formval += 1;
      });
    }
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
      Function(String) onChanged,
      Widget suffix}) {
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
                    suffixIcon: suffix,
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

  Widget formCardDropdown(
      {bool iscompleted,
      String headerlablekey,
      List<Dpvalue> dropdownitems,
      Function(String) onSaved,
      String value,
      Function(String) validate,
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
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: DropdownButtonFormField<String>(
                    items: dropdownitems.map((Dpvalue data) {
                      return DropdownMenuItem<String>(
                        value: data.value,
                        child: Text(data.name),
                      );
                    }).toList(),
                    validator: validate,
                    onChanged: onChanged,
                    onSaved: onSaved,
                    value: value,
                  ),
                ),
              ),
            ],
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

  //please enter the names of the providers(0)
  Widget form1() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              headerlablekey: 'key_first_surveyor',
              radiovalue:
                  localdata.first_surveyor_name?.isEmpty ?? true ? false : true,
              hinttextkey: 'key_enter_1st_surveyor',
              initvalue: localdata.first_surveyor_name?.isEmpty ?? true
                  ? ""
                  : localdata.first_surveyor_name,
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
              initvalue: localdata.senond_surveyor_name?.isEmpty ?? true
                  ? ""
                  : localdata.senond_surveyor_name,
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
              initvalue: localdata.technical_support_name?.isEmpty ?? true
                  ? ""
                  : localdata.technical_support_name,
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

  //general info 1(1)
  Widget form2() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardDropdown(
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_yes_sir'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_no'), value: "2")
              ],
              iscompleted:
                  ((localdata.property_dispte_subject_to?.isEmpty ?? true) ||
                          (localdata.property_dispte_subject_to == "0"))
                      ? false
                      : true,
              headerlablekey: 'key_property_disputes',
              value: localdata.property_dispte_subject_to?.isEmpty ?? true
                  ? "0"
                  : localdata.property_dispte_subject_to,
              onSaved: (String value) {
                localdata.property_dispte_subject_to = value;
              },
              onChanged: (value) {
                localdata.property_dispte_subject_to = value;
                setState(() {});
              },
              validate: (value) {
                if ((value.isEmpty) || value == "0") {
                  return "required";
                }
              }),
          formCardDropdown(
              iscompleted: ((localdata.real_person_status?.isEmpty ?? true) ||
                      (localdata.real_person_status == "0"))
                  ? false
                  : true,
              headerlablekey: 'key_real_person',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_present'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_absence'), value: "3"),
                Dpvalue(name: setapptext(key: 'key_died'), value: "2")
              ],
              onSaved: (String value) {
                localdata.real_person_status = value;
              },
              value: localdata.real_person_status?.isEmpty ?? true
                  ? "0"
                  : localdata.real_person_status,
              onChanged: (value) {
                localdata.real_person_status = value;
                setState(() {});
              },
              validate: (value) {
                if ((value.isEmpty) || value == "0") {
                  return "required";
                }
              }),
          formCardDropdown(
              iscompleted: ((localdata.cityzenship_notice?.isEmpty ?? true) ||
                      (localdata.cityzenship_notice == "0"))
                  ? false
                  : true,
              headerlablekey: 'key_is_citizenship',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_yes_sir'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_no'), value: "2")
              ],
              onSaved: (String value) {
                localdata.cityzenship_notice = value;
              },
              value: localdata.cityzenship_notice?.isEmpty ?? true
                  ? "0"
                  : localdata.cityzenship_notice,
              onChanged: (value) {
                localdata.cityzenship_notice = value;
                setState(() {});
              },
              validate: (value) {
                if ((value.isEmpty) || value == "0") {
                  return "required";
                }
              }),
        ],
      ),
    );
  }

  //general info 2(2)
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
              },
              onChanged: (value) {
                localdata.issue_regarding_property = value.trim();
                setState(() {});
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
              },
              onChanged: (value) {
                localdata.municipality_ref_number = value.trim();
                setState(() {});
              }),
          formCardDropdown(
              iscompleted:
                  localdata.natural_threaten?.isEmpty ?? true ? false : true,
              value: localdata.natural_threaten?.isEmpty ?? true
                  ? "0"
                  : localdata.natural_threaten,
              headerlablekey: 'key_natural_factor',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_yes_sir'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_no'), value: "2")
              ],
              onSaved: (String value) {
                localdata.natural_threaten = value.trim();
              },
              onChanged: (value) {
                localdata.natural_threaten = value.trim();
                setState(() {});
              }),
        ],
      ),
    );
  }

  //the physical state of the property area(3)
  Widget form4() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardDropdown(
              value: localdata.status_of_area_plan?.isEmpty ?? true
                  ? "0"
                  : localdata.status_of_area_plan,
              iscompleted: ((localdata.status_of_area_plan?.isEmpty ?? true) ||
                      (localdata.status_of_area_plan == "0"))
                  ? false
                  : true,
              headerlablekey: 'key_specify_the',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_plan'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_unplan'), value: "2"),
              ],
              onSaved: (String value) {
                localdata.status_of_area_plan = value;
              },
              onChanged: (value) {
                localdata.status_of_area_plan = value;
                setState(() {});
              },
              validate: (value) {
                if ((value.isEmpty) || value == "0") {
                  return "required";
                }
              }),
          formCardDropdown(
              value: localdata.status_of_area_official?.isEmpty ?? true
                  ? "0"
                  : localdata.status_of_area_official,
              iscompleted:
                  ((localdata.status_of_area_official?.isEmpty ?? true) ||
                          (localdata.status_of_area_official == "0"))
                      ? false
                      : true,
              headerlablekey: 'key_specify_the',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_official'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_unofficial'), value: "2")
              ],
              onSaved: (String value) {
                localdata.status_of_area_official = value;
              },
              onChanged: (value) {
                localdata.status_of_area_official = value;
                setState(() {});
              },
              validate: (value) {
                if ((value.isEmpty) || value == "0") {
                  return "required";
                }
              }),
          formCardDropdown(
              value: localdata.status_of_area_regular?.isEmpty ?? true
                  ? "0"
                  : localdata.status_of_area_regular,
              iscompleted:
                  ((localdata.status_of_area_regular?.isEmpty ?? true) ||
                          (localdata.status_of_area_regular == "0"))
                      ? false
                      : true,
              headerlablekey: 'key_specify_the',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_regular'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_disorganized'), value: "2")
              ],
              onSaved: (String value) {
                localdata.status_of_area_regular = value;
              },
              onChanged: (value) {
                localdata.status_of_area_regular = value;
                setState(() {});
              },
              validate: (value) {
                if ((value.isEmpty) || (value == "0")) {
                  return "required";
                }
              }),
          formCardDropdown(
              value: localdata.slope_of_area?.isEmpty ?? true
                  ? "0"
                  : localdata.slope_of_area,
              iscompleted: ((localdata.slope_of_area?.isEmpty ?? true) ||
                      (localdata.slope_of_area == "0"))
                  ? false
                  : true,
              headerlablekey: 'key_specify_slope',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_Smooth'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_slope_30'), value: "2"),
                Dpvalue(
                    name: setapptext(key: 'key_slope_above_30'), value: "3"),
              ],
              onSaved: (String value) {
                localdata.slope_of_area = value;
              },
              onChanged: (value) {
                localdata.slope_of_area = value;
                setState(() {});
              },
              validate: (value) {
                if ((value.isEmpty) || value == "0") {
                  return "required";
                }
              }),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  //Property Location(4)
  Widget form5() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardDropdown(
              iscompleted: ((localdata.province?.isEmpty ?? true) ||
                      (localdata.province == "0"))
                  ? false
                  : true,
              headerlablekey: 'key_select_province',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_kabul'), value: "01-01"),
                Dpvalue(name: setapptext(key: 'key_nangarhar'), value: "06-01"),
                Dpvalue(name: setapptext(key: 'key_Kandahar'), value: "33-01"),
                Dpvalue(name: setapptext(key: 'key_Bamyan'), value: "10-01"),
                Dpvalue(name: setapptext(key: 'key_Daikundi'), value: "22-01"),
                Dpvalue(name: setapptext(key: 'key_Kundoz'), value: "17-01"),
                Dpvalue(name: setapptext(key: 'key_Balkh'), value: "18-01"),
                Dpvalue(name: setapptext(key: 'key_Herat'), value: "30-01"),
                Dpvalue(name: setapptext(key: 'key_Parwan'), value: "03-01"),
                Dpvalue(name: setapptext(key: 'key_Farah'), value: "04-01")
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
                  ? "0"
                  : localdata.province,
              validate: (value) {
                if ((value.isEmpty) || value == "0") {
                  return "required";
                }
              }),
          formCardDropdown(
              iscompleted:
                  ((localdata.city?.isEmpty ?? true) || (localdata.city == "0"))
                      ? false
                      : true,
              headerlablekey: 'key_select_city',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_kabul'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_Jalalabad'), value: "2"),
                Dpvalue(name: setapptext(key: 'key_Kandahar'), value: "3"),
                Dpvalue(name: setapptext(key: 'key_Bamyan'), value: "4"),
                Dpvalue(name: setapptext(key: 'key_Nili'), value: "5"),
                Dpvalue(name: setapptext(key: 'key_Kundoz'), value: "6"),
                Dpvalue(name: setapptext(key: 'key_Sharif'), value: "7"),
                Dpvalue(name: setapptext(key: 'key_Herat'), value: "8"),
                Dpvalue(name: setapptext(key: 'key_Charikar'), value: "9"),
                Dpvalue(name: setapptext(key: 'key_Farah'), value: "10")
              ],
              onChanged: (value) {
                localdata.city = value;
                print(value);
                setState(() {
                  ddcity = value;
                });
              },
              onSaved: (value) {
                localdata.city = value;
              },
              value: localdata.city?.isEmpty ?? true ? "0" : localdata.city,
              validate: (value) {
                if ((value.isEmpty) || value == "0") {
                  return "required";
                }
              }),
          formcardtextfield(
              keyboardtype: TextInputType.number,
              headerlablekey: 'key_area',
              radiovalue: localdata.area?.isEmpty ?? true ? false : true,
              hinttextkey: 'Key_number_value',
              initvalue: localdata.area?.isEmpty ?? true ? "" : localdata.area,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                } else if (value.length > 2) {
                  return "two digit allowed";
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
              hinttextkey: 'Key_number_value',
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
              hinttextkey: 'Key_number_value',
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
              hinttextkey: 'Key_number_value',
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
              radiovalue: localdata.unit_number?.isEmpty ?? true ? false : true,
              hinttextkey: 'Key_number_value',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                } else if (value.length > 3) {
                  return "three digit allowed";
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
              initvalue: localdata.unit_in_parcel?.isEmpty ?? true
                  ? ""
                  : localdata.unit_in_parcel,
              keyboardtype: TextInputType.number,
              headerlablekey: 'key_number_of_unit',
              radiovalue:
                  localdata.unit_in_parcel?.isEmpty ?? true ? false : true,
              hinttextkey: 'Key_number_value',
              onSaved: (value) {
                localdata.unit_in_parcel = value.trim();
              },
              onChanged: (value) {
                localdata.unit_in_parcel = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.street_name?.isEmpty ?? true
                  ? ""
                  : localdata.street_name,
              headerlablekey: 'key_state_name',
              radiovalue: localdata.street_name?.isEmpty ?? true ? false : true,
              hinttextkey: 'key_enter_1st_surveyor',
              onSaved: (value) {
                localdata.street_name = value.trim();
              },
              onChanged: (value) {
                localdata.street_name = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.historic_site_area?.isEmpty ?? true
                  ? ""
                  : localdata.historic_site_area,
              headerlablekey: 'key_historycal_site',
              radiovalue:
                  localdata.historic_site_area?.isEmpty ?? true ? false : true,
              hinttextkey: 'key_enter_1st_surveyor',
              onSaved: (value) {
                localdata.historic_site_area = value.trim();
              },
              onChanged: (value) {
                localdata.historic_site_area = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.land_area?.isEmpty ?? true
                  ? ""
                  : localdata.land_area,
              keyboardtype: TextInputType.number,
              headerlablekey: 'key_land_area',
              radiovalue: localdata.land_area?.isEmpty ?? true ? false : true,
              hinttextkey: 'Key_number_value',
              onSaved: (value) {
                localdata.land_area = value.trim();
              },
              onChanged: (value) {
                localdata.land_area = value.trim();
                setState(() {});
              }),
          formCardDropdown(
              value: localdata.property_type?.isEmpty ?? true
                  ? "0"
                  : localdata.property_type,
              iscompleted: ((localdata.property_type?.isEmpty ?? true) ||
                      (localdata.property_type == "0"))
                  ? false
                  : true,
              headerlablekey: 'key_type_ownership',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_solo'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_collective'), value: "2"),
              ],
              onSaved: (String value) {
                localdata.property_type = value;
              },
              onChanged: (value) {
                localdata.property_type = value;
                setState(() {});
              },
              validate: (value) {
                if ((value.isEmpty) || value == "0") {
                  return "required";
                }
              }),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  // property details(5)
  Widget form6() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardDropdown(
              value: localdata.location_of_land_area?.isEmpty ?? true
                  ? "0"
                  : localdata.location_of_land_area,
              iscompleted:
                  ((localdata.location_of_land_area?.isEmpty ?? true) ||
                          (localdata.location_of_land_area == "0"))
                      ? false
                      : true,
              headerlablekey: 'key_location_land',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_zone_1'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_zone_2'), value: "2"),
                Dpvalue(name: setapptext(key: 'key_zone_3'), value: "3"),
                Dpvalue(name: setapptext(key: 'key_zone_4'), value: "4"),
                Dpvalue(name: setapptext(key: 'key_zone_5'), value: "5"),
                Dpvalue(name: setapptext(key: 'key_zone_6'), value: "6"),
                Dpvalue(name: setapptext(key: 'key_zone_7'), value: "7"),
              ],
              onSaved: (String value) {
                localdata.location_of_land_area = value;
              },
              onChanged: (value) {
                localdata.location_of_land_area = value;
                setState(() {});
              },
              validate: (value) {
                if ((value.isEmpty) || value == "0") {
                  return "required";
                }
              }),
          formCardDropdown(
              value: localdata.property_have_document?.isEmpty ?? true
                  ? "0"
                  : localdata.property_have_document,
              iscompleted:
                  ((localdata.property_have_document?.isEmpty ?? true) ||
                          (localdata.property_have_document == "0"))
                      ? false
                      : true,
              headerlablekey: 'key_does_properties_document',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_yes_sir'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_no'), value: "2")
              ],
              onSaved: (String value) {
                localdata.property_have_document = value;
                print(value);
              },
              onChanged: (value) {
                localdata.property_have_document = value;
                setState(() {});
              },
              validate: (value) {
                if ((value.isEmpty) || value == "0") {
                  return "required";
                }
              }),
          formCardDropdown(
              value: localdata.current_use_of_property?.isEmpty ?? true
                  ? "0"
                  : localdata.current_use_of_property,
              iscompleted:
                  ((localdata.current_use_of_property?.isEmpty ?? true) ||
                          (localdata.current_use_of_property == "0"))
                      ? false
                      : true,
              headerlablekey: 'key_current_use_property_type',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_release'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_commercial'), value: "2"),
                Dpvalue(name: setapptext(key: 'key_complex'), value: "3"),
                Dpvalue(name: setapptext(key: 'key_productive'), value: "4"),
                Dpvalue(name: setapptext(key: 'key_govt'), value: "5"),
                Dpvalue(name: setapptext(key: 'key_agriculture'), value: "6"),
                Dpvalue(name: setapptext(key: 'key_block_score'), value: "7"),
                Dpvalue(name: setapptext(key: 'key_demaged'), value: "10"),
                Dpvalue(
                    name: setapptext(key: 'key_property_type_specified'),
                    value: "8"),
                Dpvalue(
                    name: setapptext(key: 'key_property_type_unspecified'),
                    value: "9"),
              ],
              onSaved: (String value) {
                localdata.current_use_of_property = value;
              },
              onChanged: (value) {
                localdata.current_use_of_property = value;
                setState(() {
                  localdata.redeemable_property = null;
                  localdata.proprietary_properties = null;
                  localdata.specified_current_use = null;
                  localdata.unspecified_current_use_type = null;
                });
              },
              validate: (value) {
                if ((value.isEmpty) || value == "0") {
                  return "required";
                }
              }),

          ///release
          ///start
          if (localdata.current_use_of_property == '1') ...[
            formCardDropdown(
                value: localdata.redeemable_property?.isEmpty ?? true
                    ? "0"
                    : localdata.redeemable_property,
                iscompleted: localdata.redeemable_property?.isEmpty ?? true
                    ? false
                    : true,
                headerlablekey: 'key_Type_of_redeemable_property',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(name: setapptext(key: 'key_Palace'), value: "1"),
                  Dpvalue(
                      name: setapptext(key: 'key_Lease_Apartment'), value: "2"),
                  Dpvalue(
                      name: setapptext(key: 'key_Four_walls_no_building'),
                      value: "3"),
                  Dpvalue(
                      name: setapptext(key: 'key_Under_Construction_Repairs'),
                      value: "4"),
                ],
                onSaved: (String value) {
                  localdata.redeemable_property = value;
                },
                onChanged: (value) {
                  localdata.redeemable_property = value;
                  setState(() {});
                }),
          ],

          ///end
          ///commercial
          ///start
          if (localdata.current_use_of_property == "2") ...[
            formCardDropdown(
                value: localdata.proprietary_properties?.isEmpty ?? true
                    ? "0"
                    : localdata.proprietary_properties,
                iscompleted: localdata.proprietary_properties?.isEmpty ?? true
                    ? false
                    : true,
                headerlablekey: 'key_Proprietary_Properties',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(name: setapptext(key: 'key_shop'), value: "10"),
                  Dpvalue(name: setapptext(key: 'key_Barber'), value: "1"),
                  Dpvalue(
                      name: setapptext(key: 'key_hotel_restaurant'),
                      value: "2"),
                  Dpvalue(name: setapptext(key: 'key_Restaurant'), value: "3"),
                  Dpvalue(name: setapptext(key: 'key_Serai'), value: "4"),
                  Dpvalue(name: setapptext(key: 'key_Warehouse'), value: "5"),
                  Dpvalue(name: setapptext(key: 'key_Tail_Tank'), value: "6"),
                  Dpvalue(name: setapptext(key: 'key_Pharmacy'), value: "7"),
                  Dpvalue(name: setapptext(key: 'key_Bathroom'), value: "8"),
                  Dpvalue(name: setapptext(key: 'key_Another'), value: "9"),
                ],
                onSaved: (String value) {
                  localdata.proprietary_properties = value;
                },
                onChanged: (value) {
                  localdata.proprietary_properties = value;
                  setState(() {});
                }),
          ],

          ///end
          ///complex (Release / Business)
          ///start
          if (localdata.current_use_of_property == "3") ...[
            formCardDropdown(
                value: localdata.redeemable_property?.isEmpty ?? true
                    ? "0"
                    : localdata.redeemable_property,
                iscompleted: localdata.redeemable_property?.isEmpty ?? true
                    ? false
                    : true,
                headerlablekey: 'key_Type_of_redeemable_property',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(name: setapptext(key: 'key_Palace'), value: "10"),
                  Dpvalue(
                      name: setapptext(key: 'key_Lease_Apartment'), value: "1"),
                  Dpvalue(
                      name: setapptext(key: 'key_Four_walls_no_building'),
                      value: "2"),
                  Dpvalue(
                      name: setapptext(key: 'key_Under_Construction_Repairs'),
                      value: "3"),
                ],
                onSaved: (String value) {
                  localdata.redeemable_property = value;
                },
                onChanged: (value) {
                  localdata.redeemable_property = value;
                  setState(() {});
                }),
            formCardDropdown(
                value: localdata.proprietary_properties?.isEmpty ?? true
                    ? "0"
                    : localdata.proprietary_properties,
                iscompleted: localdata.proprietary_properties?.isEmpty ?? true
                    ? false
                    : true,
                headerlablekey: 'key_Proprietary_Properties',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(name: setapptext(key: 'key_shop'), value: "10"),
                  Dpvalue(name: setapptext(key: 'key_Barber'), value: "1"),
                  Dpvalue(
                      name: setapptext(key: 'key_hotel_restaurant'),
                      value: "2"),
                  Dpvalue(name: setapptext(key: 'key_Restaurant'), value: "3"),
                  Dpvalue(name: setapptext(key: 'key_Serai'), value: "4"),
                  Dpvalue(name: setapptext(key: 'key_Warehouse'), value: "5"),
                  Dpvalue(name: setapptext(key: 'key_Tail_Tank'), value: "6"),
                  Dpvalue(name: setapptext(key: 'key_Pharmacy'), value: "7"),
                  Dpvalue(name: setapptext(key: 'key_Bathroom'), value: "8"),
                  Dpvalue(name: setapptext(key: 'key_Another'), value: "9"),
                ],
                onSaved: (String value) {
                  localdata.proprietary_properties = value;
                },
                onChanged: (value) {
                  localdata.proprietary_properties = value;
                  setState(() {});
                }),
          ],

          ///end
          ///governmental
          ///start
          if (localdata.current_use_of_property == "5") ...[
            formCardDropdown(
                value: localdata.govt_property?.isEmpty ?? true
                    ? "0"
                    : localdata.govt_property,
                iscompleted:
                    localdata.govt_property?.isEmpty ?? true ? false : true,
                headerlablekey: 'key_govt_proprty',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(
                      name: setapptext(key: 'key_School_Startup'), value: "1"),
                  Dpvalue(
                      name: setapptext(key: 'key_Secondary_school'),
                      value: "2"),
                  Dpvalue(
                      name: setapptext(key: 'key_Great_school'), value: "3"),
                  Dpvalue(name: setapptext(key: 'key_University'), value: "4"),
                  Dpvalue(
                      name: setapptext(key: 'key_Learning_Center'), value: "5"),
                  Dpvalue(name: setapptext(key: 'key_hospital'), value: "6"),
                  Dpvalue(name: setapptext(key: 'key_clinic'), value: "7"),
                  Dpvalue(name: setapptext(key: 'key_Playground'), value: "8"),
                  Dpvalue(name: setapptext(key: 'key_Park'), value: "9"),
                  Dpvalue(
                      name: setapptext(key: 'key_Military_area'), value: "10"),
                  Dpvalue(name: setapptext(key: 'key_mosque'), value: "11"),
                  Dpvalue(name: setapptext(key: 'key_Graveyard'), value: "12"),
                  Dpvalue(name: setapptext(key: 'key_Pilgrimage'), value: "13"),
                  Dpvalue(name: setapptext(key: 'key_Another'), value: "14"),
                ],
                onSaved: (String value) {
                  localdata.govt_property = value;
                },
                onChanged: (value) {
                  localdata.govt_property = value;
                  setState(() {});
                }),
          ],

          ///end
          ///Property Type - Other (specified)
          ///start
          if (localdata.current_use_of_property == "8") ...[
            formCardDropdown(
                value: localdata.specified_current_use?.isEmpty ?? true
                    ? "o"
                    : localdata.specified_current_use,
                iscompleted: localdata.specified_current_use?.isEmpty ?? true
                    ? false
                    : true,
                headerlablekey: 'key_type_of_currentuse',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(name: setapptext(key: 'key_Car_station'), value: "1"),
                  Dpvalue(
                      name: setapptext(key: 'key_Enough_National_Station'),
                      value: "2"),
                  Dpvalue(name: setapptext(key: 'key_air_square'), value: "3"),
                  Dpvalue(name: setapptext(key: 'key_Road'), value: "4"),
                  Dpvalue(name: setapptext(key: 'key_Wasteland'), value: "5"),
                  Dpvalue(name: setapptext(key: 'key_agriculture'), value: "6"),
                  Dpvalue(name: setapptext(key: 'key_Green_area'), value: "7"),
                  Dpvalue(name: setapptext(key: 'key_Jungle'), value: "8"),
                  Dpvalue(name: setapptext(key: 'key_abc'), value: "9"),
                  Dpvalue(name: setapptext(key: 'key_Sea'), value: "10"),
                  Dpvalue(name: setapptext(key: 'key_Empty_land'), value: "11"),
                ],
                onSaved: (String value) {
                  localdata.specified_current_use = value;
                },
                onChanged: (value) {
                  localdata.specified_current_use = value;
                  setState(() {});
                }),
          ],

          ///end
          ///Property Type - Other (unspecified)
          ///start
          if (localdata.current_use_of_property == "9") ...[
            formcardtextfield(
                initvalue:
                    localdata.unspecified_current_use_type?.isEmpty ?? true
                        ? ""
                        : localdata.unspecified_current_use_type,
                headerlablekey: 'key_current_usage',
                radiovalue:
                    localdata.unspecified_current_use_type?.isEmpty ?? true
                        ? false
                        : true,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "field should not be blank";
                  }
                },
                onSaved: (value) {
                  localdata.unspecified_current_use_type = value;
                },
                onChanged: (value) {
                  localdata.unspecified_current_use_type = value;
                  setState(() {});
                })
          ],

          ///end
          // draftbutton(),

          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  //true / False Personal Fame / Partner:(9)
  Widget form7() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              headerlablekey: 'key_name',
              radiovalue:
                  localdata.first_partner_name_property_owner?.isEmpty ?? true
                      ? false
                      : true,
              initvalue:
                  localdata.first_partner_name_property_owner?.isEmpty ?? true
                      ? ""
                      : localdata.first_partner_name_property_owner,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {
                localdata.first_partner_name_property_owner = value.trim();
              },
              onChanged: (value) {
                localdata.first_partner_name_property_owner = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              headerlablekey: 'key_surname',
              radiovalue: localdata.first_partner_surname?.isEmpty ?? true
                  ? false
                  : true,
              initvalue: localdata.first_partner_surname?.isEmpty ?? true
                  ? ""
                  : localdata.first_partner_surname,
              onSaved: (value) {
                localdata.first_partner_surname = value.trim();
              },
              onChanged: (value) {
                localdata.first_partner_surname = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              headerlablekey: 'key_wold',
              radiovalue:
                  localdata.first_partner_boy?.isEmpty ?? true ? false : true,
              initvalue: localdata.first_partner_boy?.isEmpty ?? true
                  ? ""
                  : localdata.first_partner_boy,
              onSaved: (value) {
                localdata.first_partner_boy = value.trim();
              },
              onChanged: (value) {
                localdata.first_partner_boy = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              headerlablekey: 'key_birth',
              radiovalue: localdata.first_partner__father?.isEmpty ?? true
                  ? false
                  : true,
              initvalue: localdata.first_partner__father?.isEmpty ?? true
                  ? ""
                  : localdata.first_partner__father,
              onSaved: (value) {
                localdata.first_partner__father = value.trim();
              },
              onChanged: (value) {
                localdata.first_partner__father = value.trim();
                setState(() {});
              }),
          formCardDropdown(
              value: localdata.first_partner_name_gender?.isEmpty ?? true
                  ? "0"
                  : localdata.first_partner_name_gender,
              iscompleted:
                  ((localdata.first_partner_name_gender?.isEmpty ?? true) ||
                          (localdata.first_partner_name_gender == "0"))
                      ? false
                      : true,
              headerlablekey: 'key_gender',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_male'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_female'), value: "2"),
              ],
              onSaved: (String value) {
                localdata.first_partner_name_gender = value;
              },
              onChanged: (value) {
                localdata.first_partner_name_gender = value;
                setState(() {});
              },
              validate: (value) {
                if ((value.isEmpty) || value == "0") {
                  return "required";
                }
              }),
          formcardtextfield(
              keyboardtype: TextInputType.number,
              headerlablekey: 'key_phone',
              radiovalue: localdata.first_partner_name_phone?.isEmpty ?? true
                  ? false
                  : true,
              initvalue: localdata.first_partner_name_phone?.isEmpty ?? true
                  ? ""
                  : localdata.first_partner_name_phone,
              onSaved: (value) {
                localdata.first_partner_name_phone = value.trim();
              },
              onChanged: (value) {
                localdata.first_partner_name_phone = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              keyboardtype: TextInputType.emailAddress,
              headerlablekey: 'key_email',
              radiovalue: localdata.first_partner_name_email?.isEmpty ?? true
                  ? false
                  : true,
              initvalue: localdata.first_partner_name_email?.isEmpty ?? true
                  ? ""
                  : localdata.first_partner_name_email,
              // validator: (value) {
              //   Pattern pattern =
              //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              //   RegExp regex = new RegExp(pattern);
              //   if (!regex.hasMatch(value))
              //     return 'Enter Valid Email';
              //   else
              //     return null;
              // },
              onSaved: (value) {
                localdata.first_partner_name_email = value.trim();
              },
              onChanged: (value) {
                localdata.first_partner_name_email = value.trim();
                setState(() {});
              }),
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
                        completedcheckbox(
                            isCompleted: localdata
                                        .first_partner_name_property_owner
                                        ?.isEmpty ??
                                    true
                                ? false
                                : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_owner'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.first_partner_name_property_owner =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.first_partner_name_property_owner
                                    ?.isEmpty ??
                                true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(File(
                                localdata.first_partner_name_property_owner)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          formcardtextfield(
              headerlablekey: 'key_enter_any_mere',
              radiovalue:
                  localdata.first_partner_name_mere_individuals?.isEmpty ?? true
                      ? false
                      : true,
              initvalue:
                  localdata.first_partner_name_mere_individuals?.isEmpty ?? true
                      ? ""
                      : localdata.first_partner_name_mere_individuals,
              onSaved: (value) {
                localdata.first_partner_name_mere_individuals = value.trim();
              },
              onChanged: (value) {
                localdata.first_partner_name_mere_individuals = value.trim();
                setState(() {});
              }),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  //Information and photo hint(10)
  Widget form8() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              headerlablekey: 'key_machine_gun',
              radiovalue:
                  localdata.info_photo_hint_sukuk_number?.isEmpty ?? true
                      ? false
                      : true,
              initvalue: localdata.info_photo_hint_sukuk_number?.isEmpty ?? true
                  ? ""
                  : localdata.info_photo_hint_sukuk_number,
              onSaved: (value) {
                localdata.info_photo_hint_sukuk_number = value.trim();
              },
              onChanged: (value) {
                localdata.info_photo_hint_sukuk_number = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              headerlablekey: 'key_cover_note',
              radiovalue: localdata.info_photo_hint_cover_note?.isEmpty ?? true
                  ? false
                  : true,
              initvalue: localdata.info_photo_hint_cover_note?.isEmpty ?? true
                  ? ""
                  : localdata.info_photo_hint_cover_note,
              onSaved: (value) {
                localdata.info_photo_hint_cover_note = value.trim();
              },
              onChanged: (value) {
                localdata.info_photo_hint_cover_note = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              headerlablekey: 'key_notification_page',
              radiovalue: localdata.info_photo_hint_note_page?.isEmpty ?? true
                  ? false
                  : true,
              initvalue: localdata.info_photo_hint_note_page?.isEmpty ?? true
                  ? ""
                  : localdata.info_photo_hint_note_page,
              onSaved: (value) {
                localdata.info_photo_hint_note_page = value.trim();
              },
              onChanged: (value) {
                localdata.info_photo_hint_note_page = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              headerlablekey: 'key_reg_no',
              radiovalue: localdata.info_photo_hint_reg_no?.isEmpty ?? true
                  ? false
                  : true,
              initvalue: localdata.info_photo_hint_reg_no?.isEmpty ?? true
                  ? ""
                  : localdata.info_photo_hint_reg_no,
              onSaved: (value) {
                localdata.info_photo_hint_reg_no = value.trim();
              },
              onChanged: (value) {
                localdata.info_photo_hint_reg_no = value.trim();
                setState(() {});
              }),
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
                        completedcheckbox(
                            isCompleted: localdata
                                        .info_photo_hint_photo_note1?.isEmpty ??
                                    true
                                ? false
                                : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_note1'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.info_photo_hint_photo_note1 =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.info_photo_hint_photo_note1?.isEmpty ??
                                true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.info_photo_hint_photo_note1)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
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
                        completedcheckbox(
                            isCompleted: localdata
                                        .info_photo_hint_photo_tips1?.isEmpty ??
                                    true
                                ? false
                                : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_tips1'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.info_photo_hint_photo_tips1 =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.info_photo_hint_photo_tips1?.isEmpty ??
                                true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.info_photo_hint_photo_tips1)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
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
                        completedcheckbox(
                            isCompleted: localdata
                                        .info_photo_hint_photo_tips2?.isEmpty ??
                                    true
                                ? false
                                : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_tips2'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.info_photo_hint_photo_tips2 =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.info_photo_hint_photo_tips2?.isEmpty ??
                                true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.info_photo_hint_photo_tips2)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  //Four limits(12)
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
              initvalue: localdata.fore_limits_east?.isEmpty ?? true
                  ? ""
                  : localdata.fore_limits_east,
              headerlablekey: 'key_east',
              radiovalue:
                  localdata.fore_limits_east?.isEmpty ?? true ? false : true,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {
                localdata.fore_limits_east = value.trim();
              },
              onChanged: (value) {
                localdata.fore_limits_east = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fore_limits_west?.isEmpty ?? true
                  ? ""
                  : localdata.fore_limits_west,
              headerlablekey: 'key_west',
              radiovalue:
                  localdata.fore_limits_west?.isEmpty ?? true ? false : true,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {
                localdata.fore_limits_west = value.trim();
              },
              onChanged: (value) {
                localdata.fore_limits_west = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fore_limits_south?.isEmpty ?? true
                  ? ""
                  : localdata.fore_limits_south,
              headerlablekey: 'key_south',
              radiovalue:
                  localdata.fore_limits_south?.isEmpty ?? true ? false : true,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {
                localdata.fore_limits_south = value.trim();
              },
              onChanged: (value) {
                localdata.fore_limits_south = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fore_limits_north?.isEmpty ?? true
                  ? ""
                  : localdata.fore_limits_north,
              headerlablekey: 'key_north',
              radiovalue:
                  localdata.fore_limits_north?.isEmpty ?? true ? false : true,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {
                localdata.fore_limits_north = value.trim();
              },
              onChanged: (value) {
                localdata.fore_limits_north = value.trim();
                setState(() {});
              }),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  ///Details of the number and area of ​​units
  ///(if the current use is mixed-use and commercial,
  /// fill the following sections).(17)

  Widget form10() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              initvalue: localdata.area_unit_release_area?.isEmpty ?? true
                  ? ""
                  : localdata.area_unit_release_area,
              headerlablekey: 'key_release_area',
              radiovalue: localdata.area_unit_release_area?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.area_unit_release_area = value;
              },
              onChanged: (value) {
                localdata.area_unit_release_area = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.area_unit_business_area?.isEmpty ?? true
                  ? ""
                  : localdata.area_unit_business_area,
              headerlablekey: 'key_business_area',
              radiovalue: localdata.area_unit_business_area?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.area_unit_business_area = value;
              },
              onChanged: (value) {
                localdata.area_unit_business_area = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.area_unit_total_no_unit?.isEmpty ?? true
                  ? ""
                  : localdata.area_unit_total_no_unit,
              headerlablekey: 'key_total_release_units',
              radiovalue: localdata.area_unit_total_no_unit?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.area_unit_total_no_unit = value;
              },
              onChanged: (value) {
                localdata.area_unit_total_no_unit = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.area_unit_business_units?.isEmpty ?? true
                  ? ""
                  : localdata.area_unit_business_units,
              headerlablekey: 'key_total_business_unit',
              radiovalue: localdata.area_unit_business_units?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.area_unit_business_units = value;
              },
              onChanged: (value) {
                localdata.area_unit_business_units = value;
                setState(() {});
              }),
          GestureDetector(
            onTap: () async {
              _formkey.currentState.save();
              localdata.other_key = "1";
              var rr = await DBHelper()
                  .updatePropertySurvey(localdata, propertylocalkey);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => TaskPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(blurRadius: 5.0, color: Colors.black)
                    ],
                    color: Colors.blue),
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 5,
                  right: MediaQuery.of(context).size.width / 5,
                ),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  //(17)
  Widget form11() {
    return Expanded(
      child: ListView(
        children: <Widget>[
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
                        completedcheckbox(
                            isCompleted: localdata.home_map?.isEmpty ?? true
                                ? false
                                : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_home_map'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.home_map = await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.home_map?.isEmpty ?? true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.home_map),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
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
                        completedcheckbox(
                            isCompleted: localdata.home_photo?.isEmpty ?? true
                                ? false
                                : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_home_photo'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.home_photo = await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.home_photo?.isEmpty ?? true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.home_photo),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          formCardDropdown(
              value: localdata.reg_property_fertilizer?.isEmpty ?? true
                  ? "0"
                  : localdata.reg_property_fertilizer,
              headerlablekey: 'key_registered_property',
              iscompleted: localdata.reg_property_fertilizer?.isEmpty ?? true
                  ? false
                  : true,
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_'), value: "code_num"),
              ],
              onSaved: (value) {
                localdata.reg_property_fertilizer = value;
              },
              onChanged: (value) {
                localdata.reg_property_fertilizer = value;
                setState(() {});
              }),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  //Document Type and Verification Circuit Documents(6)
  Widget form12() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardDropdown(
              value: localdata.document_type?.isEmpty ?? true
                  ? "0"
                  : localdata.document_type,
              iscompleted: ((localdata.document_type?.isEmpty ?? true) ||
                      (localdata.document_type == "0"))
                  ? false
                  : true,
              headerlablekey: 'key_doc_type',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_religious'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_customary'), value: "2"),
                Dpvalue(
                    name: setapptext(key: 'key_official_decree'), value: "3")
              ],
              onSaved: (String value) {
                localdata.document_type = value;
              },
              onChanged: (value) {
                localdata.document_type = value;
                localdata.issued_on = null;
                localdata.place_of_issue = null;
                localdata.property_number = null;
                localdata.document_cover = null;
                localdata.document_page = null;
                localdata.doc_reg_number = null;
                localdata.land_area_qawwala = null;
                localdata.property_doc_photo_1 = null;
                localdata.property_doc_photo_2 = null;
                localdata.property_doc_photo_3 = null;
                localdata.property_doc_photo_4 = null;
                localdata.odinary_doc_photo1 = null;
                localdata.odinary_doc_photo6 = null;

                setState(() {});
              },
              validate: (value) {
                if ((value.isEmpty) || value == "0") {
                  return "required";
                }
              }),

          ///Specifications of the religious document
          ///begin
          if (localdata.document_type == "1") ...[
            formcardtextfield(
              initvalue: localdata.issued_on?.isEmpty ?? true
                  ? ""
                  : localdata.issued_on,
              headerlablekey: 'key_Issued_on',
              hinttextkey: 'key_date_format',
              radiovalue: localdata.issued_on?.isEmpty ?? true ? false : true,
              onSaved: (value) {
                localdata.issued_on = value;
              },
              onChanged: (value) {
                localdata.issued_on = value;
                setState(() {});
              },
            ),
            formcardtextfield(
                initvalue: localdata.place_of_issue?.isEmpty ?? true
                    ? ""
                    : localdata.place_of_issue,
                headerlablekey: 'key_Place_of_Issue',
                radiovalue:
                    localdata.place_of_issue?.isEmpty ?? true ? false : true,
                onSaved: (value) {
                  localdata.place_of_issue = value;
                },
                onChanged: (value) {
                  localdata.place_of_issue = value;
                  setState(() {});
                }),
            formcardtextfield(
                initvalue: localdata.property_number?.isEmpty ?? true
                    ? ""
                    : localdata.property_number,
                headerlablekey: 'key_Property_Number',
                radiovalue:
                    localdata.property_number?.isEmpty ?? true ? false : true,
                onSaved: (value) {
                  localdata.property_number = value;
                },
                onChanged: (value) {
                  localdata.property_number = value;
                  setState(() {});
                }),
            formcardtextfield(
                initvalue: localdata.document_cover?.isEmpty ?? true
                    ? ""
                    : localdata.document_cover,
                headerlablekey: 'key_Document_Cover',
                radiovalue:
                    localdata.document_cover?.isEmpty ?? true ? false : true,
                onSaved: (value) {
                  localdata.document_cover = value;
                },
                onChanged: (value) {
                  localdata.document_cover = value;
                  setState(() {});
                }),
            formcardtextfield(
                initvalue: localdata.document_page?.isEmpty ?? true
                    ? ""
                    : localdata.document_page,
                headerlablekey: 'key_Document_Page',
                radiovalue:
                    localdata.document_page?.isEmpty ?? true ? false : true,
                onSaved: (value) {
                  localdata.document_page = value;
                },
                onChanged: (value) {
                  localdata.document_page = value;
                  setState(() {});
                }),
            formcardtextfield(
                initvalue: localdata.doc_reg_number?.isEmpty ?? true
                    ? ""
                    : localdata.doc_reg_number,
                headerlablekey: 'key_Document_Registration_Number',
                radiovalue:
                    localdata.doc_reg_number?.isEmpty ?? true ? false : true,
                onSaved: (value) {
                  localdata.doc_reg_number = value;
                },
                onChanged: (value) {
                  localdata.doc_reg_number = value;
                  setState(() {});
                }),
            formcardtextfield(
                initvalue: localdata.land_area_qawwala?.isEmpty ?? true
                    ? ""
                    : localdata.land_area_qawwala,
                headerlablekey: 'key_Land_area_in_Qawwala',
                radiovalue:
                    localdata.land_area_qawwala?.isEmpty ?? true ? false : true,
                onSaved: (value) {
                  localdata.land_area_qawwala = value;
                },
                onChanged: (value) {
                  localdata.land_area_qawwala = value;
                  setState(() {});
                }),
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
                          completedcheckbox(
                              isCompleted:
                                  localdata.property_doc_photo_1?.isEmpty ??
                                          true
                                      ? false
                                      : true),
                          Flexible(
                            child: Text(
                              setapptext(key: 'key_Property_Document_Photo-1'),
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 10),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                child: Text(
                                    "Click here to capture image. (< 10MB)"),
                                onPressed: () async {
                                  localdata.property_doc_photo_1 =
                                      await appimagepicker();
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2,
                          child: localdata.property_doc_photo_1?.isEmpty ?? true
                              ? Center(
                                  child: Text("No image"),
                                )
                              : Image.file(
                                  File(localdata.property_doc_photo_1)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
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
                          completedcheckbox(
                              isCompleted:
                                  localdata.property_doc_photo_2?.isEmpty ??
                                          true
                                      ? false
                                      : true),
                          Flexible(
                            child: Text(
                              setapptext(key: 'key_Property_Document_Photo-2'),
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 10),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                child: Text(
                                    "Click here to capture image. (< 10MB)"),
                                onPressed: () async {
                                  localdata.property_doc_photo_2 =
                                      await appimagepicker();
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2,
                          child: localdata.property_doc_photo_2?.isEmpty ?? true
                              ? Center(
                                  child: Text("No image"),
                                )
                              : Image.file(
                                  File(localdata.property_doc_photo_2)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
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
                          completedcheckbox(
                              isCompleted:
                                  localdata.property_doc_photo_3?.isEmpty ??
                                          true
                                      ? false
                                      : true),
                          Flexible(
                            child: Text(
                              setapptext(key: 'key_Property_Document_Photo-3'),
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 10),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                child: Text(
                                    "Click here to capture image. (< 10MB)"),
                                onPressed: () async {
                                  localdata.property_doc_photo_3 =
                                      await appimagepicker();
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2,
                          child: localdata.property_doc_photo_3?.isEmpty ?? true
                              ? Center(
                                  child: Text("No image"),
                                )
                              : Image.file(
                                  File(localdata.property_doc_photo_3)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
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
                          completedcheckbox(
                              isCompleted:
                                  localdata.property_doc_photo_4?.isEmpty ??
                                          true
                                      ? false
                                      : true),
                          Flexible(
                            child: Text(
                              setapptext(key: 'key_Property_Document_Photo-4'),
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 10),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                child: Text(
                                    "Click here to capture image. (< 10MB)"),
                                onPressed: () async {
                                  localdata.property_doc_photo_4 =
                                      await appimagepicker();
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2,
                          child: localdata.property_doc_photo_4?.isEmpty ?? true
                              ? Center(
                                  child: Text("No image"),
                                )
                              : Image.file(
                                  File(localdata.property_doc_photo_4)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],

          ///end
          ///Ordinary Document Specifications
          ///start
          if (localdata.document_type == "2" ||
              localdata.document_type == "3") ...[
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
                          completedcheckbox(
                              isCompleted:
                                  localdata.odinary_doc_photo1?.isEmpty ?? true
                                      ? false
                                      : true),
                          Flexible(
                            child: Text(
                              setapptext(key: 'key_photo-1'),
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 10),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                child: Text(
                                    "Click here to capture image. (< 10MB)"),
                                onPressed: () async {
                                  localdata.odinary_doc_photo1 =
                                      await appimagepicker();
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2,
                          child: localdata.odinary_doc_photo1?.isEmpty ?? true
                              ? Center(
                                  child: Text("No image"),
                                )
                              : Image.file(
                                  File(localdata.odinary_doc_photo1),
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
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
                          completedcheckbox(
                              isCompleted:
                                  localdata.odinary_doc_photo6?.isEmpty ?? true
                                      ? false
                                      : true),
                          Flexible(
                            child: Text(
                              setapptext(key: 'key_photo-1'),
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 10),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                child: Text(
                                    "Click here to capture image. (< 10MB)"),
                                onPressed: () async {
                                  localdata.odinary_doc_photo6 =
                                      await appimagepicker();
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 2,
                          child: localdata.odinary_doc_photo6?.isEmpty ?? true
                              ? Center(
                                  child: Text("No image"),
                                )
                              : Image.file(
                                  File(localdata.odinary_doc_photo6),
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],

          ///end

          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  //It is lightning(13)
  Widget form13() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              initvalue: localdata.lightning_meter_no?.isEmpty ?? true
                  ? ""
                  : localdata.lightning_meter_no,
              headerlablekey: 'key_meter_number',
              radiovalue:
                  localdata.lightning_meter_no?.isEmpty ?? true ? false : true,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {
                localdata.lightning_meter_no = value.trim();
              },
              onChanged: (value) {
                localdata.lightning_meter_no = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.lightning_common_name?.isEmpty ?? true
                  ? ""
                  : localdata.lightning_common_name,
              headerlablekey: 'key_Common_name',
              radiovalue: localdata.lightning_common_name?.isEmpty ?? true
                  ? false
                  : true,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {
                localdata.lightning_common_name = value.trim();
              },
              onChanged: (value) {
                localdata.lightning_common_name = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.lightning_father_name?.isEmpty ?? true
                  ? ""
                  : localdata.lightning_father_name,
              headerlablekey: 'key_father_name',
              radiovalue: localdata.lightning_father_name?.isEmpty ?? true
                  ? false
                  : true,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {
                localdata.lightning_father_name = value.trim();
              },
              onChanged: (value) {
                localdata.lightning_father_name = value.trim();
                setState(() {});
              }),
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
                        completedcheckbox(
                            isCompleted: localdata.lightning_picture_bell_power
                                        ?.isEmpty ??
                                    true
                                ? false
                                : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_Picture_of_Bell_Power'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.lightning_picture_bell_power =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata
                                    .lightning_picture_bell_power?.isEmpty ??
                                true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.lightning_picture_bell_power),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Safari Booklet Specifications(14)
  Widget form14() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              initvalue: localdata.safari_booklet_common_name?.isEmpty ?? true
                  ? ""
                  : localdata.safari_booklet_common_name,
              headerlablekey: 'key_Common_name',
              radiovalue: localdata.safari_booklet_common_name?.isEmpty ?? true
                  ? false
                  : true,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {
                localdata.safari_booklet_common_name = value.trim();
              },
              onChanged: (value) {
                localdata.safari_booklet_common_name = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.safari_booklet_father_name?.isEmpty ?? true
                  ? ""
                  : localdata.safari_booklet_father_name,
              headerlablekey: 'key_father_name',
              radiovalue: localdata.safari_booklet_father_name?.isEmpty ?? true
                  ? false
                  : true,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {
                localdata.safari_booklet_father_name = value.trim();
              },
              onChanged: (value) {
                localdata.safari_booklet_father_name = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.safari_booklet_machinegun_no?.isEmpty ?? true
                  ? ""
                  : localdata.safari_booklet_machinegun_no,
              headerlablekey: 'key_Safari_Machine_Gun_Number',
              radiovalue:
                  localdata.safari_booklet_machinegun_no?.isEmpty ?? true
                      ? false
                      : true,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {
                localdata.safari_booklet_machinegun_no = value.trim();
              },
              onChanged: (value) {
                localdata.safari_booklet_machinegun_no = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.safari_booklet_issue_date?.isEmpty ?? true
                  ? ""
                  : localdata.safari_booklet_issue_date,
              headerlablekey: 'key_Issued_Date',
              radiovalue: localdata.safari_booklet_issue_date?.isEmpty ?? true
                  ? false
                  : true,
              hinttextkey: 'key_way_to_enter',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {
                localdata.safari_booklet_issue_date = value.trim();
              },
              onChanged: (value) {
                localdata.safari_booklet_issue_date = value.trim();
                setState(() {});
              }),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.safari_booklet_picture?.isEmpty ??
                                        true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_Picture_of_Safari_Booklet'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.safari_booklet_picture =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.safari_booklet_picture?.isEmpty ?? true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.safari_booklet_picture),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Type of property user(15)
  Widget form15() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardDropdown(
            value: localdata.property_user_owner?.isEmpty ?? true
                ? "0"
                : localdata.property_user_owner,
            iscompleted:
                localdata.property_user_owner?.isEmpty ?? true ? false : true,
            headerlablekey: 'key_the_owner',
            dropdownitems: [
              Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
              Dpvalue(name: setapptext(key: 'key_yes_sir'), value: "1"),
              Dpvalue(name: setapptext(key: 'key_no'), value: "2")
            ],
            onSaved: (String value) {
              localdata.property_user_owner = value;
            },
            onChanged: (value) {
              localdata.property_user_owner = value;
              setState(() {});
            },
          ),
          formCardDropdown(
            value: localdata.property_user_master_rent?.isEmpty ?? true
                ? "0"
                : localdata.property_user_master_rent,
            iscompleted: localdata.property_user_master_rent?.isEmpty ?? true
                ? false
                : true,
            headerlablekey: 'key_Master_rent',
            dropdownitems: [
              Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
              Dpvalue(name: setapptext(key: 'key_yes_sir'), value: "1"),
              Dpvalue(name: setapptext(key: 'key_no'), value: "2")
            ],
            onSaved: (String value) {
              localdata.property_user_master_rent = value;
            },
            onChanged: (value) {
              localdata.property_user_master_rent = value;
              setState(() {});
            },
          ),
          formCardDropdown(
            value: localdata.property_user_recipient_group?.isEmpty ?? true
                ? "0"
                : localdata.property_user_recipient_group,
            iscompleted:
                localdata.property_user_recipient_group?.isEmpty ?? true
                    ? false
                    : true,
            headerlablekey: 'key_master_recipient',
            dropdownitems: [
              Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
              Dpvalue(name: setapptext(key: 'key_yes_sir'), value: "1"),
              Dpvalue(name: setapptext(key: 'key_no'), value: "2")
            ],
            onSaved: (String value) {
              localdata.property_user_recipient_group = value;
            },
            onChanged: (value) {
              localdata.property_user_recipient_group = value;
              setState(() {});
            },
          ),
          formCardDropdown(
            value: localdata.property_user_no_longer?.isEmpty ?? true
                ? "0"
                : localdata.property_user_no_longer,
            iscompleted: localdata.property_user_no_longer?.isEmpty ?? true
                ? false
                : true,
            headerlablekey: 'key_master_no_longer',
            dropdownitems: [
              Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
              Dpvalue(name: setapptext(key: 'key_yes_sir'), value: "1"),
              Dpvalue(name: setapptext(key: 'key_no'), value: "2")
            ],
            onSaved: (String value) {
              localdata.property_user_no_longer = value;
            },
            onChanged: (value) {
              localdata.property_user_no_longer = value;
              setState(() {});
            },
          ),
          if (localdata.property_user_no_longer == "1") ...[
            formcardtextfield(
                initvalue:
                    localdata.property_user_type_of_misconduct?.isEmpty ?? true
                        ? ""
                        : localdata.property_user_type_of_misconduct,
                headerlablekey: 'key_specify_misconduct',
                radiovalue:
                    localdata.property_user_type_of_misconduct?.isEmpty ?? true
                        ? false
                        : true,
                hinttextkey: 'key_enter_1st_surveyor',
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "field should not be blank";
                  }
                },
                onSaved: (value) {
                  localdata.property_user_type_of_misconduct = value.trim();
                },
                onChanged: (value) {
                  localdata.property_user_type_of_misconduct = value.trim();
                  setState(() {});
                }),
          ]

          //if yes
        ],
      ),
    );
  }

  //building(16)
  Widget form16() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardDropdown(
              value: localdata.fst_have_building?.isEmpty ?? true
                  ? "0"
                  : localdata.fst_have_building,
              iscompleted: ((localdata.fst_have_building?.isEmpty ?? true) ||
                      (localdata.fst_have_building == "0"))
                  ? false
                  : true,
              headerlablekey: 'key_does_property_building',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_yes_sir'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_no'), value: "2")
              ],
              onSaved: (String value) {
                localdata.fst_have_building = value;
              },
              onChanged: (value) {
                localdata.fst_have_building = value;
                setState(() {});
              },
              validate: (value) {
                if ((value.isEmpty) || value == "0") {
                  return "required";
                }
              }),

          ///first building
          ///start
          if (localdata.fst_have_building == "1") ...[
            formCardDropdown(
                iscompleted: ((localdata.fst_building_use?.isEmpty ?? true) ||
                        (localdata.fst_building_use == "0"))
                    ? false
                    : true,
                headerlablekey: 'key_building_use',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(name: setapptext(key: 'key_release'), value: "1"),
                  Dpvalue(name: setapptext(key: 'key_commercial'), value: "2"),
                  Dpvalue(name: setapptext(key: 'key_govt'), value: "3"),
                  Dpvalue(name: setapptext(key: 'key_productive'), value: "4"),
                  Dpvalue(name: setapptext(key: 'key_general'), value: "5"),
                ],
                onChanged: (value) {
                  localdata.fst_building_use = value;
                  setState(() {});
                },
                onSaved: (value) {
                  localdata.fst_building_use = value;
                },
                value: localdata.fst_building_use?.isEmpty ?? true
                    ? "0"
                    : localdata.fst_building_use,
                validate: (value) {
                  if ((value.isEmpty) || value == "0") {
                    return "required";
                  }
                }),
            formCardDropdown(
                iscompleted:
                    ((localdata.fst_building_category?.isEmpty ?? true) ||
                            (localdata.fst_building_category == "0"))
                        ? false
                        : true,
                headerlablekey: 'key_building_category',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(
                      name: setapptext(key: 'key_Modern_Concrete'), value: "1"),
                  Dpvalue(name: setapptext(key: 'key_Concrete'), value: "2"),
                  Dpvalue(
                      name: setapptext(key: 'key_Half_cream_and_half_baked'),
                      value: "3"),
                  Dpvalue(name: setapptext(key: 'key_Cream'), value: "4"),
                  Dpvalue(name: setapptext(key: 'key_metal'), value: "5"),
                  Dpvalue(name: setapptext(key: 'key_Another'), value: "6"),
                ],
                onChanged: (value) {
                  localdata.fst_building_category = value;
                  setState(() {});
                },
                onSaved: (value) {
                  localdata.fst_building_category = value;
                },
                value: localdata.fst_building_category?.isEmpty ?? true
                    ? "0"
                    : localdata.fst_building_category,
                validate: (value) {
                  if ((value.isEmpty) || value == "0") {
                    return "required";
                  }
                }),
            formcardtextfield(
                initvalue: localdata.fst_specifyif_other?.isEmpty ?? true
                    ? ""
                    : localdata.fst_specifyif_other,
                headerlablekey: 'key_choose_another',
                hinttextkey: '',
                radiovalue: localdata.fst_specifyif_other?.isEmpty ?? true
                    ? false
                    : true,
                onSaved: (value) {
                  localdata.fst_specifyif_other = value.trim();
                },
                onChanged: (value) {
                  localdata.fst_specifyif_other = value.trim();
                  setState(() {});
                }),
            formcardtextfield(
                initvalue: localdata.fst_no_of_floors?.isEmpty ?? true
                    ? ""
                    : localdata.fst_no_of_floors,
                headerlablekey: 'key_Number_of_floors',
                hinttextkey: '',
                radiovalue:
                    localdata.fst_no_of_floors?.isEmpty ?? true ? false : true,
                onSaved: (value) {
                  localdata.fst_no_of_floors = value.trim();
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "field should not be blank";
                  }
                },
                onChanged: (value) {
                  localdata.fst_no_of_floors = value.trim();
                  setState(() {});
                }),
            formcardtextfield(
                initvalue: localdata.fst_cubie_meter?.isEmpty ?? true
                    ? ""
                    : localdata.fst_cubie_meter,
                headerlablekey: 'key_Unit_Size',
                hinttextkey: '',
                radiovalue:
                    localdata.fst_cubie_meter?.isEmpty ?? true ? false : true,
                onSaved: (value) {
                  localdata.fst_cubie_meter = value.trim();
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "field should not be blank";
                  }
                },
                onChanged: (value) {
                  localdata.fst_cubie_meter = value.trim();
                  setState(() {});
                }),
            formCardDropdown(
                value: localdata.snd_have_building?.isEmpty ?? true
                    ? "0"
                    : localdata.snd_have_building,
                iscompleted: ((localdata.snd_have_building?.isEmpty ?? true) ||
                        (localdata.snd_have_building == "0"))
                    ? false
                    : true,
                headerlablekey: 'key_add_building',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(name: setapptext(key: 'key_yes_sir'), value: "1"),
                  Dpvalue(name: setapptext(key: 'key_no'), value: "2")
                ],
                onSaved: (String value) {
                  localdata.snd_have_building = value;
                },
                onChanged: (value) {
                  localdata.snd_have_building = value;
                  setState(() {});
                },
                validate: (value) {
                  if ((value.isEmpty) || value == "0") {
                    return "required";
                  }
                }),
          ],

          ///end
          ///second building
          ///start
          if (localdata.snd_have_building == "1") ...[
            formCardDropdown(
                iscompleted: ((localdata.snd_building_use?.isEmpty ?? true) ||
                        (localdata.snd_building_use == "0"))
                    ? false
                    : true,
                headerlablekey: 'key_building_use',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(name: setapptext(key: 'key_release'), value: "1"),
                  Dpvalue(name: setapptext(key: 'key_commercial'), value: "2"),
                  Dpvalue(name: setapptext(key: 'key_govt'), value: "3"),
                  Dpvalue(name: setapptext(key: 'key_productive'), value: "4"),
                  Dpvalue(name: setapptext(key: 'key_general'), value: "5"),
                ],
                onChanged: (value) {
                  localdata.fst_building_use = value;
                  setState(() {});
                },
                onSaved: (value) {
                  localdata.fst_building_use = value;
                },
                value: localdata.snd_building_use?.isEmpty ?? true
                    ? "0"
                    : localdata.snd_building_use,
                validate: (value) {
                  if ((value.isEmpty) || value == "0") {
                    return "required";
                  }
                }),
            formCardDropdown(
                iscompleted:
                    ((localdata.snd_building_category?.isEmpty ?? true) ||
                            (localdata.snd_building_category == "0"))
                        ? false
                        : true,
                headerlablekey: 'key_building_category',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(
                      name: setapptext(key: 'key_Modern_Concrete'), value: "1"),
                  Dpvalue(name: setapptext(key: 'key_Concrete'), value: "2"),
                  Dpvalue(
                      name: setapptext(key: 'key_Half_cream_and_half_baked'),
                      value: "3"),
                  Dpvalue(name: setapptext(key: 'key_Cream'), value: "4"),
                  Dpvalue(name: setapptext(key: 'key_metal'), value: "5"),
                  Dpvalue(name: setapptext(key: 'key_Another'), value: "6"),
                ],
                onChanged: (value) {
                  localdata.snd_building_category = value;
                  setState(() {});
                },
                onSaved: (value) {
                  localdata.snd_building_category = value;
                },
                value: localdata.snd_building_category?.isEmpty ?? true
                    ? ddScndbuildingCategory
                    : localdata.snd_building_category,
                validate: (value) {
                  if ((value.isEmpty) || value == "0") {
                    return "required";
                  }
                }),
            formcardtextfield(
                initvalue: localdata.snd_specifyif_other?.isEmpty ?? true
                    ? ""
                    : localdata.snd_specifyif_other,
                headerlablekey: 'key_choose_another',
                hinttextkey: '',
                radiovalue: localdata.snd_specifyif_other?.isEmpty ?? true
                    ? false
                    : true,
                onSaved: (value) {
                  localdata.snd_specifyif_other = value.trim();
                },
                onChanged: (value) {
                  localdata.snd_specifyif_other = value.trim();
                  setState(() {});
                }),
            formcardtextfield(
                initvalue: localdata.snd_no_of_floors?.isEmpty ?? true
                    ? ""
                    : localdata.snd_no_of_floors,
                headerlablekey: 'key_Number_of_floors',
                hinttextkey: '',
                radiovalue:
                    localdata.snd_no_of_floors?.isEmpty ?? true ? false : true,
                onSaved: (value) {
                  localdata.snd_no_of_floors = value.trim();
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "field should not be blank";
                  }
                },
                onChanged: (value) {
                  localdata.snd_no_of_floors = value.trim();
                  setState(() {});
                }),
            formcardtextfield(
                initvalue: localdata.snd_cubie_meter?.isEmpty ?? true
                    ? ""
                    : localdata.snd_cubie_meter,
                headerlablekey: 'key_Unit_Size',
                hinttextkey: '',
                radiovalue:
                    localdata.snd_cubie_meter?.isEmpty ?? true ? false : true,
                onSaved: (value) {
                  localdata.snd_cubie_meter = value.trim();
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "field should not be blank";
                  }
                },
                onChanged: (value) {
                  localdata.snd_cubie_meter = value.trim();
                  setState(() {});
                }),
            formCardDropdown(
                value: localdata.trd_have_building?.isEmpty ?? true
                    ? "0"
                    : localdata.trd_have_building,
                iscompleted: ((localdata.trd_have_building?.isEmpty ?? true) ||
                        (localdata.trd_have_building == "0"))
                    ? false
                    : true,
                headerlablekey: 'key_add_building',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(name: setapptext(key: 'key_yes_sir'), value: "1"),
                  Dpvalue(name: setapptext(key: 'key_no'), value: "2")
                ],
                onSaved: (String value) {
                  localdata.trd_have_building = value;
                },
                onChanged: (value) {
                  localdata.trd_have_building = value;
                  setState(() {});
                },
                validate: (value) {
                  if ((value.isEmpty) || value == "0") {
                    return "required";
                  }
                }),
          ],

          ///end
          ///third building
          ///start
          if (localdata.trd_have_building == "1") ...[
            formCardDropdown(
                iscompleted: ((localdata.trd_building_use?.isEmpty ?? true) ||
                        (localdata.trd_building_use == "0"))
                    ? false
                    : true,
                headerlablekey: 'key_building_use',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(name: setapptext(key: 'key_release'), value: "1"),
                  Dpvalue(name: setapptext(key: 'key_commercial'), value: "2"),
                  Dpvalue(name: setapptext(key: 'key_govt'), value: "3"),
                  Dpvalue(name: setapptext(key: 'key_productive'), value: "4"),
                  Dpvalue(name: setapptext(key: 'key_general'), value: "5"),
                ],
                onChanged: (value) {
                  localdata.trd_building_use = value;
                  setState(() {});
                },
                onSaved: (value) {
                  localdata.trd_building_use = value;
                },
                value: localdata.trd_building_use?.isEmpty ?? true
                    ? "0"
                    : localdata.trd_building_use,
                validate: (value) {
                  if ((value.isEmpty) || value == "0") {
                    return "required";
                  }
                }),
            formCardDropdown(
                iscompleted:
                    ((localdata.trd_building_category?.isEmpty ?? true) ||
                            (localdata.trd_building_category == "0"))
                        ? false
                        : true,
                headerlablekey: 'key_building_category',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(
                      name: setapptext(key: 'key_Modern_Concrete'), value: "1"),
                  Dpvalue(name: setapptext(key: 'key_Concrete'), value: "2"),
                  Dpvalue(
                      name: setapptext(key: 'key_Half_cream_and_half_baked'),
                      value: "3"),
                  Dpvalue(name: setapptext(key: 'key_Cream'), value: "4"),
                  Dpvalue(name: setapptext(key: 'key_metal'), value: "5"),
                  Dpvalue(name: setapptext(key: 'key_Another'), value: "6"),
                ],
                onChanged: (value) {
                  localdata.trd_building_category = value;
                  setState(() {});
                },
                onSaved: (value) {
                  localdata.trd_building_category = value;
                },
                value: localdata.trd_building_category?.isEmpty ?? true
                    ? "0"
                    : localdata.trd_building_category,
                validate: (value) {
                  if ((value.isEmpty) || value == "0") {
                    return "required";
                  }
                }),
            formcardtextfield(
                initvalue: localdata.trd_specifyif_other?.isEmpty ?? true
                    ? ""
                    : localdata.trd_specifyif_other,
                headerlablekey: 'key_choose_another',
                hinttextkey: '',
                radiovalue: localdata.trd_specifyif_other?.isEmpty ?? true
                    ? false
                    : true,
                onSaved: (value) {
                  localdata.trd_specifyif_other = value.trim();
                },
                onChanged: (value) {
                  localdata.trd_specifyif_other = value.trim();
                  setState(() {});
                }),
            formcardtextfield(
                initvalue: localdata.trd_no_of_floors?.isEmpty ?? true
                    ? ""
                    : localdata.trd_no_of_floors,
                headerlablekey: 'key_Number_of_floors',
                hinttextkey: '',
                radiovalue:
                    localdata.trd_no_of_floors?.isEmpty ?? true ? false : true,
                onSaved: (value) {
                  localdata.trd_no_of_floors = value.trim();
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "field should not be blank";
                  }
                },
                onChanged: (value) {
                  localdata.trd_no_of_floors = value.trim();
                  setState(() {});
                }),
            formcardtextfield(
                initvalue: localdata.trd_cubie_meter?.isEmpty ?? true
                    ? ""
                    : localdata.trd_cubie_meter,
                headerlablekey: 'key_Unit_Size',
                hinttextkey: '',
                radiovalue:
                    localdata.trd_cubie_meter?.isEmpty ?? true ? false : true,
                onSaved: (value) {
                  localdata.trd_cubie_meter = value.trim();
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "field should not be blank";
                  }
                },
                onChanged: (value) {
                  localdata.trd_cubie_meter = value.trim();
                  setState(() {});
                }),
            formCardDropdown(
                value: localdata.forth_have_building?.isEmpty ?? true
                    ? "0"
                    : localdata.forth_have_building,
                iscompleted:
                    ((localdata.forth_have_building?.isEmpty ?? true) ||
                            (localdata.forth_have_building == "0"))
                        ? false
                        : true,
                headerlablekey: 'key_add_building',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(name: setapptext(key: 'key_yes_sir'), value: "1"),
                  Dpvalue(name: setapptext(key: 'key_no'), value: "2")
                ],
                onSaved: (String value) {
                  localdata.forth_have_building = value;
                },
                onChanged: (value) {
                  localdata.forth_have_building = value;
                  setState(() {});
                },
                validate: (value) {
                  if ((value.isEmpty) || value == "0") {
                    return "required";
                  }
                }),
          ],

          ///end

          ///forth building
          ///start
          if (localdata.forth_have_building == "1") ...[
            formCardDropdown(
                iscompleted: ((localdata.forth_building_use?.isEmpty ?? true) ||
                        (localdata.forth_building_use == "0"))
                    ? false
                    : true,
                headerlablekey: 'key_building_use',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(name: setapptext(key: 'key_release'), value: "1"),
                  Dpvalue(name: setapptext(key: 'key_commercial'), value: "2"),
                  Dpvalue(name: setapptext(key: 'key_govt'), value: "3"),
                  Dpvalue(name: setapptext(key: 'key_productive'), value: "4"),
                  Dpvalue(name: setapptext(key: 'key_general'), value: "5"),
                ],
                onChanged: (value) {
                  localdata.forth_building_use = value;
                  setState(() {});
                },
                onSaved: (value) {
                  localdata.forth_building_use = value;
                },
                value: localdata.forth_building_use?.isEmpty ?? true
                    ? "0"
                    : localdata.forth_building_use,
                validate: (value) {
                  if ((value.isEmpty) || value == "0") {
                    return "required";
                  }
                }),
            formCardDropdown(
                iscompleted:
                    ((localdata.forth_building_category?.isEmpty ?? true) ||
                            (localdata.forth_building_category == "0"))
                        ? false
                        : true,
                headerlablekey: 'key_building_category',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(
                      name: setapptext(key: 'key_Modern_Concrete'), value: "1"),
                  Dpvalue(name: setapptext(key: 'key_Concrete'), value: "2"),
                  Dpvalue(
                      name: setapptext(key: 'key_Half_cream_and_half_baked'),
                      value: "3"),
                  Dpvalue(name: setapptext(key: 'key_Cream'), value: "4"),
                  Dpvalue(name: setapptext(key: 'key_metal'), value: "5"),
                  Dpvalue(name: setapptext(key: 'key_Another'), value: "6"),
                ],
                onChanged: (value) {
                  localdata.forth_building_category = value;
                  setState(() {});
                },
                onSaved: (value) {
                  localdata.forth_building_category = value;
                },
                value: localdata.forth_building_category?.isEmpty ?? true
                    ? "0"
                    : localdata.forth_building_category,
                validate: (value) {
                  if ((value.isEmpty) || value == "0") {
                    return "required";
                  }
                }),
            formcardtextfield(
                initvalue: localdata.forth_specifyif_other?.isEmpty ?? true
                    ? ""
                    : localdata.forth_specifyif_other,
                headerlablekey: 'key_choose_another',
                hinttextkey: '',
                radiovalue: localdata.forth_specifyif_other?.isEmpty ?? true
                    ? false
                    : true,
                onSaved: (value) {
                  localdata.forth_specifyif_other = value.trim();
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "field should not be blank";
                  }
                },
                onChanged: (value) {
                  localdata.forth_specifyif_other = value.trim();
                  setState(() {});
                }),
            formcardtextfield(
                initvalue: localdata.forth_no_of_floors?.isEmpty ?? true
                    ? ""
                    : localdata.forth_no_of_floors,
                headerlablekey: 'key_Number_of_floors',
                hinttextkey: '',
                radiovalue: localdata.forth_no_of_floors?.isEmpty ?? true
                    ? false
                    : true,
                onSaved: (value) {
                  localdata.forth_no_of_floors = value.trim();
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "field should not be blank";
                  }
                },
                onChanged: (value) {
                  localdata.forth_no_of_floors = value.trim();
                  setState(() {});
                }),
            formcardtextfield(
                initvalue: localdata.forth_cubie_meter?.isEmpty ?? true
                    ? ""
                    : localdata.forth_cubie_meter,
                headerlablekey: 'key_Unit_Size',
                hinttextkey: '',
                radiovalue:
                    localdata.forth_cubie_meter?.isEmpty ?? true ? false : true,
                onSaved: (value) {
                  localdata.forth_cubie_meter = value.trim();
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "field should not be blank";
                  }
                },
                onChanged: (value) {
                  localdata.forth_cubie_meter = value.trim();
                  setState(() {});
                }),
            formCardDropdown(
                value: localdata.fth_have_building?.isEmpty ?? true
                    ? "0"
                    : localdata.fth_have_building,
                iscompleted: ((localdata.fth_have_building?.isEmpty ?? true) ||
                        (localdata.fth_have_building == "0"))
                    ? false
                    : true,
                headerlablekey: 'key_add_building',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(name: setapptext(key: 'key_yes_sir'), value: "1"),
                  Dpvalue(name: setapptext(key: 'key_no'), value: "2")
                ],
                onSaved: (String value) {
                  localdata.fth_have_building = value;
                },
                onChanged: (value) {
                  localdata.fth_have_building = value;
                  setState(() {});
                },
                validate: (value) {
                  if ((value.isEmpty) || value == "0") {
                    return "required";
                  }
                }),
          ],

          ///end

          ///fifth building
          ///start
          if (localdata.fth_have_building == "1") ...[
            formCardDropdown(
                iscompleted: ((localdata.fth_building_use?.isEmpty ?? true) ||
                        (localdata.fth_building_use == "0"))
                    ? false
                    : true,
                headerlablekey: 'key_building_use',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(name: setapptext(key: 'key_release'), value: "1"),
                  Dpvalue(name: setapptext(key: 'key_commercial'), value: "2"),
                  Dpvalue(name: setapptext(key: 'key_govt'), value: "3"),
                  Dpvalue(name: setapptext(key: 'key_productive'), value: "4"),
                  Dpvalue(name: setapptext(key: 'key_general'), value: "5"),
                ],
                onChanged: (value) {
                  localdata.fth_building_use = value;
                  setState(() {});
                },
                onSaved: (value) {
                  localdata.fth_building_use = value;
                },
                value: localdata.fth_building_use?.isEmpty ?? true
                    ? "0"
                    : localdata.fth_building_use,
                validate: (value) {
                  if ((value.isEmpty) || value == "0") {
                    return "required";
                  }
                }),
            formCardDropdown(
                iscompleted:
                    ((localdata.fth_building_category?.isEmpty ?? true) ||
                            (localdata.fth_building_category == "0"))
                        ? false
                        : true,
                headerlablekey: 'key_building_category',
                dropdownitems: [
                  Dpvalue(
                      name: setapptext(key: 'key_none_selected'), value: "0"),
                  Dpvalue(
                      name: setapptext(key: 'key_Modern_Concrete'), value: "1"),
                  Dpvalue(name: setapptext(key: 'key_Concrete'), value: "2"),
                  Dpvalue(
                      name: setapptext(key: 'key_Half_cream_and_half_baked'),
                      value: "3"),
                  Dpvalue(name: setapptext(key: 'key_Cream'), value: "4"),
                  Dpvalue(name: setapptext(key: 'key_metal'), value: "5"),
                  Dpvalue(name: setapptext(key: 'key_Another'), value: "6"),
                ],
                onChanged: (value) {
                  localdata.fth_building_category = value;
                  setState(() {});
                },
                onSaved: (value) {
                  localdata.fth_building_category = value;
                },
                value: localdata.fth_building_category?.isEmpty ?? true
                    ? "0"
                    : localdata.fth_building_category,
                validate: (value) {
                  if ((value.isEmpty) || value == "0") {
                    return "required";
                  }
                }),
            formcardtextfield(
                initvalue: localdata.fth_specifyif_other?.isEmpty ?? true
                    ? ""
                    : localdata.fth_specifyif_other,
                headerlablekey: 'key_choose_another',
                hinttextkey: '',
                radiovalue: localdata.fth_specifyif_other?.isEmpty ?? true
                    ? false
                    : true,
                onSaved: (value) {
                  localdata.fth_specifyif_other = value.trim();
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "field should not be blank";
                  }
                },
                onChanged: (value) {
                  localdata.fth_specifyif_other = value.trim();
                  setState(() {});
                }),
            formcardtextfield(
                initvalue: localdata.fth_no_of_floors?.isEmpty ?? true
                    ? ""
                    : localdata.fth_no_of_floors,
                headerlablekey: 'key_Number_of_floors',
                hinttextkey: '',
                radiovalue:
                    localdata.fth_no_of_floors?.isEmpty ?? true ? false : true,
                onSaved: (value) {
                  localdata.fth_no_of_floors = value.trim();
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "field should not be blank";
                  }
                },
                onChanged: (value) {
                  localdata.fth_no_of_floors = value.trim();
                  setState(() {});
                }),
            formcardtextfield(
                initvalue: localdata.fth_cubie_meter?.isEmpty ?? true
                    ? ""
                    : localdata.fth_cubie_meter,
                headerlablekey: 'key_Unit_Size',
                hinttextkey: '',
                radiovalue:
                    localdata.fth_cubie_meter?.isEmpty ?? true ? false : true,
                onSaved: (value) {
                  localdata.fth_cubie_meter = value.trim();
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "field should not be blank";
                  }
                },
                onChanged: (value) {
                  localdata.fth_cubie_meter = value.trim();
                  setState(() {});
                })
          ],

          ///end
        ],
      ),
    );
  }

  //Type of use(7)
  Widget form17() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardDropdown(
              value: localdata.use_in_property_doc?.isEmpty ?? true
                  ? "0"
                  : localdata.use_in_property_doc,
              iscompleted:
                  localdata.use_in_property_doc?.isEmpty ?? true ? false : true,
              headerlablekey: 'key_Type_of_use',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_release'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_commercial'), value: "2"),
                Dpvalue(name: setapptext(key: 'key_complex'), value: "3"),
                Dpvalue(name: setapptext(key: 'key_productive'), value: "4"),
                Dpvalue(name: setapptext(key: 'key_govt'), value: "5"),
                Dpvalue(name: setapptext(key: 'key_agriculture'), value: "6"),
                Dpvalue(name: setapptext(key: 'key_public_land'), value: "7"),
                Dpvalue(name: setapptext(key: 'key_Another'), value: "8"),
              ],
              onSaved: (value) {
                localdata.use_in_property_doc = value;
              },
              onChanged: (value) {
                localdata.use_in_property_doc = value;
                setState(() {});
              })
        ],
      ),
    );
  }

  //Business License(8)
  Widget form18() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              keyboardtype: TextInputType.number,
              headerlablekey: 'key_how_many_business',
              radiovalue: localdata.number_of_business_unit?.isEmpty ?? true
                  ? false
                  : true,
              initvalue: localdata.number_of_business_unit?.isEmpty ?? true
                  ? ""
                  : localdata.number_of_business_unit,
              hinttextkey: 'key_enter_1st_surveyor',
              onSaved: (value) {
                localdata.number_of_business_unit = value.trim();
              },
              onChanged: (value) {
                localdata.number_of_business_unit = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              keyboardtype: TextInputType.number,
              headerlablekey: 'key_howmany_business_license',
              radiovalue:
                  localdata.business_unit_have_no_license?.isEmpty ?? true
                      ? false
                      : true,
              initvalue:
                  localdata.business_unit_have_no_license?.isEmpty ?? true
                      ? ""
                      : localdata.business_unit_have_no_license,
              hinttextkey: 'key_enter_1st_surveyor',
              onSaved: (value) {
                localdata.business_unit_have_no_license = value.trim();
              },
              onChanged: (value) {
                localdata.business_unit_have_no_license = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              headerlablekey: 'key_Another',
              radiovalue: localdata.business_license_another?.isEmpty ?? true
                  ? false
                  : true,
              initvalue: localdata.business_license_another?.isEmpty ?? true
                  ? ""
                  : localdata.business_license_another,
              hinttextkey: 'key_enter_1st_surveyor',
              onSaved: (value) {
                localdata.business_license_another = value.trim();
              },
              onChanged: (value) {
                localdata.business_license_another = value.trim();
                setState(() {});
              }),
        ],
      ),
    );
  }

  //Characteristics of the Earth's Partners If the Land Is Shared(11)
  Widget form19() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          ///second partner details
          ///start
          Padding(
            padding: EdgeInsets.all(5),
            child: Center(
              child: Text(
                setapptext(key: 'key_second_partner_info'),
              ),
            ),
          ),
          formcardtextfield(
              headerlablekey: 'key_name',
              radiovalue:
                  localdata.second_partner_name?.isEmpty ?? true ? false : true,
              initvalue: localdata.second_partner_name?.isEmpty ?? true
                  ? ""
                  : localdata.second_partner_name,
              onSaved: (value) {
                localdata.second_partner_name = value.trim();
              },
              onChanged: (value) {
                localdata.second_partner_name = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              headerlablekey: 'key_surname',
              radiovalue: localdata.second_partner_surname?.isEmpty ?? true
                  ? false
                  : true,
              initvalue: localdata.second_partner_surname?.isEmpty ?? true
                  ? ""
                  : localdata.second_partner_surname,
              onSaved: (value) {
                localdata.second_partner_surname = value.trim();
              },
              onChanged: (value) {
                localdata.second_partner_surname = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              headerlablekey: 'key_boy',
              radiovalue:
                  localdata.second_partner_boy?.isEmpty ?? true ? false : true,
              initvalue: localdata.second_partner_boy?.isEmpty ?? true
                  ? ""
                  : localdata.second_partner_boy,
              onSaved: (value) {
                localdata.second_partner_boy = value.trim();
              },
              onChanged: (value) {
                localdata.second_partner_boy = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              headerlablekey: 'key_father_name',
              radiovalue: localdata.second_partner_father?.isEmpty ?? true
                  ? false
                  : true,
              initvalue: localdata.second_partner_father?.isEmpty ?? true
                  ? ""
                  : localdata.second_partner_father,
              onSaved: (value) {
                localdata.second_partner_father = value.trim();
              },
              onChanged: (value) {
                localdata.second_partner_father = value.trim();
                setState(() {});
              }),
          formCardDropdown(
              value: localdata.second_partner_gender?.isEmpty ?? true
                  ? "0"
                  : localdata.second_partner_gender,
              iscompleted: localdata.second_partner_gender?.isEmpty ?? true
                  ? false
                  : true,
              headerlablekey: 'key_gender',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_male'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_female'), value: "2"),
              ],
              onSaved: (String value) {
                localdata.second_partner_gender = value;
              },
              onChanged: (value) {
                localdata.second_partner_gender = value;
                setState(() {});
              }),
          formcardtextfield(
              keyboardtype: TextInputType.number,
              headerlablekey: 'key_phone',
              radiovalue: localdata.second_partner_phone?.isEmpty ?? true
                  ? false
                  : true,
              initvalue: localdata.second_partner_phone?.isEmpty ?? true
                  ? ""
                  : localdata.second_partner_phone,
              onSaved: (value) {
                localdata.second_partner_phone = value.trim();
              },
              onChanged: (value) {
                localdata.second_partner_phone = value.trim();
                setState(() {});
              }),
          formcardtextfield(
              headerlablekey: 'key_email',
              radiovalue: localdata.second_partner_email?.isEmpty ?? true
                  ? false
                  : true,
              initvalue: localdata.second_partner_email?.isEmpty ?? true
                  ? ""
                  : localdata.second_partner_email,
              // validator: (value) {
              //   Pattern pattern =
              //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              //   RegExp regex = new RegExp(pattern);
              //   if (!regex.hasMatch(value))
              //     return 'Enter Valid Email';
              //   else
              //     return null;
              // },
              onSaved: (value) {
                localdata.second_partner_email = value.trim();
              },
              onChanged: (value) {
                localdata.second_partner_email = value.trim();
                setState(() {});
              }),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.second_partner_image?.isEmpty ?? true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_owner'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.second_partner_image =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.second_partner_image?.isEmpty ?? true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.second_partner_image),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          formcardtextfield(
              initvalue: localdata.second_partner_machinegun_no?.isEmpty ?? true
                  ? ""
                  : localdata.second_partner_machinegun_no,
              headerlablekey: 'key_machine_gun',
              radiovalue:
                  localdata.second_partner_machinegun_no?.isEmpty ?? true
                      ? false
                      : true,
              onSaved: (value) {
                localdata.second_partner_machinegun_no = value;
              },
              onChanged: (value) {
                localdata.second_partner_machinegun_no = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.second_partner_cover_note?.isEmpty ?? true
                  ? ""
                  : localdata.second_partner_cover_note,
              headerlablekey: 'key_cover_letter',
              radiovalue: localdata.second_partner_cover_note?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.second_partner_cover_note = value;
              },
              onChanged: (value) {
                localdata.second_partner_cover_note = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.second_partner_note_page?.isEmpty ?? true
                  ? ""
                  : localdata.second_partner_note_page,
              headerlablekey: 'key_notification_page',
              radiovalue: localdata.second_partner_note_page?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.second_partner_note_page = value;
              },
              onChanged: (value) {
                localdata.second_partner_note_page = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.second_partner_reg_no?.isEmpty ?? true
                  ? ""
                  : localdata.second_partner_reg_no,
              headerlablekey: 'key_reg_no',
              radiovalue: localdata.second_partner_reg_no?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.second_partner_reg_no = value;
              },
              onChanged: (value) {
                localdata.second_partner_reg_no = value;
                setState(() {});
              }),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.second_partner_phote_note1?.isEmpty ??
                                        true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_note1'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.second_partner_phote_note1 =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.second_partner_phote_note1?.isEmpty ??
                                true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.second_partner_phote_note1),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.second_partner_photo_tips1?.isEmpty ??
                                        true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_tips1'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.second_partner_photo_tips1 =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.second_partner_photo_tips1?.isEmpty ??
                                true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.second_partner_photo_tips1),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.second_partner_photo_tips2?.isEmpty ??
                                        true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_tips2'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.second_partner_photo_tips2 =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.second_partner_photo_tips2?.isEmpty ??
                                true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.second_partner_photo_tips2),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          ///end
          ///third partner details
          ///start
          Padding(
            padding: EdgeInsets.all(5),
            child: Center(
              child: Text(
                setapptext(key: 'key_third_partner_info'),
              ),
            ),
          ),
          formcardtextfield(
              initvalue: localdata.third_partner_name?.isEmpty ?? true
                  ? ""
                  : localdata.third_partner_name,
              headerlablekey: 'key_name',
              radiovalue:
                  localdata.third_partner_name?.isEmpty ?? true ? false : true,
              onSaved: (value) {
                localdata.third_partner_name = value;
              },
              onChanged: (value) {
                localdata.third_partner_name = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.third_partner_surname?.isEmpty ?? true
                  ? ""
                  : localdata.third_partner_surname,
              headerlablekey: 'key_surname',
              radiovalue: localdata.third_partner_surname?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.third_partner_surname = value;
              },
              onChanged: (value) {
                localdata.third_partner_surname = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.third_partner_boy?.isEmpty ?? true
                  ? ""
                  : localdata.third_partner_boy,
              headerlablekey: 'key_boy',
              radiovalue:
                  localdata.third_partner_boy?.isEmpty ?? true ? false : true,
              onSaved: (value) {
                localdata.third_partner_boy = value;
              },
              onChanged: (value) {
                localdata.third_partner_boy = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.third_partner_father?.isEmpty ?? true
                  ? ""
                  : localdata.third_partner_father,
              headerlablekey: 'key_father_name',
              radiovalue: localdata.third_partner_father?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.third_partner_father = value;
              },
              onChanged: (value) {
                localdata.third_partner_father = value;
                setState(() {});
              }),
          formCardDropdown(
              value: localdata.third_partner_gender?.isEmpty ?? true
                  ? "0"
                  : localdata.third_partner_gender,
              iscompleted: localdata.third_partner_gender?.isEmpty ?? true
                  ? false
                  : true,
              headerlablekey: 'key_gender',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_male'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_female'), value: "2"),
              ],
              onSaved: (String value) {
                localdata.third_partner_gender = value;
              },
              onChanged: (value) {
                localdata.third_partner_gender = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.third_partner_phone?.isEmpty ?? true
                  ? ""
                  : localdata.third_partner_phone,
              headerlablekey: 'key_phone',
              radiovalue:
                  localdata.third_partner_phone?.isEmpty ?? true ? false : true,
              onSaved: (value) {
                localdata.third_partner_phone = value;
              },
              onChanged: (value) {
                localdata.third_partner_phone = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.third_partner_email?.isEmpty ?? true
                  ? ""
                  : localdata.third_partner_email,
              headerlablekey: 'key_email',
              radiovalue:
                  localdata.third_partner_email?.isEmpty ?? true ? false : true,
              onSaved: (value) {
                localdata.third_partner_email = value;
              },
              onChanged: (value) {
                localdata.third_partner_email = value;
                setState(() {});
              }),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.third_partner_image?.isEmpty ?? true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_owner'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.third_partner_image =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.third_partner_image?.isEmpty ?? true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.third_partner_image),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          formcardtextfield(
              initvalue: localdata.third_partner_machinegun_no?.isEmpty ?? true
                  ? ""
                  : localdata.third_partner_machinegun_no,
              headerlablekey: 'key_machine_gun',
              radiovalue: localdata.third_partner_machinegun_no?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.third_partner_machinegun_no = value;
              },
              onChanged: (value) {
                localdata.third_partner_machinegun_no = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.third_partner_cover_note?.isEmpty ?? true
                  ? ""
                  : localdata.third_partner_cover_note,
              headerlablekey: 'key_cover_letter',
              radiovalue: localdata.third_partner_cover_note?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.third_partner_cover_note = value;
              },
              onChanged: (value) {
                localdata.third_partner_cover_note = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.third_partner_note_page?.isEmpty ?? true
                  ? ""
                  : localdata.third_partner_note_page,
              headerlablekey: 'key_notification_page',
              radiovalue: localdata.third_partner_note_page?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.third_partner_note_page = value;
              },
              onChanged: (value) {
                localdata.third_partner_note_page = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.third_partner_reg_no?.isEmpty ?? true
                  ? ""
                  : localdata.third_partner_reg_no,
              headerlablekey: 'key_reg_no',
              radiovalue: localdata.third_partner_reg_no?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.third_partner_reg_no = value;
              },
              onChanged: (value) {
                localdata.third_partner_reg_no = value;
                setState(() {});
              }),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.third_partner_phote_note1?.isEmpty ??
                                        true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_note1'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.third_partner_phote_note1 =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child:
                            localdata.third_partner_phote_note1?.isEmpty ?? true
                                ? Center(
                                    child: Text("No image"),
                                  )
                                : Image.file(
                                    File(localdata.third_partner_phote_note1),
                                  ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.third_partner_photo_tips1?.isEmpty ??
                                        true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_tips1'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.third_partner_photo_tips1 =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child:
                            localdata.third_partner_photo_tips1?.isEmpty ?? true
                                ? Center(
                                    child: Text("No image"),
                                  )
                                : Image.file(
                                    File(localdata.third_partner_photo_tips1),
                                  ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.third_partner_photo_tips2?.isEmpty ??
                                        true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_tips2'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.third_partner_photo_tips2 =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child:
                            localdata.third_partner_photo_tips2?.isEmpty ?? true
                                ? Center(
                                    child: Text("No image"),
                                  )
                                : Image.file(
                                    File(localdata.third_partner_photo_tips2),
                                  ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          ///end
          ///fourth partner
          ///start
          Padding(
            padding: EdgeInsets.all(5),
            child: Center(
              child: Text(
                setapptext(key: 'key_fourth_partner_info'),
              ),
            ),
          ),
          formcardtextfield(
              initvalue: localdata.fourth_partner_name?.isEmpty ?? true
                  ? ""
                  : localdata.fourth_partner_name,
              headerlablekey: 'key_name',
              radiovalue:
                  localdata.fourth_partner_name?.isEmpty ?? true ? false : true,
              onSaved: (value) {
                localdata.fourth_partner_name = value;
              },
              onChanged: (value) {
                localdata.fourth_partner_name = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fourth_partner_surname?.isEmpty ?? true
                  ? ""
                  : localdata.fourth_partner_surname,
              headerlablekey: 'key_surname',
              radiovalue: localdata.fourth_partner_surname?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.fourth_partner_surname = value;
              },
              onChanged: (value) {
                localdata.fourth_partner_surname = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fourth_partner_boy?.isEmpty ?? true
                  ? ""
                  : localdata.fourth_partner_boy,
              headerlablekey: 'key_boy',
              radiovalue:
                  localdata.fourth_partner_boy?.isEmpty ?? true ? false : true,
              onSaved: (value) {
                localdata.fourth_partner_boy = value;
              },
              onChanged: (value) {
                localdata.fourth_partner_boy = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fourth_partner_father?.isEmpty ?? true
                  ? ""
                  : localdata.fourth_partner_father,
              headerlablekey: 'key_father_name',
              radiovalue: localdata.fourth_partner_father?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.fourth_partner_father = value;
              },
              onChanged: (value) {
                localdata.fourth_partner_father = value;
                setState(() {});
              }),
          formCardDropdown(
              value: localdata.fourth_partner_gender?.isEmpty ?? true
                  ? "0"
                  : localdata.fourth_partner_gender,
              iscompleted: localdata.fourth_partner_gender?.isEmpty ?? true
                  ? false
                  : true,
              headerlablekey: 'key_gender',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_male'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_female'), value: "2"),
              ],
              onSaved: (String value) {
                localdata.fourth_partner_gender = value;
              },
              onChanged: (value) {
                localdata.fourth_partner_gender = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fourth_partner_phone?.isEmpty ?? true
                  ? ""
                  : localdata.fourth_partner_phone,
              headerlablekey: 'key_phone',
              radiovalue: localdata.fourth_partner_phone?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.fourth_partner_phone = value;
              },
              onChanged: (value) {
                localdata.fourth_partner_phone = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fourth_partner_email?.isEmpty ?? true
                  ? ""
                  : localdata.fourth_partner_email,
              headerlablekey: 'key_email',
              radiovalue: localdata.fourth_partner_email?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.fourth_partner_email = value;
              },
              onChanged: (value) {
                localdata.fourth_partner_email = value;
                setState(() {});
              }),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.fourth_partner_image?.isEmpty ?? true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_owner'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.fourth_partner_image =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.fourth_partner_image?.isEmpty ?? true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.fourth_partner_image),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          formcardtextfield(
              initvalue: localdata.fourth_partner_machinegun_no?.isEmpty ?? true
                  ? ""
                  : localdata.fourth_partner_machinegun_no,
              headerlablekey: 'key_machine_gun',
              radiovalue:
                  localdata.fourth_partner_machinegun_no?.isEmpty ?? true
                      ? false
                      : true,
              onSaved: (value) {
                localdata.fourth_partner_machinegun_no = value;
              },
              onChanged: (value) {
                localdata.fourth_partner_machinegun_no = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fourth_partner_cover_note?.isEmpty ?? true
                  ? ""
                  : localdata.fourth_partner_cover_note,
              headerlablekey: 'key_cover_letter',
              radiovalue: localdata.fourth_partner_cover_note?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.fourth_partner_cover_note = value;
              },
              onChanged: (value) {
                localdata.fourth_partner_cover_note = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fourth_partner_note_page?.isEmpty ?? true
                  ? ""
                  : localdata.fourth_partner_note_page,
              headerlablekey: 'key_notification_page',
              radiovalue: localdata.fourth_partner_note_page?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.fourth_partner_note_page = value;
              },
              onChanged: (value) {
                localdata.fourth_partner_note_page = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fourth_partner_reg_no?.isEmpty ?? true
                  ? ""
                  : localdata.fourth_partner_reg_no,
              headerlablekey: 'key_reg_no',
              radiovalue: localdata.fourth_partner_reg_no?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.fourth_partner_reg_no = value;
              },
              onChanged: (value) {
                localdata.fourth_partner_reg_no = value;
                setState(() {});
              }),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.fourth_partner_phote_note1?.isEmpty ??
                                        true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_note1'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.fourth_partner_phote_note1 =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.fourth_partner_phote_note1?.isEmpty ??
                                true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.fourth_partner_phote_note1),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.fourth_partner_photo_tips1?.isEmpty ??
                                        true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_tips1'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.fourth_partner_photo_tips1 =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.fourth_partner_photo_tips1?.isEmpty ??
                                true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.fourth_partner_photo_tips1),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.fourth_partner_photo_tips2?.isEmpty ??
                                        true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_tips2'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.fourth_partner_photo_tips2 =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.fourth_partner_photo_tips2?.isEmpty ??
                                true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.fourth_partner_photo_tips2),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          ///end
          ///fifth partnet deatils
          ///start
          Padding(
            padding: EdgeInsets.all(5),
            child: Center(
              child: Text(
                setapptext(key: 'key_fifth_partner_info'),
              ),
            ),
          ),
          formcardtextfield(
              initvalue: localdata.fifth_partner_name?.isEmpty ?? true
                  ? ""
                  : localdata.fifth_partner_name,
              headerlablekey: 'key_name',
              radiovalue:
                  localdata.fifth_partner_name?.isEmpty ?? true ? false : true,
              onSaved: (value) {
                localdata.fifth_partner_name = value;
              },
              onChanged: (value) {
                localdata.fifth_partner_name = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fifth_partner_surname?.isEmpty ?? true
                  ? ""
                  : localdata.fifth_partner_surname,
              headerlablekey: 'key_surname',
              radiovalue: localdata.fifth_partner_surname?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.fifth_partner_surname = value;
              },
              onChanged: (value) {
                localdata.fifth_partner_surname = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fifth_partner_boy?.isEmpty ?? true
                  ? ""
                  : localdata.fifth_partner_boy,
              headerlablekey: 'key_boy',
              radiovalue:
                  localdata.fifth_partner_boy?.isEmpty ?? true ? false : true,
              onSaved: (value) {
                localdata.fifth_partner_boy = value;
              },
              onChanged: (value) {
                localdata.fifth_partner_boy = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fifth_partner_father?.isEmpty ?? true
                  ? ""
                  : localdata.fifth_partner_father,
              headerlablekey: 'key_father_name',
              radiovalue: localdata.fifth_partner_father?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.fifth_partner_father = value;
              },
              onChanged: (value) {
                localdata.fifth_partner_father = value;
                setState(() {});
              }),
          formCardDropdown(
              value: localdata.fifth_partner_gender?.isEmpty ?? true
                  ? "0"
                  : localdata.fifth_partner_gender,
              iscompleted: localdata.fifth_partner_gender?.isEmpty ?? true
                  ? false
                  : true,
              headerlablekey: 'key_gender',
              dropdownitems: [
                Dpvalue(name: setapptext(key: 'key_none_selected'), value: "0"),
                Dpvalue(name: setapptext(key: 'key_male'), value: "1"),
                Dpvalue(name: setapptext(key: 'key_female'), value: "2"),
              ],
              onSaved: (String value) {
                localdata.fifth_partner_gender = value;
              },
              onChanged: (value) {
                localdata.fifth_partner_gender = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fifth_partner_phone?.isEmpty ?? true
                  ? ""
                  : localdata.fifth_partner_phone,
              headerlablekey: 'key_phone',
              radiovalue:
                  localdata.fifth_partner_phone?.isEmpty ?? true ? false : true,
              onSaved: (value) {
                localdata.fifth_partner_phone = value;
              },
              onChanged: (value) {
                localdata.fifth_partner_phone = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fifth_partner_email?.isEmpty ?? true
                  ? ""
                  : localdata.fifth_partner_email,
              headerlablekey: 'key_email',
              radiovalue:
                  localdata.fifth_partner_email?.isEmpty ?? true ? false : true,
              onSaved: (value) {
                localdata.fifth_partner_email = value;
              },
              onChanged: (value) {
                localdata.fifth_partner_email = value;
                setState(() {});
              }),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.fifth_partner_image?.isEmpty ?? true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_owner'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.fifth_partner_image =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child: localdata.fifth_partner_image?.isEmpty ?? true
                            ? Center(
                                child: Text("No image"),
                              )
                            : Image.file(
                                File(localdata.fifth_partner_image),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          formcardtextfield(
              initvalue: localdata.fifth_partner_machinegun_no?.isEmpty ?? true
                  ? ""
                  : localdata.fifth_partner_machinegun_no,
              headerlablekey: 'key_machine_gun',
              radiovalue: localdata.fifth_partner_machinegun_no?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.fifth_partner_machinegun_no = value;
              },
              onChanged: (value) {
                localdata.fifth_partner_machinegun_no = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fifth_partner_cover_note?.isEmpty ?? true
                  ? ""
                  : localdata.fifth_partner_cover_note,
              headerlablekey: 'key_cover_letter',
              radiovalue: localdata.fifth_partner_cover_note?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.fifth_partner_cover_note = value;
              },
              onChanged: (value) {
                localdata.fifth_partner_cover_note = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fifth_partner_note_page?.isEmpty ?? true
                  ? ""
                  : localdata.fifth_partner_note_page,
              headerlablekey: 'key_notification_page',
              radiovalue: localdata.fifth_partner_note_page?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.fifth_partner_note_page = value;
              },
              onChanged: (value) {
                localdata.fifth_partner_note_page = value;
                setState(() {});
              }),
          formcardtextfield(
              initvalue: localdata.fifth_partner_reg_no?.isEmpty ?? true
                  ? ""
                  : localdata.fifth_partner_reg_no,
              headerlablekey: 'key_reg_no',
              radiovalue: localdata.fifth_partner_reg_no?.isEmpty ?? true
                  ? false
                  : true,
              onSaved: (value) {
                localdata.fifth_partner_reg_no = value;
              },
              onChanged: (value) {
                localdata.fifth_partner_reg_no = value;
                setState(() {});
              }),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.fifth_partner_phote_note1?.isEmpty ??
                                        true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_note1'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.fifth_partner_phote_note1 =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child:
                            localdata.fifth_partner_phote_note1?.isEmpty ?? true
                                ? Center(
                                    child: Text("No image"),
                                  )
                                : Image.file(
                                    File(localdata.fifth_partner_phote_note1),
                                  ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.fifth_partner_photo_tips1?.isEmpty ??
                                        true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_tips1'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.fifth_partner_photo_tips1 =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child:
                            localdata.fifth_partner_photo_tips1?.isEmpty ?? true
                                ? Center(
                                    child: Text("No image"),
                                  )
                                : Image.file(
                                    File(localdata.fifth_partner_photo_tips1),
                                  ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
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
                        completedcheckbox(
                            isCompleted:
                                localdata.fifth_partner_photo_tips2?.isEmpty ??
                                        true
                                    ? false
                                    : true),
                        Flexible(
                          child: Text(
                            setapptext(key: 'key_photo_tips2'),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child:
                                  Text("Click here to capture image. (< 10MB)"),
                              onPressed: () async {
                                localdata.fifth_partner_photo_tips2 =
                                    await appimagepicker();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2,
                        child:
                            localdata.fifth_partner_photo_tips2?.isEmpty ?? true
                                ? Center(
                                    child: Text("No image"),
                                  )
                                : Image.file(
                                    File(localdata.fifth_partner_photo_tips2),
                                  ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          ///end
        ],
      ),
    );
  }

  @override
  void initState() {
    localdata = new LocalPropertySurvey();
    localdata.taskid = widget.taskid;
    if (!(widget.surveylocalkey?.isEmpty ?? true)) {
      Future.delayed(Duration.zero).then((_) {
        Provider.of<DBHelper>(context)
            .getpropertysurveys(
                taskid: widget.taskid, localkey: widget.surveylocalkey)
            .then((onValue) {
          setState(() {});
          localdata = onValue[0];
          formval = 5;
          propertylocalkey = localdata.local_property_key;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("form no:" + formval.toString());
    // print("prop_type:" + localdata.property_type);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Property Survey",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<DBHelper>(
        builder: (context, dbdata, child) {
          return dbdata.state == AppState.Busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
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
                          formheader(
                              headerlablekey: 'key_doc_type_verification')
                        ] else if (formval == 7) ...[
                          formheader(headerlablekey: 'key_type_of_use')
                        ] else if (formval == 8) ...[
                          formheader(headerlablekey: 'key_business_licence')
                        ] else if (formval == 9) ...[
                          formheader(headerlablekey: 'key_first_partner')
                        ] else if (formval == 10) ...[
                          formheader(
                              headerlablekey: 'key_information_and_photo')
                        ] else if (formval == 11) ...[
                          formheader(
                              headerlablekey: 'key_Characteristics_of_earth')
                        ] else if (formval == 12) ...[
                          formheader(headerlablekey: 'key_four_limits')
                        ] else if (formval == 13) ...[
                          formheader(headerlablekey: 'key_lightning')
                        ] else if (formval == 14) ...[
                          formheader(headerlablekey: 'key_safari_info')
                        ] else if (formval == 15) ...[
                          formheader(headerlablekey: 'key_prop_info')
                        ] else if (formval == 16) ...[
                          formheader(headerlablekey: 'key_building_info')
                        ] else if (formval == 17) ...[
                          formheader(headerlablekey: 'key_all_details')
                        ] else if (formval == 18) ...[
                          formheader(headerlablekey: 'key_final_details')
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
                          form12()
                        ] else if (formval == 7) ...[
                          form17()
                        ] else if (formval == 8) ...[
                          form18()
                        ] else if (formval == 9) ...[
                          form7()
                        ] else if (formval == 10) ...[
                          form8()
                        ] else if (formval == 11) ...[
                          form19()
                        ] else if (formval == 12) ...[
                          form9()
                        ] else if (formval == 13) ...[
                          form13()
                        ] else if (formval == 14) ...[
                          form14()
                        ] else if (formval == 15) ...[
                          form15()
                        ] else if (formval == 16) ...[
                          form16()
                        ] else if (formval == 17) ...[
                          form11()
                        ] else if (formval == 18) ...[
                          form10()
                        ],
                        //buttom menu container
                        if (formval == 0) ...[
                          Divider(
                            color: Colors.blueAccent,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  //back button
                                  SizedBox(),
                                  //next button
                                  nextbutton()
                                ],
                              ),
                            ),
                          )
                        ] else if (formval == 18) ...[
                          Divider(
                            color: Colors.blueAccent,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  //back button
                                  backbutton(),
                                  //next button
                                  SizedBox()
                                ],
                              ),
                            ),
                          )
                        ] else ...[
                          Divider(
                            color: Colors.blueAccent,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[backbutton(), nextbutton()],
                              ),
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
