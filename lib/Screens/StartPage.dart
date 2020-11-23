import 'package:flutter/material.dart';
import 'package:fresh_on_the_go/Screens/LoginPage.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/splash.png'), fit: BoxFit.cover)),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.80,
              left: MediaQuery.of(context).size.width * 0.20,
              right: MediaQuery.of(context).size.width * 0.20),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
            child: Image.asset('assets/getstartedbtn.png'),
          ),
        ),
      ),
    );
  }
}
