import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'account_screen.dart';
import 'home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:login_program/tickets/tickets_bloc.dart';
import 'package:login_program/blocs/bloc_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      home: AuthStatus(),
      theme: ThemeData(
          primarySwatch: Colors.blueGrey, brightness: Brightness.dark),
      routes: <String, WidgetBuilder>{
        '/login_screen': (BuildContext context) => LoginScreen(),
        '/home_screen': (BuildContext context) => BlocProvider<TicketsBloc>(child: HomeScreen(), bloc: TicketsBloc()),
        '/account_screen': (BuildContext context) => AccountScreen(),
        '/second_screen': (BuildContext context) => SecondScreen(),
      },
    );
  }
}

class AuthStatus extends StatefulWidget {
  @override
  AuthStatusState createState() => AuthStatusState();
}

class AuthStatusState extends State<AuthStatus> {
  SharedPreferences sharedPreferences;
  String value;

  @override
  void initState() {
    super.initState();
    auth();
  }

  auth() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      value = sharedPreferences.getString("email");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return LoginScreen();
      // BlocProvider<TicketsBloc>(child: LoginScreen(), bloc: TicketsBloc());
    } else {
      return BlocProvider<TicketsBloc>(child: HomeScreen(), bloc: TicketsBloc());
    }
  }
}

// class AuthStatus extends StatelessWidget {
//   @override
  // Widget build(BuildContext context) {
  //   checkIfAuthenticated().then((success) {
  //     if (success) {
  //       Navigator.pushReplacementNamed(context, '/home_screen');
  //     } else {
  //       Navigator.pushReplacementNamed(context, '/login_screen');
  //     }
  //   });
  //   return Center(child: CircularProgressIndicator());
  // }
// }