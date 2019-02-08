import 'package:flutter/material.dart';
import 'Sports/sport_lists.dart';
import 'Leagues/list_leagues.dart';
import 'about_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

   @override
  void initState() {
    super.initState();
    MyDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
            title: Text('Sports'),
            backgroundColor: Colors.blueGrey[900],
            // automaticallyImplyLeading: false,
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
            ]),
        body: MyTab(),
    );
  }
}

class MyDrawer extends StatefulWidget {
  @override
  State createState() => MyDrawerState();
}  

class MyDrawerState extends State<MyDrawer> {
  SharedPreferences sharedPreferences;
  String sharedPreferenceEmail;
  String value;

  @override
  void initState() {
    super.initState();
    getDataPreference();
  }

  getDataPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      value = sharedPreferences.getString("email");
      if(value != null) {
        sharedPreferenceEmail = sharedPreferences.getString("email");
      } else {
        sharedPreferenceEmail = "Sign in with Google";
      }
    });
  }

  removeDataPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.remove("email");
    });
  }
 
  @override
  Widget build(BuildContext ctxt) {
    return Drawer(
      child: Container(
        color: Colors.blueGrey[800],
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blueGrey[900]),
                accountName: Text(sharedPreferenceEmail),
                accountEmail: Text(" "),
                currentAccountPicture: CircleAvatar(
                  child: FlutterLogo(size: 40),
                  backgroundColor: Colors.white,
                ),
              ),
              ListTile(
                title: Text('About us'),
                leading: Icon(Icons.people, color: Colors.blueGrey[400]),
                onTap: () {
                  // Navigator.pop(ctxt);
                  Navigator.push(ctxt,
                    MaterialPageRoute(builder: (ctxt) => AboutUs())
                    );
                },
              ),
              ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.exit_to_app, color: Colors.blueGrey[400]),
                onTap: () {
                  // Navigator.pop(ctxt);
                  removeDataPreference();
                  Navigator.of(ctxt,).pushReplacementNamed('/login_screen');
                },
              )
            ],
          )
    )
    );
  }
}

class MyTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyTabState();
}

class MyTabState extends State<MyTab> with SingleTickerProviderStateMixin {
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
  Widget build(BuildContext ctxt) {
    return Scaffold(
      body: 
        TabBarView(
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
                ),
                Tab(
                  icon: Icon(Icons.library_books),
                ),
              ],
              controller: controller,
            ),
          ),
        )
    );
  }
}