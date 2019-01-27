import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_program/Leagues/teams_info.dart';
import 'package:login_program/model/team.dart';
import 'dart:convert';
import 'dart:async';

class LeagueInfo extends StatefulWidget {
  final String _idLeague;
  final String _leagueName;
  LeagueInfo(this._idLeague, this._leagueName);

  @override
  State<StatefulWidget> createState() =>
      LeagueInfoState(_idLeague, _leagueName);
}

class LeagueInfoState extends State<LeagueInfo> {
  final String _idLeague;
  final String _leagueName;
  LeagueInfoState(this._idLeague, this._leagueName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Text(_leagueName),
        ),
        body: Container(
            color: Colors.blueGrey[800],
            child: FutureBuilder(
                future: getPages(_idLeague),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? PageView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: PageController(viewportFraction: 0.8),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int itemIndex) {
                            return snapshot.data[itemIndex];
                          })
                      : Center(child: Text(" "));
                })));
  }

  Future<List<Widget>> getPages(String _idLeague) async {
    var data = await http.get(
        "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=$_idLeague");

    List<Widget> listTeamPages = [];

    var jsonData = json.decode(data.body);

    for (var i in jsonData["teams"])
      listTeamPages.add(Padding(
          padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          child: GestureDetector(
              onTap: () {
                Team team = Team(
                    i["strTeam"],
                    i["strTeamBadge"],
                    i["strDescriptionEN"],
                    i["strYoutube"],
                    i["strInstagram"],
                    i["strFacebook"],
                    i["strWebsite"]);
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return TeamInfo(team);
                }));
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(45),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                                color: Colors.blueGrey[700], width: 5),
                            top: BorderSide(
                                color: Colors.blueGrey[800], width: 5),
                            left: BorderSide(
                                color: Colors.blueGrey[700], width: 5),
                            bottom: BorderSide(
                                color: Colors.blueGrey[800], width: 5),
                          ),
                          color: Colors.blueGrey[900]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(i["strTeam"].toString(),
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center),
                          SizedBox(height: 50),
                          Hero(
                            tag: 'imageTeamHero${i["strTeam"]}',
                            child: Image.network(i["strTeamBadge"], width: 230),
                          )
                        ],
                      ))))));
    return listTeamPages;
  }
}
