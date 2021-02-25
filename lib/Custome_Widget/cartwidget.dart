import 'dart:async';
import 'dart:convert';

import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

// class CartIcon extends StatefulWidget {
//   final int val;
//   CartIcon({@required this.val});
//   @override
//   _CartIconState createState() => _CartIconState();
// }

// class _CartIconState extends State<CartIcon> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Badge(
//         child: Image.asset('assets/images/cart.png', fit: BoxFit.contain).p(5),
//         badgeContent: Text("${widget.val}").text.white.make(),
//         elevation: 0,
//         badgeColor: kPrimaryColor,
//       ),
//     );
//   }
// }

class CartIconHome extends StatefulWidget {
  @override
  _CartIconHomeState createState() => _CartIconHomeState();
}

class _CartIconHomeState extends State<CartIconHome> {
  int iconval = 0;
  getIconVal() async {
    final _prefs = await SharedPreferences.getInstance();
    final uid = _prefs.getString('uid');
    try {
      String url =
          "http://888travelthailand.com/farmers/apis/order/showcart_byuid?uid=$uid";
      final response = await http.get(url);
      var rsp = jsonDecode(response.body);
      if (rsp['status']) {
        setState(() {
          iconval = rsp['total_qty'];
          print("==================");
          print(url);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => getIconVal());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Badge(
        child: Image.asset('assets/images/cart.png', fit: BoxFit.contain).p(5),
        badgeContent: Text("$iconval").text.white.make(),
        elevation: 0,
        badgeColor: kPrimaryColor,
      ),
    );
  }
}

// int iconval = 0;
//   getIconVal() async {
//     final _prefs = await SharedPreferences.getInstance();
//     final uid = _prefs.getString('uid');
//     try {
//       String url =
//           "http://888travelthailand.com/farmers/apis/order/showcart_byuid?uid=$uid";
//       final response = await http.get(url);
//       var rsp = jsonDecode(response.body);
//       if (rsp['status']) {
//         setState(() {
//           iconval = rsp['data'].length;
//           print(url);
//           print(data);
//         });
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
