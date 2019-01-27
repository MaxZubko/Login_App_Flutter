import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'account_screen.dart';
import 'home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      theme: ThemeData(
          primarySwatch: Colors.blueGrey, brightness: Brightness.dark),
      routes: <String, WidgetBuilder>{
        '/login_screen': (BuildContext context) => LoginScreen(),
        '/home_screen': (BuildContext context) => HomeScreen(),
        '/account_screen': (BuildContext context) => AccountScreen(),
        '/second_screen': (BuildContext context) => SecondScreen(),
      },
    );
  }
}
