import 'package:flutter/material.dart';
import 'Sports/sport_lists.dart';
import 'Leagues/list_leagues.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Sports'),
            backgroundColor: Colors.blueGrey[900],
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.share),
                  tooltip: 'Share',
                  onPressed: () {
                    Navigator.of(context).pushNamed('/second_screen');
                  }),
              IconButton(
                  icon: Icon(Icons.account_circle),
                  tooltip: 'Your account',
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/account_screen');
                  }),
              IconButton(
                  icon: Icon(Icons.exit_to_app),
                  tooltip: 'Logout',
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/login_screen');
                  }),
            ]),
        body: TabBarView(
          children: <Widget>[SportList(), LeagueList()],
          controller: controller,
        ),
        bottomNavigationBar: Container(
          height: 45,
          child: Material(
            color: Colors.blueGrey[900],
            child: TabBar(
              tabs: <Tab>[
                Tab(
                  icon: Icon(Icons.category),
                  //text: "List Sports",
                ),
                Tab(
                  icon: Icon(Icons.library_books),
                  //text: "List Leagues",
                ),
              ],
              controller: controller,
            ),
          ),
        ));
  }
}
