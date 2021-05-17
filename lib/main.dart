import 'package:flutter/material.dart';
import 'package:pharmacypk/screens/auth_screen.dart';
import 'package:pharmacypk/screens/homepage.dart';
import 'package:pharmacypk/screens/viewer_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool decision =prefs.getBool('pageV');

  Widget _screen = (decision == false || decision == null) ? PageViewer() : AuthScreen();

  runApp(MaterialApp(MaterialApp(home: _screen)));
  /*MaterialApp(home: _screen)*/
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Pharamcy '),
      ),
      body: Center(),
    );
  }
}
