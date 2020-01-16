import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import '../localization/app_translations.dart';
import '../utils/buttomnavbar.dart';
import '../utils/appdrawer.dart';

class PropertyRegistationPage extends StatefulWidget {
  @override
  _PropertyRegistationPage createState() => _PropertyRegistationPage();
}

class _PropertyRegistationPage extends State<PropertyRegistationPage> {
  var _formkey = GlobalKey<FormState>();
  bool chkval = false;
  int formval = 0;

  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  Widget formcardtextfield(
      {String headerlablekey,
      bool radiovalue,
      String hinttextkey,
      Function(String) onSaved,
      Function(String) validator}) {
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
                  Radio(
                    value: radiovalue,
                    groupValue: true,
                    onChanged: (bool) {},
                  ),
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
                  decoration: InputDecoration(
                    hintText: setapptext(key: hinttextkey),
                  ),
                  onSaved: onSaved,
                  validator: validator,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget formCardRadioButtons(
      {bool iscompleted,
      String headerlablekey,
      List<String> radiobtnlables,
      Function(String) radiobtnSelected}) {
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
                  Radio(
                    value: iscompleted,
                    groupValue: true,
                    onChanged: (bool) {},
                  ),
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
      List<String> dropdownitems,
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
                  Radio(
                    value: iscompleted,
                    groupValue: true,
                    onChanged: (bool) {},
                  ),
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
                  child: DropdownButtonFormField(
                    items: dropdownitems.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: onChanged,
                    //onSaved: ,
                  ),
                ),
              )
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
                  Radio(
                    value: isCompleted,
                    groupValue: true,
                    onChanged: (bool) {},
                  ),
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
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).secondaryHeaderColor
          ]),
        ),
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

  Widget form1() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              headerlablekey: 'key_first_surveyor',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_second_surveyor',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_name_technical_support',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          draftbutton()
        ],
      ),
    );
  }

  Widget form2() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_property_disputes',
              radiobtnlables: [
                setapptext(key: 'key_yes_sir'),
                setapptext(key: 'key_no')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_real_person',
              radiobtnlables: [
                setapptext(key: 'key_present'),
                setapptext(key: 'key_absence'),
                setapptext(key: 'key_died')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_is_citizenship',
              radiobtnlables: [
                setapptext(key: 'key_yes_sir'),
                setapptext(key: 'key_no')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),
          draftbutton()
        ],
      ),
    );
  }

  Widget form3() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formcardtextfield(
              headerlablekey: 'key_property_issues',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_municipal_regulation',
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
              headerlablekey: 'key_natural_factor',
              radiobtnlables: [
                setapptext(key: 'key_yes_sir'),
                setapptext(key: 'key_no')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),
          draftbutton()
        ],
      ),
    );
  }

  Widget form4() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_specify_the',
              radiobtnlables: [
                setapptext(key: 'key_plan'),
                setapptext(key: 'key_unplan')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_specify_the',
              radiobtnlables: [
                setapptext(key: 'key_official'),
                setapptext(key: 'key_unofficial')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_specify_the',
              radiobtnlables: [
                setapptext(key: 'key_regular'),
                setapptext(key: 'key_disorganized')
              ],
              radiobtnSelected: (String value) {
                print(value);
              }),
          formCardRadioButtons(
              iscompleted: false,
              headerlablekey: 'key_specify_slope',
              radiobtnlables: [
                setapptext(key: 'key_Smooth'),
                setapptext(key: 'key_slope_30'),
                setapptext(key: 'key_slope_above_30')
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

  Widget form5() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          formCardDropdown(
              iscompleted: false,
              headerlablekey: 'key_select_province',
              dropdownitems: ['option 1', 'option 2', 'option 3'],
              onChanged: (value) {
                print(value);
              }),
          formCardDropdown(
              iscompleted: false,
              headerlablekey: 'key_select_city',
              dropdownitems: ['option 1', 'option 2', 'option 3'],
              onChanged: (value) {
                print(value);
              }),
          formcardtextfield(
              headerlablekey: 'key_area',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_pass',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_block',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_part_number',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
          formcardtextfield(
              headerlablekey: 'key_unit_number',
              radiovalue: false,
              hinttextkey: 'key_enter_1st_surveyor',
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "field should not be blank";
                }
              },
              onSaved: (value) {}),
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
        setState(() {
          formval += 1;
        });
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
                Container(
                  color: Theme.of(context).secondaryHeaderColor,
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
                Container(
                  color: Theme.of(context).secondaryHeaderColor,
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
                Container(
                  color: Theme.of(context).secondaryHeaderColor,
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
