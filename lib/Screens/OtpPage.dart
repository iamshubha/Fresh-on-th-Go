import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:FreshOnTheGo/Screens/LoginPage.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class OtpPage extends StatefulWidget {
  final String text;
  OtpPage(this.text);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _otpEditingController = TextEditingController();
  bool loader = false;
  verifyOtpPostRequest() async {
    var network = await Connectivity().checkConnectivity();
    print(network.index);
    if (network.index == 2) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: kPrimaryColor,
        content: Text('Please Check Your Internet Connection'),
      ));
    } else {
      String url =
          "https://mercadosagricolaspr.com/farmer-new/apis/customer/upd_usr_after_otp";
      final headers = {'Content-Type': 'application/json', 'Charset': 'utf-8'};
      Map<String, dynamic> body = {
        "user_type": "3",
        "email": widget.text.toString(),
        "otp": _otpEditingController.text.toString()
      };
      print(body);
      String jsonBody = jsonEncode(body);
      print(jsonBody);
      var response = await http.post(url, body: jsonBody, headers: headers);
      var data = jsonDecode(response.body);
      print(data);
      print(response);
      if (data['status']) {
        setState(() {
          loader = false;
        });
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text(data['message']),
          duration: Duration(seconds: 3),
        ));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginPage()));
      } else {
        setState(() {
          loader = false;
        });
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text(data['message']),
            duration: Duration(seconds: 3)));
      }
    }
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
                  image: AssetImage('assets/login.png'), fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.65,
                left: MediaQuery.of(context).size.width * 0.10,
                right: MediaQuery.of(context).size.width * 0.10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  controller: _otpEditingController,
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
                    // fillColor: Color(rgb(255,213,82)),
                    fillColor: Color(0xFFFFD552), //fromRGBO(255, 213, 82,0.0),
                    hintText: "Please Enter Your OTP",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                loader != true
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.41,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              loader = true;
                            });
                            verifyOtpPostRequest();
                          },
                          child: Image.asset(
                            'assets/getstartedbtn.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.41,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: InkWell(
                          child: Image.asset(
                            'assets/3.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
