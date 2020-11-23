import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/login.png'), fit: BoxFit.cover)),
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.80,
              left: MediaQuery.of(context).size.width * 0.20,
              right: MediaQuery.of(context).size.width * 0.20),
          child: InkWell(
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
            //child: Image.asset('assets/getstartedbtn.png'),
          ),
        ),
      ),
    );
  }
}
