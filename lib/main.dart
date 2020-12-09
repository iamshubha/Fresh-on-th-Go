import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh_on_the_go/Home/Profile.dart';
import 'package:fresh_on_the_go/Screens/HomePage.dart';
import 'package:fresh_on_the_go/Screens/MyCart.dart';
import 'package:fresh_on_the_go/Screens/ProductDetails.dart';
import 'package:fresh_on_the_go/Screens/StartPage.dart';

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
      
      home: HomePage()
    );
  }
}
