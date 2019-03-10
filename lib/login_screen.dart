import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool _obscureText = true;
  String _email, _password, id;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin fbLogin = FacebookLogin();
  SharedPreferences sharedPreferences;
  final db = Firestore.instance;
  // bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
  }

  Widget LoginScreen() {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image(
          image: AssetImage('img/sport.jpg'),
          fit: BoxFit.cover,
          color: Colors.black87,
          colorBlendMode: BlendMode.darken,
        ),
        Column(children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 150.0),
            child: Center(
                child: Icon(Icons.stars, color: Colors.white, size: 60.0)),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Awesome',
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
                Text(
                  'App',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            // width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 100),
            // alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.black87,
                    highlightedBorderColor: Colors.white,
                    onPressed: () {
                      gotoSignup();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'SIGN UP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () {
                      gotoLogin();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'LOGIN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ])
      ],
    ));
  }

  Widget LoginPage() {
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.05), BlendMode.dstATop),
                  image: AssetImage('img/sport.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 90.0),
                      child: Center(
                        child: Icon(
                          Icons.stars,
                          color: Colors.black,
                          size: 60.0,
                        ),
                      ),
                    ),
                    Row(children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 40, top: 30.0),
                          child: Text('Email',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0)),
                        ),
                      )
                    ]),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black.withOpacity(0.5), width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            child: Icon(
                              Icons.person_outline,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            height: 30.0,
                            width: 1.0,
                            color: Colors.black.withOpacity(0.5),
                            margin: EdgeInsets.only(right: 10.0),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              // validator: Validator.validateEmail,
                              // controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              autofocus: false,
                              onSaved: (input) => _email = input,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Text(
                            'Password',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                          ),
                        ),
                      )
                    ]),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            child: Icon(
                              Icons.lock_open,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            height: 30.0,
                            width: 1.0,
                            color: Colors.black.withOpacity(0.5),
                            margin: EdgeInsets.only(right: 10.0),
                          ),
                          Expanded(
                            child: TextFormField(
                              // onSaved: (input) => _password = input,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(color: Colors.grey),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    semanticLabel: _obscureText
                                        ? 'show password'
                                        : 'hide password',
                                  ),
                                ),
                              ),
                              autofocus: false,
                              // controller: _password,
                              // validator: Validator.validatePassword,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: FlatButton(
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 15.0,
                              ),
                              textAlign: TextAlign.end,
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              color: Colors.blue,
                              onPressed: () {},
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Transform.translate(
                                    offset: Offset(10.0, 0.0),
                                    child: Container(
                                      padding: EdgeInsets.all(1.0),
                                      child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(28.0)),
                                        color: Colors.white,
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () async {
                                          sigIn();
                                          sharedPreferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          sharedPreferences.setString(
                                              "email", _email);
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                      alignment: Alignment.center,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.25)),
                            ),
                          ),
                          Text(
                            'OR CONNECT WITH',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.25)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 8.0),
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      color: Color(0Xff3B5998),
                                      onPressed: () {},
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: FlatButton(
                                                  onPressed: () {
                                                    login();
                                                  },
                                                  padding: EdgeInsets.only(
                                                      top: 15.0, bottom: 20.0),
                                                  child: Text(
                                                    'FACEBOOK',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 8.0),
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Color(0Xffdb3236),
                                    onPressed: () {},
                                    child: Container(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: FlatButton(
                                            onPressed: () {
                                              _signInGoogle()
                                                  .then((FirebaseUser user) {
                                                print(user);
                                              }).catchError((onError) {
                                                print(onError);
                                              });
                                            },
                                            padding: EdgeInsets.only(
                                                top: 15.0, bottom: 20.0),
                                            child: Text(
                                              'GOOGLE',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                  ))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  Widget SignupPage() {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.05), BlendMode.dstATop),
              image: AssetImage('img/sport.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 90.0),
                  child: Center(
                    child: Icon(
                      Icons.stars,
                      color: Colors.black,
                      size: 60.0,
                    ),
                  ),
                ),
                Row(children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 40.0, top: 30.0),
                    child: Text('Email',
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  ))
                ]),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black.withOpacity(0.5), width: 1.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 30.0,
                        width: 1.0,
                        color: Colors.black.withOpacity(0.5),
                        margin: EdgeInsets.only(right: 10.0),
                      ),
                      Expanded(
                        child: TextFormField(
                          autofocus: false,
                          // controller: _email,
                          // validator: Validator.validateEmail,
                          onSaved: (input) => _email = input,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 40.0),
                        child: Text(
                          'Password',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(0.5),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: Icon(
                          Icons.lock_open,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 30.0,
                        width: 1.0,
                        color: Colors.black.withOpacity(0.5),
                        margin: EdgeInsets.only(right: 10.0),
                      ),
                      Expanded(
                        child: TextFormField(
                          autofocus: false,
                          // controller: _password,
                          // validator: Validator.validatePassword,
                          onSaved: (input) => _password = input,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(color: Colors.grey),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                semanticLabel: _obscureText
                                    ? 'show password'
                                    : 'hide password',
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 40.0),
                        child: Text(
                          'Confirm password',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(0.5),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: Icon(
                          Icons.lock_open,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 30.0,
                        width: 1.0,
                        color: Colors.black.withOpacity(0.5),
                        margin: EdgeInsets.only(right: 10.0),
                      ),
                      Expanded(
                        child: TextFormField(
                          // onSaved: (input) => _password = input,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: FlatButton(
                        child: Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.blue,
                          onPressed: () {},
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'SIGN UP',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Transform.translate(
                                offset: Offset(10.0, 0.0),
                                child: Container(
                                  padding: EdgeInsets.all(1.0),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(28.0)),
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () async {
                                      createData();
                                      signUp();
                                      sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      sharedPreferences.setString(
                                          "email", _email);
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sigIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.of(context).pushReplacementNamed('/home_screen');
      } catch (e) {
        print(e.message);
      }
    }
  }

  Future<void> signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        Navigator.of(context).pushReplacementNamed('/home_screen');
      } catch (e) {
        print(e.message);
      }
    }
  }

  Future<FirebaseUser> _signInGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSa = await googleSignInAccount.authentication;

    await _auth.signInWithGoogle(
        idToken: gSa.idToken, accessToken: gSa.accessToken);
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  login() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        print(result.accessToken.token);
        Navigator.of(context).pushReplacementNamed('/home_screen');
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('CANCELED BY USER');
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }
  }

  void createData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref = await db
          .collection('users')
          .add({'email': '$_email', 'name': 'UserName', 'userPhotoURL': 'url'});
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }
  }

  gotoLogin() {
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  PageController _controller =
      PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: PageView(
        controller: _controller,
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[LoginPage(), LoginScreen(), SignupPage()],
        scrollDirection: Axis.horizontal,
      ),
    );
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
