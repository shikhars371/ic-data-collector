import 'package:flutter/material.dart';

class Dpvalue {
  String name;
  String value;
  Dpvalue({this.name, this.value});
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
    FocusNode fieldfocus,
    TextInputAction textInputAction,
    void Function(String) onFieldSubmitted,
    Widget suffix,
    bool enable}) {
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
          border: Border.all(color: Color.fromRGBO(176, 174, 171, 1), width: 1),
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
                    headerlablekey,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    maxLines: 2,
                    style: TextStyle(),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
              child: TextFormField(
                enabled: enable,
                keyboardType: keyboardtype,
                initialValue: initvalue?.isEmpty ?? true ? "" : initvalue,
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.redAccent),
                  suffixIcon: suffix,
                  hintText: hinttextkey?.isEmpty ?? true ? "" : hinttextkey,
                ),
                onSaved: onSaved,
                validator: validator,
                onChanged: onChanged,
                focusNode: fieldfocus,
                textInputAction: textInputAction,
                onFieldSubmitted: onFieldSubmitted,
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
    FocusNode fieldfocus,
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
          border: Border.all(color: Color.fromRGBO(176, 174, 171, 1), width: 1),
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
                    headerlablekey,
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
