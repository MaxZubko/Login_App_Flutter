import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:login_program/Widgets/account_image_widget.dart';
import 'package:login_program/Widgets/drop_down_list_countries.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String countries;
  String selected;
  SharedPreferences sharedPreferences;
  String _name, _email;
  final db = Firestore.instance;

  @override
  void initState() {
    super.initState();
    getDataPreference();
  }

  getDataPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _email = sharedPreferences.getString("email");
    });
  }

  // void updateData() async {
  //   Firestore.instance
  //     .collection('users')
  //     .document(userID)
  //     .updateData({
  //       'email': '$_email', 'name': '$_name'
  //     });
  // }

  // void updateData(DocumentSnapshot doc) async {
  //   await db.collection('users').document(doc.documentID).updateData({'email': '$_email', 'name': '$_name'});
  //   Navigator.of(context).pushReplacementNamed('/home_screen');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Your account"), backgroundColor: Colors.blueGrey[900]),
      body: Container(
          color: Colors.blueGrey[800],
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                AccountImage(),
                ListTile(
                    leading: Icon(Icons.account_box, color: Colors.white),
                    title: TextFormField(
                      onSaved: (input) => _name = input,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: "Name",
                          hintStyle: TextStyle(color: Colors.white)),
                    )),
                ListTile(
                  leading: Icon(Icons.email, color: Colors.white),
                  title: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white)),
                    // keyboardType: TextInputType.emailAddress,
                    initialValue: _email,
                    onSaved: (input) => _email = input,
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
                        child:
                            Text("Save", style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          // updateData();
                          Navigator.of(context)
                              .pushReplacementNamed('/home_screen');
                        }),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
