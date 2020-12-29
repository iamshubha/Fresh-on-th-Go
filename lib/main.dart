import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:FreshOnTheGo/Home/Profile.dart';
import 'package:FreshOnTheGo/Screens/HomePage.dart';
// import 'package:FreshOnTheGo/Screens/MyCart.dart';
// import 'package:FreshOnTheGo/Screens/ProductDetails.dart';
import 'package:FreshOnTheGo/Screens/StartPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primarySwatch: Color(0xFF5BB774),
          accentColor: Color(0xFF5BB774),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Dicider());
  }
}

class Dicider extends StatefulWidget {
  @override
  _DiciderState createState() => _DiciderState();
}

class _DiciderState extends State<Dicider> {
  String uid;
  getSharedData() async {
    final _prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = _prefs.getString('uid');
    });
  }

  @override
  void initState() {
    getSharedData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return uid != null ? HomePage() : StartPage();
  }
}
