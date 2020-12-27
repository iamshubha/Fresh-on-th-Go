import 'dart:convert';

import 'package:FreshOnTheGo/Custome_Widget/banner.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class OrderDetailsPage extends StatefulWidget {
  final String oid;
  OrderDetailsPage({this.oid});

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var data;
  getData() async {
    final _prefs = await SharedPreferences.getInstance();
    final uid = _prefs.getString('uid');
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
            'http://888travelthailand.com/farmers/apis/customer/customer_order_dets?oid=${widget.oid}&uid=$uid';

        final resp = await http.get(url);
        var response = jsonDecode(resp.body);
        setState(() {
          data = response;
        });
        print(data);
        print(url);
      }
    } catch (e) {}
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: "Order Details"
            .text
            .uppercase
            .bold
            .textStyle(GoogleFonts.openSans())
            .make(),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
              ),
              height: MediaQuery.of(context).size.height * 0.019,
              width: MediaQuery.of(context).size.width,
              // child: "".text.make(),
            ), //.pOnly(bottom: 20),
            BannerWidget().p(17),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        "Order Id :"
                            .text
                            .bold
                            .textStyle(GoogleFonts.openSans())
                            .make(),
                        " ${data['order_id']}"
                            .text
                            .bold
                            .color(kPrimaryColor)
                            .textStyle(GoogleFonts.openSans())
                            .make()
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        "Total :"
                            .text
                            .bold
                            .textStyle(GoogleFonts.openSans())
                            .make(),
                        " ${data['total']}"
                            .text
                            .bold
                            .color(kPrimaryColor)
                            .textStyle(GoogleFonts.openSans())
                            .make()
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        "Date :"
                            .text
                            .uppercase
                            .bold
                            .textStyle(GoogleFonts.openSans())
                            .make(),
                        " ${data['date']}"
                            .text
                            .uppercase
                            .color(kPrimaryColor)
                            .bold
                            .textStyle(GoogleFonts.openSans())
                            .make()
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        "Order Status :"
                            .text
                            .bold
                            .uppercase
                            .textStyle(GoogleFonts.openSans())
                            .make(),
                        " ${data['order_status']}"
                            .text
                            .bold
                            .color(kPrimaryColor)
                            .textStyle(GoogleFonts.openSans())
                            .make()
                      ],
                    )
                  ],
                )
              ],
            ).pOnly(left: 17, right: 17, bottom: 20),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.60,
                // color: Colors.green,
                child: ListView.builder(
                    itemCount: data['data'].length,
                    itemBuilder: (_, i) {
                      return ListTile(
                          leading: Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Image.network(
                              data['data'][i]['products']['pimg'],
                              fit: BoxFit.cover,
                            ).p(8),
                          ),
                          title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                '${data['data'][i]['products']['pname']}'
                                    .text
                                    .size(1)
                                    .textStyle(GoogleFonts.openSans())
                                    .bold
                                    .make(),
                                'Qty : ${data['data'][i]['products']['ordered_qty']} ${data['data'][i]['products']['unit']}'
                                    .text
                                    .size(1)
                                    .textStyle(GoogleFonts.openSans())
                                    .bold
                                    .make(),
                                '${data['data'][i]['products']['pdesc']}'
                                    .text
                                    .size(1)
                                    .textStyle(GoogleFonts.openSans())
                                    .bold
                                    .make(),
                              ]),
                          trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                "Ammount"
                                    .text
                                    .textStyle(GoogleFonts.openSans())
                                    .bold
                                    .make(),
                                SizedBox(height: 10),
                                "\$: ${data['data'][i]['products']['total_price']}"
                                    .text
                                    .extraBold
                                    .textStyle(GoogleFonts.openSans())
                                    .make(),
                              ]));
                    })).pOnly(left: 17, right: 17)
          ]),
    );
  }
}
