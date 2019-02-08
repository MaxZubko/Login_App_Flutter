import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'google_map_screen.dart';

class AboutUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AboutUsState();
}

class AboutUsState extends State<AboutUs> {
  
  @override
  Widget build(BuildContext cntxt) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About us'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        color: Colors.blueGrey[800],
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                      child: FlatButton(
                        splashColor: Colors.blueGrey[900],
                        child: Text('We are in YouTube'),
                        onPressed: _launchURL,
                      )
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      splashColor: Colors.blueGrey[900],
                      child: Text('Map'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MyMap()));
                      },
                    ),
                  )
                ],
              ),
      ) 
      );
  }
  
  _launchURL() async {
  const url = 'https://www.youtube.com/watch?v=fq4N0hgOWzU';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
  }
}

