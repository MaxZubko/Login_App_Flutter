import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<List<DropdownMenuItem<String>>> getSports(BuildContext context) async {
  var data = await http
      .get("https://www.thesportsdb.com/api/v1/json/1/all_sports.php");
  var jsonData = json.decode(data.body);

  List<DropdownMenuItem<String>> listDrops = [];

  for (var i in jsonData["sports"]) {
    listDrops.add(DropdownMenuItem(
      child: Row(children: <Widget>[
        Text(i["strSport"].toString(), style: TextStyle(color: Colors.white)),
      ]),
      value: i["strSport"],
    ));
  }
  return listDrops;
}
