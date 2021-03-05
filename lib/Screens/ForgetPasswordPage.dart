import 'dart:convert';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _forgetEditingController = TextEditingController();
  postEmail() async {
    try {
      var network = await Connectivity().checkConnectivity();
      print(network.index);
      if (network.index == 2) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text('Please Check Your Internet Connection'),
        ));
      } else {
        String url =
            "http://farmerappportal.cynotecksandbox.com/apis/customer/send_forgot_pass_token_cust_web";
        final headers = {'Content-Type': 'application/json'};
        Map<String, dynamic> body = {
          'email': _forgetEditingController.text.toString()
        };
        String jsonBody = json.encode(body);
        final rsp = await http.post(url, body: jsonBody, headers: headers);
        var data = jsonDecode(rsp.body);
        print(data);
        if (data['status']) {
          Fluttertoast.showToast(
              msg: data['message'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: kPrimaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text(data['message']),
          ));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _forgetEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/login.png'),
                      fit: BoxFit.cover)),
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
                          controller: _forgetEditingController,
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
                            fillColor:
                                Color(0xFFFFD552), //fromRGBO(255, 213, 82,0.0),
                            hintText: "Email usuário",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.41,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: InkWell(
                            onTap: () => postEmail(),
                            child: Image.asset(
                              'assets/getstartedbtn.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ])))),
    );
  }
}
