import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Screens/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StartPage extends StatelessWidget {
  // uu() async{
  //   String url = "http://888travelthailand.com/farmers/apis/product/addproducts";
  //   final headers = {'Content-Type': 'application/json'};
  //   Map<String, dynamic> body = {
  //     "cid": 1,
  //     "type": 1,
  //     "image": "apple.jpg",
  //     "name": "Blueberry",
  //     "description": "Fruit with distinctive taste",
  //     "cost_price": 180.26,
  //     "sell_price": 200.56,
  //     "unit": "Kg",
  //     "total_qty": 450,
  //     "created_by": 1
  //   };
  //   String jsonBody = json.encode(body);
  //   final response = await http.post(url, body: jsonBody, headers: headers);
  //   var data = jsonDecode(response.body);
  //   // var data = {"status": true, "message": "User created successfully."};
  //   print(data);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
            child: Image.asset('assets/getstartedbtn.png'),
          ),
        ),
      ),
    );
  }
}
