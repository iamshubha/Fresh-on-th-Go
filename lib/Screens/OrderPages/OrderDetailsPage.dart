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
  final String date;
  final String status;
  OrderDetailsPage(
      {@required this.oid, @required this.date, @required this.status});

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var data;
  List arrData = [];
  bool loader = false;

  getData() async {
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
            "https://mercadosagricolaspr.com/farmer-new/apis/customer/detail_for_order_no?order_no=${widget.oid}";
        final resp = await http.get(url);
        var response = jsonDecode(resp.body);
        setState(() {
          data = response;
          print(data);
          arrData = response['data'];
          print(data);
          loader = true;
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
        title: "Detalles del pedido"
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
            loader == true
                ? Column(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                "Nùmero de Orden :"
                                    .text
                                    .size(10)
                                    .bold
                                    .textStyle(GoogleFonts.openSans())
                                    .make(),
                                " ${data['order_no']}"
                                    .text
                                    .size(8)
                                    .bold
                                    .letterSpacing(0)
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
                                    .size(10)
                                    .bold
                                    .textStyle(GoogleFonts.openSans())
                                    .make(),
                                " ${arrData.length}"
                                    .text
                                    .size(8)
                                    .bold
                                    .color(kPrimaryColor)
                                    .textStyle(GoogleFonts.openSans())
                                    .make()
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                "Estatus :"
                                    .text
                                    .size(10)
                                    .bold
                                    .textStyle(GoogleFonts.openSans())
                                    .make(),
                                Container(
                                  child: " ${widget.status}"
                                      .text
                                      .size(8)
                                      .bold
                                      .color(kPrimaryColor)
                                      .textStyle(GoogleFonts.openSans())
                                      .makeCentered(),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                "Realizada :"
                                    .text
                                    .size(10)
                                    .bold
                                    .textStyle(GoogleFonts.openSans())
                                    .make(),
                                " ${widget.date}"
                                    .text
                                    .size(8)
                                    .color(kPrimaryColor)
                                    .bold
                                    .textStyle(GoogleFonts.openSans())
                                    .make()
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topCenter,
                                  child: "Entrega: "
                                      .text
                                      .size(10)
                                      .bold
                                      .textStyle(GoogleFonts.openSans())
                                      .make(),
                                ),
                                Container(
                                  width: data['delivery_time'] == null
                                      ? MediaQuery.of(context).size.height *
                                          0.25
                                      : MediaQuery.of(context).size.height *
                                          0.17,
                                  child: " ${data['delivery_address']}"
                                      .text
                                      .size(8)
                                      .bold
                                      .color(kPrimaryColor)
                                      .textStyle(GoogleFonts.openSans())
                                      .make(),
                                )
                              ],
                            ),
                            data['delivery_time'] != null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      "Hora:"
                                          .text
                                          .size(8)
                                          .bold
                                          .textStyle(GoogleFonts.openSans())
                                          .make(),
                                      " ${data['delivery_time']}"
                                          .text
                                          .size(8)
                                          .color(kPrimaryColor)
                                          .bold
                                          .textStyle(GoogleFonts.openSans())
                                          .make()
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ).pOnly(left: 17, right: 17, bottom: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.45,
                      // color: Colors.green,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: ListView.builder(
                                itemCount: arrData.length,
                                itemBuilder: (_, i) {
                                  return ListTile(
                                    leading: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.23,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.23,
                                      child: Image.network(
                                        arrData[i]['products']['pimg'],
                                        fit: BoxFit.cover,
                                      ).pOnly(right: 5),
                                    ),
                                    title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          '${arrData[i]['products']['pname']}'
                                              .text
                                              .size(1)
                                              .textStyle(GoogleFonts.openSans())
                                              .bold
                                              .make(),
                                          'Qty : ${arrData[i]['products']['ordered_qty']} ${arrData[i]['products']['unit']}'
                                              .text
                                              .size(1)
                                              .textStyle(GoogleFonts.openSans())
                                              .bold
                                              .make(),
                                          '${arrData[i]['products']['pdesc']}'
                                              .text
                                              .size(1)
                                              .textStyle(GoogleFonts.openSans())
                                              .bold
                                              .make(),
                                        ]),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        "A pagar"
                                            .text
                                            .textStyle(GoogleFonts.openSans())
                                            .bold
                                            .make(),
                                        SizedBox(height: 10),
                                        "\$: ${arrData[i]['products']['total_price']}"
                                            .text
                                            .extraBold
                                            .textStyle(GoogleFonts.openSans())
                                            .make(),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Divider(),
                          Expanded(
                            child: Container(
                              color: Colors.grey[100],
                              padding: EdgeInsets.only(right: 15),
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topRight,
                              child:
                                  "Total a pagar: \$${data['total_order_cost']}"
                                      .text
                                      .make(),
                            ),
                          )
                        ],
                      ),
                    ).pOnly(left: 0, right: 10),
                  ])
                : Center(child: CircularProgressIndicator())
          ]),
    );
  }
}

/**
 *     Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                "Nùmero de Orden :"
                                    .text
                                    .bold
                                    .textStyle(GoogleFonts.openSans())
                                    .make(),
                                " ${data['order_no']}"
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
                                "Total de Productos :"
                                    .text
                                    .bold
                                    .textStyle(GoogleFonts.openSans())
                                    .make(),
                                " ${arrData.length}"
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
                                "Realizada :"
                                    .text
                                    .uppercase
                                    .bold
                                    .textStyle(GoogleFonts.openSans())
                                    .make(),
                                // " ${data['date']}"
                                "${widget.date}"
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
                                "Estatus :"
                                    .text
                                    .bold
                                    .uppercase
                                    .textStyle(GoogleFonts.openSans())
                                    .make(),
                                Container(
                                  child: " ${widget.status}"
                                      .text
                                      .bold
                                      .color(kPrimaryColor)
                                      .textStyle(GoogleFonts.openSans())
                                      .makeCentered(),
                                )
                              ],
                            )
                          ],
                        ),
                    
 */
