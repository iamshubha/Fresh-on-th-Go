import 'dart:convert';

import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class CartIcon extends StatefulWidget {
  @override
  _CartIconState createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  int data = 0;
  getData() async {
    final _prefs = await SharedPreferences.getInstance();
    final uid = _prefs.getString('uid');
    try {
      String url =
          "http://888travelthailand.com/farmers/apis/order/showcart_byuid?uid=$uid";
      final response = await http.get(url);
      var rsp = jsonDecode(response.body);
      if (rsp['status']) {
        setState(() {
          data = rsp['data'].length;
          print(url);
          print(data);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Badge(
        child: Image.asset('assets/images/cart.png', fit: BoxFit.contain).p(5),
        badgeContent: Text("$data").text.white.make(),
        elevation: 0,
        badgeColor: kPrimaryColor,
      ),
    );
  }
}
