import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './businesslicense.dart';
import './docverification.dart';
import './firstpartnerinfo.dart';

class TypeOfUsePage extends StatefulWidget {
  TypeOfUsePage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _TypeOfUsePageState createState() => _TypeOfUsePageState();
}

class _TypeOfUsePageState extends State<TypeOfUsePage> {
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
          await DBHelper()
              .updatePropertySurvey(localdata, localdata.local_property_key);
          if ((localdata.current_use_of_property == "2") ||
              (localdata.current_use_of_property == "3")) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BusinessLicensePage(
                  localdata: localdata,
                ),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => FirstPartnerPage(
                  localdata: localdata,
                ),
              ),
            );
          }
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
            builder: (BuildContext context) => DocVerificationPage(
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
                        formheader(headerlablekey: 'key_type_of_use'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formCardDropdown(
                                  value:
                                      localdata.use_in_property_doc?.isEmpty ??
                                              true
                                          ? "0"
                                          : localdata.use_in_property_doc,
                                  iscompleted: ((localdata.use_in_property_doc
                                                  ?.isEmpty ??
                                              true) ||
                                          (localdata.use_in_property_doc ==
                                              "0"))
                                      ? false
                                      : true,
                                  headerlablekey:
                                      setapptext(key: 'key_Type_of_use'),
                                  dropdownitems: [
                                    Dpvalue(
                                        name: setapptext(
                                            key: 'key_none_selected'),
                                        value: "0"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_release'),
                                        value: "1"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_commercial'),
                                        value: "2"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_complex'),
                                        value: "3"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_productive'),
                                        value: "4"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_govt'),
                                        value: "5"),
                                    Dpvalue(
                                        name:
                                            setapptext(key: 'key_agriculture'),
                                        value: "6"),
                                    Dpvalue(
                                        name:
                                            setapptext(key: 'key_public_land'),
                                        value: "7"),
                                    Dpvalue(
                                        name: setapptext(key: 'key_Another'),
                                        value: "8"),
                                  ],
                                  onSaved: (value) {
                                    localdata.use_in_property_doc = value;
                                  },
                                  onChanged: (value) {
                                    localdata.use_in_property_doc = value;
                                    setState(() {});
                                  }),
                              if (localdata.use_in_property_doc == "8") ...[
                                formcardtextfield(
                                    headerlablekey:
                                        setapptext(key: 'key_Another'),
                                    radiovalue:
                                        localdata.type_of_use_other?.isEmpty ??
                                                true
                                            ? false
                                            : true,
                                    initvalue:
                                        localdata.type_of_use_other?.isEmpty ??
                                                true
                                            ? ""
                                            : localdata.type_of_use_other,
                                    onSaved: (value) {
                                      localdata.type_of_use_other =
                                          value.trim();
                                    },
                                    onChanged: (value) {
                                      localdata.type_of_use_other =
                                          value.trim();
                                      setState(() {});
                                    }),
                              ]
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
