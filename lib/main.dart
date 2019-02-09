import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'account_screen.dart';
import 'home_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// SharedPreferences auth;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: 
      // AuthStatus(),
      LoginScreen(),
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


// class AuthStatus extends StatelessWidget {
//   @override
  
 
//   // Widget build(BuildContext context) {
//   //   checkIfAuthenticated().then((success) {
//   //     if (success) {
//   //       Navigator.pushReplacementNamed(context, '/home_screen');
//   //     } else {
//   //       Navigator.pushReplacementNamed(context, '/login_screen');
//   //     }
//   //   });
//   //   return Center(child: CircularProgressIndicator());
//   // }
// }
