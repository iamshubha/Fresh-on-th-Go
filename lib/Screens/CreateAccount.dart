import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:FreshOnTheGo/Screens/LoginPage.dart';
import 'package:FreshOnTheGo/Screens/OtpPage.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _userEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();
  final _confirmPasswordEditingController = TextEditingController();

  createUserPostRequest() async {
    if (_passwordEditingController.text ==
        _confirmPasswordEditingController.text) {
      var network = await Connectivity().checkConnectivity();
      print(network.index);
      if (network.index == 2) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text('Please Check Your Internet Connection'),
          // duration: Duration(seconds: 3),
        ));
      } else {
        String url =
            "http://888travelthailand.com/farmers/apis/customer/register";
        final headers = {'Content-Type': 'application/json'};

        Map<String, dynamic> body = {
          "user_type": "3",
          "email": _userEditingController.text.toString(),
          "password": _confirmPasswordEditingController.text.toString()
        };
        String jsonBody = json.encode(body);
        final response = await http.post(url, body: jsonBody, headers: headers);
        var data = jsonDecode(response.body);
        print(data);
        if (data['status']) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text(data['message']),
            duration: Duration(seconds: 3),
          ));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => OtpPage(_userEditingController.text)));
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text(data['message']),
            duration: Duration(seconds: 3),
          ));
        }
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: kPrimaryColor,
        content: Text('Confirm Password must be same'),
        // duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  void dispose() {
    _userEditingController.dispose();
    _passwordEditingController.dispose();
    _confirmPasswordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/registration-bg.png'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.550,
                left: MediaQuery.of(context).size.width * 0.10,
                right: MediaQuery.of(context).size.width * 0.10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) => EmailValidator.validate(value)
                      ? null
                      : "Please enter a valid email",
                  controller: _userEditingController,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: Image.asset(
                      'usernameico.png',
                      width: 10,
                    ).pOnly(top: 10, bottom: 10, right: 10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        // width: 2.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    fillColor: Color(0xFFFFD552),
                    hintText: "Colocar su email",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordEditingController,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: Image.asset(
                      'passwordico.png',
                      width: 10,
                    ).pOnly(top: 10, bottom: 10, right: 10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        // width: 2.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    fillColor: Color(0xFFFFD552),
                    hintText: "Contraseña",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _confirmPasswordEditingController,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: Image.asset(
                      'passwordico.png',
                      width: 10,
                    ).pOnly(top: 10, bottom: 10, right: 10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        // width: 2.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    fillColor: Color(0xFFFFD552),
                    hintText: "Confirmar Contraseña",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: InkWell(
                        onTap: createUserPostRequest,
                        // () => Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (_) => LoginPage())),
                        child: Image.asset('assets/getstartedbtn.png'),
                      ),
                    ),
                  ],
                ).pOnly(left: 5, right: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
