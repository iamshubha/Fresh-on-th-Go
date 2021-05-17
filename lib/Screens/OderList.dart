import 'dart:convert';

import 'package:FreshOnTheGo/Screens/OrderPages/OrderDetailsPage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Custome_Widget/banner.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var data = [];
  String uid;
  bool loader = false;
  getOrderData() async {
    final _prefs = await SharedPreferences.getInstance();
    uid = _prefs.getString('uid');
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
            "https://mercadosagricolaspr.com/farmer-new/apis/customer/order_no_for_customer?uid=$uid";
        // "https://mercadosagricolaspr.com/farmer-new/apis/customer/order_got_for_customer?uid=$uid";
        final response = await http.get(url);
        var rsp = jsonDecode(response.body);
        if (rsp['status']) {
          setState(() {
            data = rsp['data'];
            loader = true;
            print(url);
            print(data);
          });
        } else {
          setState(() => loader = true);
        }
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    getOrderData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: "Lista Pedido"
            .text
            .capitalize
            .bold
            .textStyle(GoogleFonts.openSans())
            .make(),
      ),
      body: Column(
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
          ).pOnly(bottom: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerWidget().pOnly(left: 10, right: 10),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.6,
                // width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.065,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xFFEEECED),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "".text.uppercase.make(),
                          "Estado del Pedido".text.uppercase.make(),
                          "Fecha actual".text.uppercase.make()
                        ],
                      ).pOnly(left: 10, right: 10),
                    ),
                    loader == true
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.482,
                            child: data.length != 0
                                ? ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (_, i) {
                                      return InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => OrderDetailsPage(
                                                    date: data[i]["order_dt"],
                                                    status: data[i]['status'],
                                                    // "status":"Pedido En Proceso",
                                                    oid: data[i]['oid']))),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFF5F5F5),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // "${data[i]['oid']}".text.make(),
                                              "${i + 1}".text.make(),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: kPrimaryColor,
                                                ),
                                                child: "${data[i]['oid']}"
                                                    .text
                                                    .white
                                                    .bold
                                                    .uppercase
                                                    .make()
                                                    .pOnly(left: 5, right: 5),
                                              ),
                                              "${data[i]['order_dt']}"
                                                  .text
                                                  .size(1)
                                                  .bold
                                                  .make()
                                            ],
                                          ).pOnly(left: 16, right: 16),
                                        ).pOnly(top: 5),
                                      ).pOnly(top:5,bottom:5);
                                    },
                                  )
                                : Center(
                                    child: "No Order Available"
                                        .text
                                        .uppercase
                                        .make()),
                          )
                        : Center(child: CircularProgressIndicator()),
                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.06,
                    //   decoration: BoxDecoration(
                    //       color: Color(0xFFFEF4D7),
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       "#2525".text.make(),
                    //       Container(
                    //         height: MediaQuery.of(context).size.height * 0.04,
                    //         alignment: Alignment.center,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(8),
                    //           color: Color(0xFFFBD552),
                    //         ),
                    //         child:
                    //             "Pending".text.white.bold.uppercase.make().p(6),
                    //       ),
                    //       Row(
                    //         children: [
                    //           Image.asset('assets/images/cross-ico.png')
                    //         ],
                    //       )
                    //     ],
                    //   ).pOnly(left: 16, right: 16),
                    // ).pOnly(top: 5),
                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.06,
                    //   decoration: BoxDecoration(
                    //       color: Color(0xFFF5F5F5),
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       "#2525".text.make(),
                    //       Container(
                    //         height: MediaQuery.of(context).size.height * 0.04,
                    //         alignment: Alignment.center,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(8),
                    //           color: kPrimaryColor,
                    //         ),
                    //         child: "Deilverd"
                    //             .text
                    //             .white
                    //             .bold
                    //             .uppercase
                    //             .make()
                    //             .p(6),
                    //       ),
                    //       Row(
                    //         children: [
                    //           Image.asset('assets/images/cross-ico.png')
                    //         ],
                    //       )
                    //     ],
                    //   ).pOnly(left: 16, right: 16),
                    // ).pOnly(top: 5),
                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.06,
                    //   decoration: BoxDecoration(
                    //       color: Color(0xFFFEF4D7),
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       "#2525".text.make(),
                    //       Container(
                    //         height: MediaQuery.of(context).size.height * 0.04,
                    //         alignment: Alignment.center,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(8),
                    //           color: Color(0xFFFBD552),
                    //         ),
                    //         child:
                    //             "Pending".text.white.bold.uppercase.make().p(6),
                    //       ),
                    //       Row(
                    //         children: [
                    //           Image.asset('assets/images/cross-ico.png')
                    //         ],
                    //       )
                    //     ],
                    //   ).pOnly(left: 16, right: 16),
                    // ).pOnly(top: 5),
                  ],
                ).pOnly(
                    left: 10, right: 10, top: 20), //.pOnly(left: 20, top: 20),
              ).pOnly(left: 10, right: 10),
            ],
          ).pOnly(left: 10, right: 10)
        ],
      ),
    );
  }
}
