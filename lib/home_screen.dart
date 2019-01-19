import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'account_screen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API'), actions: <Widget>[
        IconButton(
            icon: Icon(Icons.share),
            tooltip: 'Share',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondScreen()));
            }),
        IconButton(
            icon: Icon(Icons.account_circle),
            tooltip: 'Your account',
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AccountScreen()));
            }),
        IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
            }),
      ]),
      body: IistOnline(
        items: <String>[],
      ),
    );
  }
}

class IistOnline extends StatefulWidget {
  _IistOnlineState createState() => _IistOnlineState();

  final List<String> items;
  IistOnline({Key key, @required this.items,}) : super(key: key);
}

class _IistOnlineState extends State<IistOnline> {
  List data;

  Future<String> getData() async {
    final response = await http.get(
        Uri.encodeFull("https://api.myjson.com/bins/8jxuc"), headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                title: Text(data[i]['title']),
                subtitle: Text(data[i]['subtitle']),
              );
            },
          );
        }
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 160,
              height: 150,
            ),
            CircularProgressIndicator(
              strokeWidth: 5,
            ),
          ],
        );
      }
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
      body: Text("Go back!")
    );
  }
}
