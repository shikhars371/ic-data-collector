import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kapp/pages/safaribooklet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './buildinginfo.dart';

class TypePropertyUserPage extends StatefulWidget {
  TypePropertyUserPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _TypePropertyUserPageState createState() => _TypePropertyUserPageState();
}

class _TypePropertyUserPageState extends State<TypePropertyUserPage> {
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
          if (localdata.isdrafted != 2) {
            await DBHelper()
                .updatePropertySurvey(localdata, localdata.local_property_key);
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => BuildingInfoPage(
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
              setapptext(key: 'key_next'),
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
            builder: (BuildContext context) => SafariBookletPage(
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
              setapptext(key: 'key_back'),
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
          setapptext(key: 'key_property_survey'),
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
                        formheader(headerlablekey: 'key_prop_info'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formCardDropdown(
                                value: localdata.property_user_owner?.isEmpty ??
                                        true
                                    ? "0"
                                    : localdata.property_user_owner,
                                iscompleted: ((localdata
                                                .property_user_owner?.isEmpty ??
                                            true) ||
                                        (localdata.property_user_owner == "0"))
                                    ? false
                                    : true,
                                headerlablekey:
                                    setapptext(key: 'key_the_owner'),
                                dropdownitems: [
                                  Dpvalue(
                                      name:
                                          setapptext(key: 'key_none_selected'),
                                      value: "0"),
                                  Dpvalue(
                                      name: setapptext(key: 'key_yes_sir'),
                                      value: "1"),
                                  Dpvalue(
                                      name: setapptext(key: 'key_no'),
                                      value: "2")
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
                                value: localdata.property_user_master_rent
                                            ?.isEmpty ??
                                        true
                                    ? "0"
                                    : localdata.property_user_master_rent,
                                iscompleted: ((localdata
                                                .property_user_master_rent
                                                ?.isEmpty ??
                                            true) ||
                                        (localdata.property_user_master_rent ==
                                            "0"))
                                    ? false
                                    : true,
                                headerlablekey:
                                    setapptext(key: 'key_Master_rent'),
                                dropdownitems: [
                                  Dpvalue(
                                      name:
                                          setapptext(key: 'key_none_selected'),
                                      value: "0"),
                                  Dpvalue(
                                      name: setapptext(key: 'key_yes_sir'),
                                      value: "1"),
                                  Dpvalue(
                                      name: setapptext(key: 'key_no'),
                                      value: "2")
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
                                value: localdata.property_user_recipient_group
                                            ?.isEmpty ??
                                        true
                                    ? "0"
                                    : localdata.property_user_recipient_group,
                                iscompleted: ((localdata
                                                .property_user_recipient_group
                                                ?.isEmpty ??
                                            true) ||
                                        (localdata
                                                .property_user_recipient_group ==
                                            "0"))
                                    ? false
                                    : true,
                                headerlablekey:
                                    setapptext(key: 'key_master_recipient'),
                                dropdownitems: [
                                  Dpvalue(
                                      name:
                                          setapptext(key: 'key_none_selected'),
                                      value: "0"),
                                  Dpvalue(
                                      name: setapptext(key: 'key_yes_sir'),
                                      value: "1"),
                                  Dpvalue(
                                      name: setapptext(key: 'key_no'),
                                      value: "2")
                                ],
                                onSaved: (String value) {
                                  localdata.property_user_recipient_group =
                                      value;
                                },
                                onChanged: (value) {
                                  localdata.property_user_recipient_group =
                                      value;
                                  setState(() {});
                                },
                              ),
                              formCardDropdown(
                                value: localdata
                                            .property_user_no_longer?.isEmpty ??
                                        true
                                    ? "0"
                                    : localdata.property_user_no_longer,
                                iscompleted: ((localdata.property_user_no_longer
                                                ?.isEmpty ??
                                            true) ||
                                        (localdata.property_user_no_longer ==
                                            "0"))
                                    ? false
                                    : true,
                                headerlablekey:
                                    setapptext(key: 'key_master_no_longer'),
                                dropdownitems: [
                                  Dpvalue(
                                      name:
                                          setapptext(key: 'key_none_selected'),
                                      value: "0"),
                                  Dpvalue(
                                      name: setapptext(key: 'key_yes_sir'),
                                      value: "1"),
                                  Dpvalue(
                                      name: setapptext(key: 'key_no'),
                                      value: "2")
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
                                    initvalue: localdata
                                                .property_user_type_of_misconduct
                                                ?.isEmpty ??
                                            true
                                        ? ""
                                        : localdata
                                            .property_user_type_of_misconduct,
                                    headerlablekey: setapptext(
                                        key: 'key_specify_misconduct'),
                                    radiovalue: localdata
                                                .property_user_type_of_misconduct
                                                ?.isEmpty ??
                                            true
                                        ? false
                                        : true,
                                    hinttextkey: setapptext(
                                        key: 'key_enter_1st_surveyor'),
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return setapptext(
                                            key: 'key_field_not_blank');
                                      }
                                    },
                                    onSaved: (value) {
                                      localdata
                                              .property_user_type_of_misconduct =
                                          value.trim();
                                    },
                                    onChanged: (value) {
                                      localdata
                                              .property_user_type_of_misconduct =
                                          value.trim();
                                      setState(() {});
                                    }),
                              ]

                              //if yes
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
}
