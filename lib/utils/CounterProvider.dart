// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:velocity_x/velocity_x.dart';

// class CounterProvider extends ChangeNotifier {
//   int data = 0;
//   getdata() => data;
//   fetchData() async {
//     final _prefs = await SharedPreferences.getInstance();
//     final uid = _prefs.getString('uid');
//     try {
//       String url =
//           "http://farmerappportal.cynotecksandbox.com/apis/order/showcart_byuid?uid=$uid";
//       final response = await http.get(url);
//       var rsp = jsonDecode(response.body);
      
//       if (rsp['status']) {
//          data = rsp['data'].length;
//         print(url);
//         print(data);
//         notifyListeners();
//       }
//     } catch (e) {
//       print(e);
//     }
//      notifyListeners();
//   }
// }
