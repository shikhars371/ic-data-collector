import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './detailnumberarea.dart';

class BuildingInfoPage extends StatefulWidget {
  BuildingInfoPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _BuildingInfoPageState createState() => _BuildingInfoPageState();
}

class _BuildingInfoPageState extends State<BuildingInfoPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  Future<String> appimagepicker() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    var apppath = await getApplicationDocumentsDirectory();
    var filename = image.path.split("/").last;
    var localfile = await image.copy('${apppath.path}/$filename');
    return localfile.path;
  }

  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
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

  Widget nextbutton() {
    return GestureDetector(
      onTap: () async {
        if (!(_formkey.currentState.validate())) {
          return;
        } else {
          _formkey.currentState.save();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => DetailsNumberAreaPage(
                localdata: localdata,
              ),
            ),
          );
        }
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

  Widget backbutton() {
    return GestureDetector(
      onTap: () {},
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

  @override
  void initState() {
    localdata = new LocalPropertySurvey();
    localdata = widget.localdata;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        //header
                        formheader(headerlablekey: 'key_building_info'),
                        //body
                        Expanded(
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
                    ? "0"
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
                        ),
                        //footer
                        Container(
                          child: Column(
                            children: <Widget>[
                              Divider(
                                color: Colors.blueAccent,
                              ),
                              Container(
                                color: Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      backbutton(),
                                      nextbutton()
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
                );
        },
      ),
    );
  }
}
