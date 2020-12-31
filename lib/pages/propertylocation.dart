import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../utils/appstate.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './propertydetails.dart';
import './physicalstate.dart';
import 'package:http/http.dart' as http;

class PropertyLocationPage extends StatefulWidget {
  PropertyLocationPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _PropertyLocationPageState createState() => _PropertyLocationPageState();
}

class _PropertyLocationPageState extends State<PropertyLocationPage> {
  LocalPropertySurvey localdata;
  List nahiaList = [];

  List gozarList;
  bool gozarview = false;
  bool _prograssbar = true;
  var _formkey = GlobalKey<FormState>();

  void _nahiaListAPI(String id) async {
    final jobsListAPIUrl =
        'http://13.234.225.179:3002/mNahiasBySurveyorId?id=${id}';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      final data1 = json.decode(response.body);
      setState(() {
        nahiaList.add(data1["data"].toString());
        _prograssbar = false;
      });
      if (nahiaList.length != 0) {}
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  _gozarListAPI(String nahiaId) async {
    final jobsListAPIUrl =
        'http://13.234.225.179:3002/mGozar?nahia_id=${nahiaId}';
    final response = await http.get(jobsListAPIUrl);
    if (response.statusCode == 200) {
      final data1 = json.decode(response.body);
      print("cozar==== $data1");
      Navigator.pop(context);
      setState(() {
        gozarList = data1["data"];
        _prograssbar = false;
        gozarview = true;
      });
    } else {
      throw Exception('Failed to load jobs from API');
    }
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
        if (!(_formkey.currentState.validate()) ||
            (localdata.property_type?.isEmpty ?? true) ||
            (localdata.property_type == "0")) {
          return;
        } else {
          _formkey.currentState.save();
          //in edit mode
          if (localdata.editmode == 1) {
            if (localdata.isdrafted != 2) {
              var newloaclkey = localdata.province +
                  localdata.city +
                  localdata.area +
                  localdata.pass +
                  localdata.block +
                  localdata.part_number +
                  localdata.unit_number;
              if (newloaclkey != localdata.local_property_key) {
                var isexistPropertyId =
                    await DBHelper().ifpropertyexist(localkey: newloaclkey);
                if (isexistPropertyId) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            setapptext(key: 'key_warning'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          content: Text(setapptext(key: 'key_prop_data_exide')),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                setapptext(key: 'key_ok'),
                              ),
                            ),
                          ],
                        );
                      });
                } else {
                  await DBHelper().updatePropertySurvey(
                      localdata, localdata.local_property_key);
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: PropertyDetailsPage(
                          localdata: localdata,
                        ),
                        type: PageTransitionType.rightToLeft),
                  );
                }
              } else {
                await DBHelper().updatePropertySurvey(
                    localdata, localdata.local_property_key);
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: PropertyDetailsPage(
                        localdata: localdata,
                      ),
                      type: PageTransitionType.rightToLeft),
                );
              }
            } else {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: PropertyDetailsPage(
                        localdata: localdata,
                      ),
                      type: PageTransitionType.rightToLeft));
            }
          } else {
            localdata.local_property_key = localdata.province +
                localdata.city +
                localdata.area +
                localdata.pass +
                localdata.block +
                localdata.part_number +
                localdata.unit_number;
            int svval = await DBHelper().addPropertySurvey(localdata);
            if (svval == 0) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        setapptext(key: 'key_warning'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      content: Text(setapptext(key: 'key_prop_data_exide')),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            setapptext(key: 'key_ok'),
                          ),
                        ),
                      ],
                    );
                  });
            } else {
              localdata.isdrafted = 0;
              localdata.editmode = 1;
              await DBHelper().updateTaskStatus(taskid: localdata.taskid);
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: PropertyDetailsPage(
                        localdata: localdata,
                      ),
                      type: PageTransitionType.rightToLeft));
            }
          }
        }
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Text(
              setapptext(key: 'key_next'),
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget backbutton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: PhysicalStatePropertyPage(
                  localdata: localdata,
                ),
                type: PageTransitionType.leftToRight));
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Icon(Icons.arrow_back_ios, color: Colors.white),
            Text(
              setapptext(key: 'key_back'),
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  String getProvincename(String id) {
    var result = "";
    switch (id) {
      case "01-01":
        result = setapptext(key: 'key_kabul');
        break;
      case "06-01":
        result = setapptext(key: 'key_nangarhar');
        break;
      case "33-01":
        result = setapptext(key: 'key_Kandahar');
        break;
      case "10-01":
        result = setapptext(key: 'key_Bamyan');
        break;
      case "22-01":
        result = setapptext(key: 'key_Daikundi');
        break;
      case "17-01":
        result = setapptext(key: 'key_Kundoz');
        break;
      case "18-01":
        result = setapptext(key: 'key_Balkh');
        break;
      case "30-01":
        result = setapptext(key: 'key_Herat');
        break;
      case "03-01":
        result = setapptext(key: 'key_Parwan');
        break;
      case "04-01":
        result = setapptext(key: 'key_Farah');
        break;
      default:
        result = id;
    }
    return result;
  }

  String getCity(String id) {
    var result = "";
    switch (id) {
      case "1":
        result = setapptext(key: 'key_kabul');
        break;
      case "2":
        result = setapptext(key: 'key_Jalalabad');
        break;
      case "3":
        result = setapptext(key: 'key_Kandahar');
        break;
      case "4":
        result = setapptext(key: 'key_Bamyan');
        break;
      case "5":
        result = setapptext(key: 'key_Nili');
        break;
      case "6":
        result = setapptext(key: 'key_Kundoz');
        break;
      case "7":
        result = setapptext(key: 'key_Sharif');
        break;
      case "8":
        result = setapptext(key: 'key_Herat');
        break;
      case "9":
        result = setapptext(key: 'key_Charikar');
        break;
      case "10":
        result = setapptext(key: 'key_Farah');
        break;
      default:
        result = id;
    }
    return result;
  }

  @override
  void initState() {
    localdata = new LocalPropertySurvey();
    localdata = widget.localdata;
    localdata.province = '01-01';
    localdata.city = '1';
    
    print(
        "initdata, ${localdata.first_surveyor_name}");
    _nahiaListAPI(localdata.first_surveyor_name);
    // _gozarListAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          setapptext(key: 'key_property_survey'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _prograssbar == true
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : Consumer<DBHelper>(
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
                              formheader(
                                  headerlablekey: 'key_property_location'),
                              //body
                              Expanded(
                                child: ListView(
                                  children: <Widget>[
                                    //province
                                    formcardtextfield(
                                      fieldrequired: true,
                                      enable: false,
                                      initvalue: getProvincename(localdata.province)?.isEmpty ??
                                              true
                                          ? ""
                                          : getProvincename(localdata.province),
                                      headerlablekey: setapptext(
                                          key: 'key_select_province'),
                                      radiovalue:
                                          localdata.province?.isEmpty ?? true
                                              ? CheckColor.Black
                                              : CheckColor.Green,
                                    ),
                                    //municipality
                                    formcardtextfield(
                                      fieldrequired: true,
                                      enable: false,
                                      initvalue: getCity(localdata.city)?.isEmpty ?? true
                                          ? ""
                                          : getCity(localdata.city),
                                      headerlablekey:
                                          setapptext(key: 'key_select_city'),
                                      radiovalue:
                                          localdata.city?.isEmpty ?? true
                                              ? CheckColor.Black
                                              : CheckColor.Green,
                                    ),
                                    //district/nahia
                                    formcardtextfield2(
                                      surveyList: nahiaList,
                                      enable: false,
                                      keyboardtype: TextInputType.number,
                                      headerlablekey:
                                          setapptext(key: 'key_area'),
                                      radiovalue:
                                          localdata.area?.isEmpty ?? true
                                              ? CheckColor.Black
                                              : CheckColor.Green,
                                      hinttextkey:
                                          setapptext(key: 'Key_number_value'),
                                      initvalue: localdata.area?.isEmpty ?? true
                                          ? ""
                                          : localdata.area,
                                      fieldrequired: true,
                                      validator: (value) {
                                        if (value.trim().isEmpty) {
                                          return setapptext(
                                              key: 'key_field_not_blank');
                                        } else if (value.length != 2) {
                                          return setapptext(
                                              key: 'key_two_digit');
                                        }
                                      },
                                      onSaved: (value) {
                                        localdata.area = value.trim();
                                        _gozarListAPI(value);
                                      },
                                      onChanged: (value) {
                                        print("value =========== $value");
                                        localdata.area = value.trim();
                                        _gozarListAPI(value);
                                        showLoaderDialog(context);
                                        setState(() {
                                          gozarview = true;
                                          // _prograssbar = true;
                                        });
                                      },
                                    ),
                                    //ctu/gozar
                                    formcardtextfield4(
                                        surveyList:
                                            gozarview == false ? [] : gozarList,
                                        // gozarview == false ? [] : gozarList,
                                        enable: false,
                                        keyboardtype: TextInputType.number,
                                        initvalue:
                                            localdata.pass?.isEmpty ?? true
                                                ? ""
                                                : localdata.pass,
                                        headerlablekey:
                                            setapptext(key: 'key_pass'),
                                        hinttextkey:
                                            setapptext(key: 'Key_number_value'),
                                        radiovalue:
                                            localdata.pass?.isEmpty ?? true
                                                ? CheckColor.Black
                                                : CheckColor.Green,
                                        fieldrequired: true,
                                        validator: (value) {
                                          if (value.trim().isEmpty) {
                                            return setapptext(
                                                key: 'key_field_not_blank');
                                          } else if (value.length != 2) {
                                            return setapptext(
                                                key: 'key_two_digit');
                                          }
                                        },
                                        onSaved: (value) {
                                          localdata.pass = value.trim();
                                        },
                                        onChanged: (value) {
                                          localdata.pass = value.trim();
                                          setState(() {});
                                        }),
                                    //block
                                    formcardtextfield(
                                        enable: true,
                                        keyboardtype: TextInputType.number,
                                        initvalue:
                                            localdata.block?.isEmpty ?? true
                                                ? ""
                                                : localdata.block,
                                        headerlablekey:
                                            setapptext(key: 'key_block'),
                                        radiovalue:
                                            localdata.block?.isEmpty ?? true
                                                ? CheckColor.Black
                                                : CheckColor.Green,
                                        hinttextkey:
                                            setapptext(key: 'Key_number_value'),
                                        fieldrequired: true,
                                        validator: (value) {
                                          if (value.trim().isEmpty) {
                                            return setapptext(
                                                key: 'key_field_not_blank');
                                          } else if (value.length != 3) {
                                            return setapptext(
                                                key: 'key_three_digit');
                                          }
                                        },
                                        onSaved: (value) {
                                          localdata.block = value.trim();
                                        },
                                        onChanged: (value) {
                                          localdata.block = value.trim();
                                          setState(() {});
                                        }),
                                    //parcel
                                    formcardtextfield(
                                      enable: (localdata.isdrafted == 2)
                                          ? false
                                          : true,
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                      keyboardtype: TextInputType.number,
                                      initvalue:
                                          localdata.part_number?.isEmpty ?? true
                                              ? ""
                                              : localdata.part_number,
                                      headerlablekey:
                                          setapptext(key: 'key_part_number'),
                                      radiovalue:
                                          localdata.part_number?.isEmpty ?? true
                                              ? CheckColor.Black
                                              : CheckColor.Green,
                                      fieldrequired: true,
                                      hinttextkey:
                                          setapptext(key: 'Key_number_value'),
                                      validator: (value) {
                                        if (value.trim().isEmpty) {
                                          return setapptext(
                                              key: 'key_field_not_blank');
                                        } else if (value.length != 3) {
                                          return setapptext(
                                              key: 'key_three_digit');
                                        }
                                      },
                                      maxLength: 3,
                                      onSaved: (value) {
                                        localdata.part_number = value.trim();
                                      },
                                      onChanged: (value) {
                                        localdata.part_number = value.trim();
                                        setState(() {});
                                      },
                                    ),
                                    //unit no
                                    formcardtextfield(
                                        enable: (localdata.isdrafted == 2)
                                            ? false
                                            : true,
                                        inputFormatters: [
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        keyboardtype: TextInputType.number,
                                        initvalue:
                                            localdata.unit_number?.isEmpty ??
                                                    true
                                                ? ""
                                                : localdata.unit_number,
                                        headerlablekey:
                                            setapptext(key: 'key_unit_number'),
                                        radiovalue:
                                            localdata.unit_number?.isEmpty ??
                                                    true
                                                ? CheckColor.Black
                                                : CheckColor.Green,
                                        fieldrequired: true,
                                        hinttextkey:
                                            setapptext(key: 'Key_number_value'),
                                        validator: (value) {
                                          if (value.trim().isEmpty) {
                                            return setapptext(
                                                key: 'key_field_not_blank');
                                          } else if (value.length != 4) {
                                            return setapptext(
                                                key: 'key_limit_four');
                                          }
                                        },
                                        maxLength: 4,
                                        onSaved: (value) {
                                          localdata.unit_number = value.trim();
                                        },
                                        onChanged: (value) {
                                          localdata.unit_number = value.trim();
                                          setState(() {});
                                        }),
                                    formcardtextfield(
                                        keyboardtype: TextInputType.number,
                                        enable: localdata.isdrafted == 2
                                            ? false
                                            : true,
                                        inputFormatters: [
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        maxLength: 3,
                                        initvalue:
                                            localdata.unit_in_parcel?.isEmpty ??
                                                    true
                                                ? ""
                                                : localdata.unit_in_parcel,
                                        headerlablekey: setapptext(
                                            key: 'key_number_of_unit'),
                                        radiovalue:
                                            localdata.unit_in_parcel?.isEmpty ??
                                                    true
                                                ? CheckColor.Black
                                                : CheckColor.Green,
                                        hinttextkey:
                                            setapptext(key: 'Key_number_value'),
                                        onSaved: (value) {
                                          localdata.unit_in_parcel =
                                              value.trim();
                                        },
                                        onChanged: (value) {
                                          localdata.unit_in_parcel =
                                              value.trim();
                                          setState(() {});
                                        }),
                                    formcardtextfield(
                                        maxLength: 120,
                                        inputFormatters: [],
                                        enable: localdata.isdrafted == 2
                                            ? false
                                            : true,
                                        initvalue:
                                            localdata.street_name?.isEmpty ??
                                                    true
                                                ? ""
                                                : localdata.street_name,
                                        headerlablekey:
                                            setapptext(key: 'key_state_name'),
                                        radiovalue:
                                            localdata.street_name?.isEmpty ??
                                                    true
                                                ? CheckColor.Black
                                                : CheckColor.Green,
                                        hinttextkey: setapptext(
                                            key: 'key_enter_1st_surveyor'),
                                        onSaved: (value) {
                                          localdata.street_name = value.trim();
                                        },
                                        onChanged: (value) {
                                          localdata.street_name = value.trim();
                                          setState(() {});
                                        }),
                                    formcardtextfield(
                                        keyboardtype: TextInputType.number,
                                        maxLength: 4,
                                        inputFormatters: [
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        enable: localdata.isdrafted == 2
                                            ? false
                                            : true,
                                        initvalue: localdata.historic_site_area
                                                    ?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.historic_site_area,
                                        headerlablekey: setapptext(
                                            key: 'key_historycal_site'),
                                        radiovalue: localdata.historic_site_area
                                                    ?.isEmpty ??
                                                true
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                        onSaved: (value) {
                                          localdata.historic_site_area =
                                              value.trim();
                                        },
                                        onChanged: (value) {
                                          localdata.historic_site_area =
                                              value.trim();
                                          setState(() {});
                                        }),
                                    formcardtextfield(
                                        maxLength: 9,
                                        inputFormatters: [
                                          WhitelistingTextInputFormatter(
                                              RegExp(r'^[0-9.]*$'))
                                        ],
                                        enable: localdata.isdrafted == 2
                                            ? false
                                            : true,
                                        initvalue:
                                            localdata.land_area?.isEmpty ?? true
                                                ? ""
                                                : localdata.land_area,
                                        keyboardtype: TextInputType.number,
                                        headerlablekey:
                                            setapptext(key: 'key_land_area'),
                                        radiovalue:
                                            localdata.land_area?.isEmpty ?? true
                                                ? CheckColor.Black
                                                : CheckColor.Green,
                                        hinttextkey:
                                            setapptext(key: 'Key_number_value'),
                                        onSaved: (value) {
                                          localdata.land_area = value.trim();

                                          setState(() {});
                                        },
                                        onChanged: (value) {
                                          localdata.land_area = value.trim();
                                          setState(() {});
                                        }),
                                    formCardDropdown(
                                        fieldrequired: true,
                                        enable: localdata.isdrafted == 2
                                            ? true
                                            : false,
                                        value:
                                            localdata.property_type?.isEmpty ??
                                                    true
                                                ? "0"
                                                : localdata.property_type,
                                        iscompleted: ((localdata.property_type
                                                        ?.isEmpty ??
                                                    true) ||
                                                (localdata.property_type ==
                                                    "0"))
                                            ? CheckColor.Black
                                            : CheckColor.Green,
                                        headerlablekey: setapptext(
                                            key: 'key_type_ownership'),
                                        dropdownitems: [
                                          Dpvalue(
                                              name: setapptext(
                                                  key: 'key_none_selected'),
                                              value: "0"),
                                          Dpvalue(
                                              name: setapptext(key: 'key_solo'),
                                              value: "1"),
                                          Dpvalue(
                                              name: setapptext(
                                                  key: 'key_collective'),
                                              value: "2"),
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
                                            return setapptext(
                                                key: 'key_required');
                                          }
                                        }),
                                    SizedBox(
                                      height: 50,
                                    ),
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
                                      color: Colors.blue,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
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

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  submit() {
    print("submit ===================== ");
  }
}

class SurveyModel {
  String sId;
  String firstName;
  String lastName;
  String departmentId;
  String designation;
  String phone;
  String email;
  String userName;
  String address;
  String activeStatus;
  List<String> roleId;
  String deviceModelName;
  String deviceStatus;
  String deviceAllocationDate;
  String provinceId;
  String muncipalityId;
  String nahiaId;
  String gozarId;
  String imeiNo;
  String mobileAccess;
  String updatedAt;
  String createdAt;
  String createdBy;
  String deviceSerielNo;
  String ip;
  String updatedBy;
  String rolePos;
  List<String> roleName;
  String profileImage;
  String gender;
  ConfirmationStatus confirmationStatus;
  String status;
  Null validFrom;
  Null validTo;

  SurveyModel(
      {this.sId,
      this.firstName,
      this.lastName,
      this.departmentId,
      this.designation,
      this.phone,
      this.email,
      this.userName,
      this.address,
      this.activeStatus,
      this.roleId,
      this.deviceModelName,
      this.deviceStatus,
      this.deviceAllocationDate,
      this.provinceId,
      this.muncipalityId,
      this.nahiaId,
      this.gozarId,
      this.imeiNo,
      this.mobileAccess,
      this.updatedAt,
      this.createdAt,
      this.createdBy,
      this.deviceSerielNo,
      this.ip,
      this.updatedBy,
      this.rolePos,
      this.roleName,
      this.profileImage,
      this.gender,
      this.confirmationStatus,
      this.status,
      this.validFrom,
      this.validTo});

  SurveyModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    departmentId = json['department_id'];
    designation = json['designation'];
    phone = json['phone'];
    email = json['email'];
    userName = json['user_name'];
    address = json['address'];
    activeStatus = json['active_status'];
    roleId = json['role_id'].cast<String>();
    deviceModelName = json['device_model_name'];
    deviceStatus = json['device_status'];
    deviceAllocationDate = json['device_allocation_date'];
    provinceId = json['province_id'];
    muncipalityId = json['muncipality_id'];
    nahiaId = json['nahia_id'];
    gozarId = json['gozar_id'];
    imeiNo = json['imei_no'];
    mobileAccess = json['mobile_access'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    createdBy = json['created_by'];
    deviceSerielNo = json['device_seriel_no'];
    ip = json['ip'];
    updatedBy = json['updated_by'];
    rolePos = json['role_pos'];
    roleName = json['role_name'].cast<String>();
    profileImage = json['profile_image'];
    gender = json['gender'];
    confirmationStatus = json['confirmation_status'] != null
        ? new ConfirmationStatus.fromJson(json['confirmation_status'])
        : null;
    status = json['status'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['department_id'] = this.departmentId;
    data['designation'] = this.designation;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['user_name'] = this.userName;
    data['address'] = this.address;
    data['active_status'] = this.activeStatus;
    data['role_id'] = this.roleId;
    data['device_model_name'] = this.deviceModelName;
    data['device_status'] = this.deviceStatus;
    data['device_allocation_date'] = this.deviceAllocationDate;
    data['province_id'] = this.provinceId;
    data['muncipality_id'] = this.muncipalityId;
    data['nahia_id'] = this.nahiaId;
    data['gozar_id'] = this.gozarId;
    data['imei_no'] = this.imeiNo;
    data['mobile_access'] = this.mobileAccess;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['device_seriel_no'] = this.deviceSerielNo;
    data['ip'] = this.ip;
    data['updated_by'] = this.updatedBy;
    data['role_pos'] = this.rolePos;
    data['role_name'] = this.roleName;
    data['profile_image'] = this.profileImage;
    data['gender'] = this.gender;
    if (this.confirmationStatus != null) {
      data['confirmation_status'] = this.confirmationStatus.toJson();
    }
    data['status'] = this.status;
    data['valid_from'] = this.validFrom;
    data['valid_to'] = this.validTo;
    return data;
  }
}

class ConfirmationStatus {
  String ctucMember;
  String surveyor;

  ConfirmationStatus({this.ctucMember, this.surveyor});

  ConfirmationStatus.fromJson(Map<String, dynamic> json) {
    ctucMember = json['ctuc_member'];
    surveyor = json['surveyor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ctuc_member'] = this.ctucMember;
    data['surveyor'] = this.surveyor;
    return data;
  }
}

