import 'package:flutter/material.dart';
import 'package:login_program/countries_list.dart';

class DropDownCountries extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DropDownCountriesState();
}

class DropDownCountriesState extends State<DropDownCountries> {
  static const menuItems = countriesList;

  final List<DropdownMenuItem<String>> dropDownItems = menuItems
    .map(
      (String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value)),
  ).toList();

  String _selectedVal;

  @override
  Widget build(BuildContext contex) {
    return  DropdownButton(
          hint: Text('Choose your country'),
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
