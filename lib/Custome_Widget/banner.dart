import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  bool loader = false;
  // String uid;
  var data;
  // CounterProvider _counterProvider = CounterProvider();
  getDataFromServer() async {
    final _prefs = await SharedPreferences.getInstance();
    String uid = _prefs.getString('uid');
    String url =
        "http://888travelthailand.com/farmers/apis/customer/get_details_by_id?id=$uid";
    final response = await http.get(url);
    setState(() {
      data = jsonDecode(response.body);
      if (data['status']) {
        loader = true;
      }
    });
    print(data);
  }

  @override
  void initState() {
    getDataFromServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFD553),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: Image.asset(
                'assets/images/delevery-ico.png',
                fit: BoxFit.cover,
              )).p(8),
          Expanded(
            child: loader == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Detalles del Pedido ${data['data'][0]['name']}"
                          .text
                          .bold
                          .textStyle(GoogleFonts.openSans())
                          .size(2)
                          .make(),
                      "Dirección ${data['data'][0]['address']}"
                          .text
                          .textStyle(GoogleFonts.openSans())
                          .bold
                          .size(4)
                          .make(),
                      // Text(
                      //   "SABADO, 12 DE DICIEMBRE DE 2020",
                      //   style:
                      //       GoogleFonts.openSans(), //GoogleFonts.openSansTextTheme(),
                      // ).text.size(7).make(),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
          ),
          Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child:
                      Image.asset('assets/images/edit.png', fit: BoxFit.cover))
              .p(8)
        ],
      ),
    );
  }
}
