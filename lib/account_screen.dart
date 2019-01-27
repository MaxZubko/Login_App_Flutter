import 'package:flutter/material.dart';
import 'package:login_program/Widgets/account_image_widget.dart';
import 'package:login_program/Widgets/drop_down_list_countries.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  String countries;
  String selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Your account"), backgroundColor: Colors.blueGrey[900]),
      body: Container(
        color: Colors.blueGrey[800],
        child: ListView(
          children: <Widget>[
            AccountImage(),
            ListTile(
                leading: Icon(Icons.account_box, color: Colors.white),
                title: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.white)),
                )),
            ListTile(
              leading: Icon(Icons.email, color: Colors.white),
              title: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            ListTile(
              leading: Icon(Icons.language, color: Colors.white),
              title: DropDownCountries(),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Material(
                color: Colors.blue[700],
                elevation: 3.0,
                child: MaterialButton(
                  height: 45.0,
                  child: Text("Save", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/home_screen');
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
