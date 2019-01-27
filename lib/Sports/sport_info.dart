import 'package:flutter/material.dart';

class SportInfo extends StatelessWidget {
  SportInfo(this.data);

  final data;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title:  Text('More Information'),
        backgroundColor: Colors.blueGrey[900],
        ),
      body: Container(
        color: Colors.blueGrey[800],
        child: ListView(children: <Widget>[
        Column(children: <Widget>[
          SizedBox(height: 10.0),
          Container(
            child: Text(data["strSport"],
                style: TextStyle(color: Colors.white, fontSize: 32)),
          ),
          SizedBox(height: 30.0),
          Image.network(
            data["strSportThumb"],
          ),
          SizedBox(height: 30.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(data["strSportDescription"],
              style: TextStyle(fontSize: 15, color: Colors.white),
              textAlign: TextAlign.justify,
              ),
           
          ),
        ])
      ])));
}