import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';
import 'package:login_program/model/team.dart';

class TeamInfo extends StatelessWidget {
  final Team _team;

  TeamInfo(this._team);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(_team.teamName), backgroundColor: Colors.blueGrey[900]),
        body: Container(
            color: Colors.blueGrey[800],
            alignment: Alignment.center,
            child: ListView(children: <Widget>[
              Column(children: <Widget>[
                SizedBox(height: 10),
                SizedBox(
                    height: 200.0,
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: <
                            Widget>[
                      Row(children: <Widget>[
                        Hero(
                            tag: 'imageTeamHero${_team.teamName}',
                            child: Image.network(_team.picture, width: 130)),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _team.website.length != 0
                                  ? Row(children: <Widget>[
                                      Image.asset("img/web.png", width: 20),
                                      FlatButton(
                                          onPressed: () {
                                            loadWebSite(_team.website);
                                          },
                                          child: Text(_team.website,
                                              style: TextStyle(fontSize: 14)))
                                    ])
                                  : SizedBox(height: 0),
                              _team.instagtam.length != 0
                                  ? Row(children: <Widget>[
                                      Image.asset("img/instagram.png",
                                          width: 20),
                                      FlatButton(
                                          onPressed: () {
                                            loadWebSite(_team.instagtam);
                                          },
                                          child: Text(_team.instagtam,
                                              style: TextStyle(fontSize: 14)))
                                    ])
                                  : SizedBox(height: 0),
                              _team.facebook.length != 0
                                  ? Row(children: <Widget>[
                                      Image.asset("img/facebook.png",
                                          width: 20),
                                      FlatButton(
                                          onPressed: () {
                                            loadWebSite(_team.facebook);
                                          },
                                          child: Text(_team.facebook,
                                              style: TextStyle(fontSize: 14)))
                                    ])
                                  : SizedBox(height: 0),
                              _team.youtube.length != 0
                                  ? Row(children: <Widget>[
                                      Image.asset("img/youtube.png", width: 20),
                                      FlatButton(
                                          onPressed: () {
                                            loadWebSite(_team.youtube);
                                          },
                                          child: Text(_team.youtube,
                                              style: TextStyle(fontSize: 14)))
                                    ])
                                  : SizedBox(height: 0),
                            ])
                      ])
                    ])),
                SizedBox(height: 10),
                Text(
                  _team.teamName,
                  style: TextStyle(fontSize: 30),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Text(_team.teamDescription,
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.justify)),
              ])
            ])));
  }

  void loadWebSite(String url) async {
    if (await canLaunch("http://$url")) {
      await launch("http://$url");
    } else {
      throw 'Could not launch $url';
    }
  }
}
