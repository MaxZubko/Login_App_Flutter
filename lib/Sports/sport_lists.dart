import 'package:flutter/material.dart';
import 'package:login_program/Sports/sport_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SportList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SportListState();
}

class SportListState extends State<SportList> {
  final String url = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php";
  List data;

  @override
  void initState() {
    this.getSportList();
  }

  Future<String> getSportList() async {
    var response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    print(response.body);

    setState(() {
      var dataJson = json.decode(response.body);
      data = dataJson["sports"];
    });
    return "Successfull";
  }
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        color: Colors.blueGrey[800],
        child:ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 8.0,
                margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.blueGrey[900]),
                  child: ListTile(
                    title: Text(
                    data[index]["strSport"], 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    leading: Image.network(
                      data[index]["strSportThumb"],
                      width: 100,
                      ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right, color: Colors.white, size: 30.0
                      ),
                    onTap: () {
                      Navigator.push(
                          context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                SportInfo(data[index])));
                },
              )
                ),
              );
              
            })));
  }
}