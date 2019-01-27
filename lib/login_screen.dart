import 'package:flutter/material.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  int _state = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 150.0),
              child: Form(
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
                        child: PasswordField(
                          helperText: 'No more than 8 characters',
                          labelText: 'Password',
                        )),
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
                        child: setUpButtonChild(),
                        onPressed: () async {
                          setState(() {
                            if (_state == 0) {
                              animatedButton();
                            }
                          });
                          await Future.delayed(Duration(seconds: 3));
                          Navigator.of(context)
                              .pushReplacementNamed('/home_screen');
                        },
                      ),
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
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SecondScreen()));
                          },
                        )),
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

  Widget setUpButtonChild() {
    if (_state == 0) {
      return Text('Login');
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 4.0,
      );
    }
  }

  void animatedButton() {
    setState(() {
      _state = 1;
    });
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

class PasswordField extends StatefulWidget {
  PasswordField({
    this.labelText,
    this.helperText,
  });

  final String labelText;
  final String helperText;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      maxLength: 8,
      decoration: InputDecoration(
        labelText: widget.labelText,
        helperText: widget.helperText,
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
    );
  }
}
