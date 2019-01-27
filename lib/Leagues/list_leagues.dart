import 'package:flutter/material.dart';
import 'package:login_program/Widgets/drop_down_list_countries.dart';
import 'package:login_program/Widgets/drop_down_lists_sports.dart';
import 'package:login_program/Leagues/leagues_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class LeagueList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LeagueListState();
}

class LeagueListState extends State<LeagueList> {
  String country;
  String sport;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[800],
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
                width: 356,
                child: FutureBuilder(
                    future: getCountries(context),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? DropdownButton(
                              value: country,
                              hint: Text(
                                "Select country",
                                style: TextStyle(color: Colors.white),
                              ),
                              items: snapshot.data,
                              onChanged: (value) {
                                country = value;
                                setState(() {});
                              },
                            )
                          : Center(child: Text(" "));
                    })),
            Container(
                width: 356,
                child: FutureBuilder(
                  future: getSports(context),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? DropdownButton(
                            isExpanded: true,
                            value: sport,
                            hint: Text("Select sport",
                                style: TextStyle(color: Colors.white)),
                            items: snapshot.data,
                            onChanged: (value) {
                              sport = value;
                              setState(() {});
                            },
                          )
                        : Center(child: Text(" "));
                  },
                )),
            Flexible(
              child: FutureBuilder(
                future: getLeagues(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return snapshot.data[index];
                          },
                        )
                      : Center(child: Text("No result"));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<ListTile>> getLeagues() async {
    http.Response data;
    String str = "countrys";
    String urlCountry =
        "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?c=$country";
    String urlCountryandSport =
        "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?c=$country&s=$sport";
    String urlLeagues =
        "https://www.thesportsdb.com/api/v1/json/1/all_leagues.php";
    List<ListTile> listTiles = [];

    if (country != null && sport != null) {
      data = await http.get(urlCountryandSport);
    } else if (country != null && sport == null) {
      data = await http.get(urlCountry);
    } else {
      data = await http.get(urlLeagues);
      str = "leagues";
    }

    var jsonData = json.decode(data.body);

    for (var i in jsonData[str]) {
      if (((sport != null) & (sport == i["strSport"])) | (sport == null)) {
        listTiles.add(ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LeagueInfo(i["idLeague"], i["strLeague"])));
          },
          title: Text(i["strLeague"],
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle:
              Text(i["strSport"], style: TextStyle(color: Colors.grey[400])),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.white,
            size: 30.0,
          ),
        ));
      }
    }
    return listTiles;
  }
}
