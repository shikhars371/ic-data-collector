import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './propertydetails.dart';
import './physicalstate.dart';

class PropertyLocationPage extends StatefulWidget {
  PropertyLocationPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _PropertyLocationPageState createState() => _PropertyLocationPageState();
}

class _PropertyLocationPageState extends State<PropertyLocationPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();

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
          //in edit mode
          if (localdata.editmode == 1) {
            await DBHelper()
                .updatePropertySurvey(localdata, localdata.local_property_key);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => PropertyDetailsPage(
                  localdata: localdata,
                ),
              ),
            );
          } else {
            localdata.editmode = 1;
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
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => PropertyDetailsPage(
                    localdata: localdata,
                  ),
                ),
              );
            }
          }
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
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => PhysicalStatePropertyPage(
              localdata: localdata,
            ),
          ),
        );
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
                          formheader(headerlablekey: 'key_property_location'),
                          //body
                          Expanded(
                            child: ListView(
                              children: <Widget>[
                                formCardDropdown(
                                    iscompleted:
                                        ((localdata.province?.isEmpty ??
                                                    true) ||
                                                (localdata.province == "0"))
                                            ? false
                                            : true,
                                    headerlablekey:
                                        setapptext(key: 'key_select_province'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_kabul'),
                                          value: "01-01"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_nangarhar'),
                                          value: "06-01"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Kandahar'),
                                          value: "33-01"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Bamyan'),
                                          value: "10-01"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Daikundi'),
                                          value: "22-01"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Kundoz'),
                                          value: "17-01"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Balkh'),
                                          value: "18-01"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Herat'),
                                          value: "30-01"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Parwan'),
                                          value: "03-01"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Farah'),
                                          value: "04-01")
                                    ],
                                    onChanged: (value) {
                                      localdata.province = value;
                                      setState(() {});
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
                                        ((localdata.city?.isEmpty ?? true) ||
                                                (localdata.city == "0"))
                                            ? false
                                            : true,
                                    headerlablekey:
                                        setapptext(key: 'key_select_city'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_kabul'),
                                          value: "1"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_Jalalabad'),
                                          value: "2"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Kandahar'),
                                          value: "3"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Bamyan'),
                                          value: "4"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Nili'),
                                          value: "5"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Kundoz'),
                                          value: "6"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Sharif'),
                                          value: "7"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Herat'),
                                          value: "8"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Charikar'),
                                          value: "9"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_Farah'),
                                          value: "10")
                                    ],
                                    onChanged: (value) {
                                      localdata.city = value;

                                      setState(() {});
                                    },
                                    onSaved: (value) {
                                      localdata.city = value;
                                    },
                                    value: localdata.city?.isEmpty ?? true
                                        ? "0"
                                        : localdata.city,
                                    validate: (value) {
                                      if ((value.isEmpty) || value == "0") {
                                        return "required";
                                      }
                                    }),
                                formcardtextfield(
                                    keyboardtype: TextInputType.number,
                                    headerlablekey: setapptext(key: 'key_area'),
                                    radiovalue: localdata.area?.isEmpty ?? true
                                        ? false
                                        : true,
                                    hinttextkey:
                                        setapptext(key: 'Key_number_value'),
                                    initvalue: localdata.area?.isEmpty ?? true
                                        ? ""
                                        : localdata.area,
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return "field should not be blank";
                                      } else if (value.length != 2) {
                                        return "Should be two digit";
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
                                    initvalue: localdata.pass?.isEmpty ?? true
                                        ? ""
                                        : localdata.pass,
                                    headerlablekey: setapptext(key: 'key_pass'),
                                    hinttextkey:
                                        setapptext(key: 'Key_number_value'),
                                    radiovalue: localdata.pass?.isEmpty ?? true
                                        ? false
                                        : true,
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return "field should not be blank";
                                      } else if (value.length != 2) {
                                        return "Should be two digits";
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
                                    initvalue: localdata.block?.isEmpty ?? true
                                        ? ""
                                        : localdata.block,
                                    headerlablekey:
                                        setapptext(key: 'key_block'),
                                    radiovalue: localdata.block?.isEmpty ?? true
                                        ? false
                                        : true,
                                    hinttextkey:
                                        setapptext(key: 'Key_number_value'),
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return "field should not be blank";
                                      } else if (value.length != 3) {
                                        return "Should be three digit";
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
                                    initvalue:
                                        localdata.part_number?.isEmpty ?? true
                                            ? ""
                                            : localdata.part_number,
                                    headerlablekey:
                                        setapptext(key: 'key_part_number'),
                                    radiovalue:
                                        localdata.part_number?.isEmpty ?? true
                                            ? false
                                            : true,
                                    hinttextkey:
                                        setapptext(key: 'Key_number_value'),
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return "field should not be blank";
                                      } else if (value.length != 3) {
                                        return "Should be three digit";
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
                                    initvalue:
                                        localdata.unit_number?.isEmpty ?? true
                                            ? ""
                                            : localdata.unit_number,
                                    headerlablekey:
                                        setapptext(key: 'key_unit_number'),
                                    radiovalue:
                                        localdata.unit_number?.isEmpty ?? true
                                            ? false
                                            : true,
                                    hinttextkey:
                                        setapptext(key: 'Key_number_value'),
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return "field should not be blank";
                                      } else if (value.length != 3) {
                                        return "Should be three digit";
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
                                    initvalue:
                                        localdata.unit_in_parcel?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.unit_in_parcel,
                                    keyboardtype: TextInputType.number,
                                    headerlablekey:
                                        setapptext(key: 'key_number_of_unit'),
                                    radiovalue:
                                        localdata.unit_in_parcel?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    hinttextkey:
                                        setapptext(key: 'Key_number_value'),
                                    onSaved: (value) {
                                      localdata.unit_in_parcel = value.trim();
                                    },
                                    onChanged: (value) {
                                      localdata.unit_in_parcel = value.trim();
                                      setState(() {});
                                    }),
                                formcardtextfield(
                                    initvalue:
                                        localdata.street_name?.isEmpty ?? true
                                            ? ""
                                            : localdata.street_name,
                                    headerlablekey:
                                        setapptext(key: 'key_state_name'),
                                    radiovalue:
                                        localdata.street_name?.isEmpty ?? true
                                            ? false
                                            : true,
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
                                    initvalue:
                                        localdata.historic_site_area?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.historic_site_area,
                                    headerlablekey:
                                        setapptext(key: 'key_historycal_site'),
                                    radiovalue:
                                        localdata.historic_site_area?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    hinttextkey: setapptext(
                                        key: 'key_enter_1st_surveyor'),
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
                                    initvalue:
                                        localdata.land_area?.isEmpty ?? true
                                            ? ""
                                            : localdata.land_area,
                                    keyboardtype: TextInputType.number,
                                    headerlablekey:
                                        setapptext(key: 'key_land_area'),
                                    radiovalue:
                                        localdata.land_area?.isEmpty ?? true
                                            ? false
                                            : true,
                                    hinttextkey:
                                        setapptext(key: 'Key_number_value'),
                                    onSaved: (value) {
                                      localdata.land_area = value.trim();
                                    },
                                    onChanged: (value) {
                                      localdata.land_area = value.trim();
                                      setState(() {});
                                    }),
                                formCardDropdown(
                                    value:
                                        localdata.property_type?.isEmpty ?? true
                                            ? "0"
                                            : localdata.property_type,
                                    iscompleted: ((localdata
                                                    .property_type?.isEmpty ??
                                                true) ||
                                            (localdata.property_type == "0"))
                                        ? false
                                        : true,
                                    headerlablekey:
                                        setapptext(key: 'key_type_ownership'),
                                    dropdownitems: [
                                      Dpvalue(
                                          name: setapptext(
                                              key: 'key_none_selected'),
                                          value: "0"),
                                      Dpvalue(
                                          name: setapptext(key: 'key_solo'),
                                          value: "1"),
                                      Dpvalue(
                                          name:
                                              setapptext(key: 'key_collective'),
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
                                        return "required";
                                      }
                                    }),
                                SizedBox(
                                  height: 50,
                                )
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
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
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
        ));
  }
}
