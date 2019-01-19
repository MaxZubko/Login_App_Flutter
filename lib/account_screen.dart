import 'package:flutter/material.dart';
import 'package:login_program/Widgets/account_image_widget.dart';
import 'package:login_program/Widgets/drop_down_list_countries.dart';
import 'home_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  
String selected;

  @override
  Widget build(BuildContext context) {
  
  //final Size screenSize = MediaQuery.of(context).size;
   
    return Scaffold(
      appBar: AppBar(title: Text("Your account")),
      body: Container(
        margin: EdgeInsets.all(1.0),
        child: ListView(
          //shrinkWrap: true,
          children: <Widget>[
            AccountImage(),
            ListTile(
              leading: Icon(Icons.account_box),
              title: TextField(
                decoration: InputDecoration(
                  hintText: "Name"
                ),
              )
            ),
            ListTile(
             leading: Icon(Icons.email),
             title: TextField(
               decoration: InputDecoration(
                 hintText: "Email"
               ),
               keyboardType: TextInputType.emailAddress,
             ),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: DropDownCountries(),
            ),
            Container(
              //width: screenSize.width,
              padding: EdgeInsets.all(15.0),
              child: Material(
                color: Colors.orange[600],
                elevation: 3.0,
                child: MaterialButton(
                  height: 45.0,
                  child: Text("Save", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                  
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
