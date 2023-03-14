import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_with_signup/Screens/CategoriePage.dart';
import 'package:login_with_signup/Screens/HomeForm.dart';
import 'package:login_with_signup/Screens/LoginForm.dart';
import 'package:login_with_signup/Screens/homePage.dart';


import 'package:shared_preferences/shared_preferences.dart';


class page extends StatefulWidget {
page({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _pageState createState() => _pageState();
}

class _pageState extends State<page> {
   Future<SharedPreferences> _pref = SharedPreferences.getInstance();
 

  @override
  Widget build(BuildContext context) {
   
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('page'),
      ),
      body: new Container(
        child: new Center(
            child:  Text(' page '),
        ),
      ),
          drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'menu',
                style: TextStyle(fontSize: 20),
              ),
            ),
              ListTile(
              leading: Icon(Icons.workspace_premium),
              title: const Text(' Home '),
              onTap: () {
                 Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => HomePage()),
                                (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                  Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => HomeForm()),
                                (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: const Text('tansactions'),
              onTap: () {
              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => page()),
                                (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: Icon(Icons.workspace_premium),
              title: const Text(' categories '),
              onTap: () {
                  Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => CategoriePage()),
                                (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: Icon(Icons.video_label),
              title: const Text(' objectif '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () async {
                   final SharedPreferences sp = await _pref;
                 sp.remove('user_id');
      sp.remove('user_name');
      sp.remove('email');
      sp.remove('password');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginForm()),
              (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
