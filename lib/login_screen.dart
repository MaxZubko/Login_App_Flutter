import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  bool _obscureText = true;
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 150.0),
              child: Form(
                key: _formKey,
                autovalidate: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'img/img_login.png',
                      width: 50,
                      height: 50,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 0.0),
                        child: TextFormField(
                          // controller: email,
                          validator: (input) {
                            if(input.isEmpty) {
                              return 'Please type an email';
                            }
                          },
                          onSaved: (input) => _email = input,
                          decoration: InputDecoration(
                              icon: Padding(
                                padding: EdgeInsets.only(top: 15.0),
                                child: Icon(Icons.email),
                              ),
                              fillColor: Colors.white,
                              labelText: 'Email'),
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 0.0),
                        child: TextFormField(
                          //controller: password,
                          validator: (input) {
                            if(input.length < 6) {
                              return 'Your password needs to be atleast 6 characters';
                            }
                          },
                          onSaved: (input) => _password = input,
                          obscureText: _obscureText,
                          maxLength: 6,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            icon: Padding(
                                padding: EdgeInsets.only(top: 15.0), child: Icon(Icons.lock)),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText ? Icons.visibility : Icons.visibility_off,
                                semanticLabel: _obscureText ? 'show password' : 'hide password',
                              ),
                            ),
                          ),
                        ) 
                        ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    ButtonTheme(
                      minWidth: 300.0,
                      height: 38.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: Colors.blue[600],
                        splashColor: Colors.blue[300],
                        textColor: Colors.white,
                        child: Text('Login'),
                        onPressed: () async { 
                          signIn();
                          sharedPreferences = await SharedPreferences.getInstance();
                          sharedPreferences.setString("email", _email);
                        }),
                    ),
                    ButtonTheme(
                        minWidth: 300.0,
                        height: 38.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: Colors.red[600],
                          splashColor: Colors.red[300],
                          textColor: Colors.white,
                          child: Text('Register'),
                          onPressed: () async {
                            signUp();
                            sharedPreferences = await SharedPreferences.getInstance();
                            sharedPreferences.setString("email", _email);
                          }
                        )),
                    ButtonTheme(
                      minWidth: 300.0,
                      height: 38.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                        color: Colors.green,
                        child:
                          Text('Login with Google', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          _signInGoogle().then((FirebaseUser user){
                              print(user);
                            }).catchError((onError){
                              print(onError);
                           }); 
                        }, 
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(60),
                    ),
                    FlatButton(
                        child: Text('Forgot passwor?'),
                        splashColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SecondScreen()));
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if(formState.validate()) {
      formState.save();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.of(context).pushReplacementNamed('/home_screen'); 
      }catch(e){
        print(e.message);
      }
    }
  }

  Future<void> signUp() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.of(context).pushReplacementNamed('/home_screen');
      } catch(e) {
        print(e.message);
      }
    }
  }

  Future<FirebaseUser> _signInGoogle() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSa =await googleSignInAccount.authentication;

    await _auth.signInWithGoogle(
      idToken: gSa.idToken,
      accessToken: gSa.accessToken
    );
      return Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("More"),
        ),
        body: Text("Go back!"));
  }
}