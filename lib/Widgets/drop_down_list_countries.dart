import 'package:flutter/material.dart';
import 'package:login_program/countries_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class DropDownCountries extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DropDownCountriesState();
}

class DropDownCountriesState extends State<DropDownCountries> {
  static const menuItems = countriesList;

  final List<DropdownMenuItem<String>> dropDownItems = menuItems
      .map(
        (String value) =>
            DropdownMenuItem<String>(value: value, child: Text(value)),
      )
      .toList();

  String _selectedVal;

  @override
  Widget build(BuildContext contex) {
    return DropdownButton(
      hint: Text('Choose your country', style: TextStyle(color: Colors.white)),
      items: dropDownItems,
      value: _selectedVal,
      onChanged: ((String newValue) {
        setState(() {
          _selectedVal = newValue;
        });
      }),
    );
  }
}

Future<List<DropdownMenuItem<String>>> getCountries(BuildContext contex) async {
  var data =
      await http.get("http://easyautocomplete.com/resources/countries.json");
  var jsonData = json.decode(data.body);

  List<DropdownMenuItem<String>> listDrops = [];

  for (var i in jsonData) {
    listDrops.add(DropdownMenuItem(
      child: Row(children: <Widget>[
        Text(i["name"].toString(), style: TextStyle(color: Colors.white))
      ]),
      value: i["name"],
    ));
  }
  return listDrops;
}
