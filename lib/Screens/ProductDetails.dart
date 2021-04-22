import 'dart:convert';
import 'package:FreshOnTheGo/Custome_Widget/cartwidget.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:FreshOnTheGo/Screens/MyCart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class ProductDetailsPage extends StatefulWidget {
  final String cid, pid, price;
  ProductDetailsPage(
      {@required this.cid, @required this.pid, @required this.price});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Connectivity _stateNet = Connectivity();
  int qnt = 0;
  bool loader = true;
  var predictData;
  var productDetails;
  String uid;
  bool isRspAvlb = true;
  addToCart(String pid, int qty) async {
    setState(() {
      loader = false;
    });
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
            "https://mercadosagricolaspr.com/farmer-new/apis/order/addcart";
        final headers = {'Content-Type': 'application/json'};
        Map<String, dynamic> body = {
          "pid": "$pid",
          "qty": "$qty",
          "uid": "$uid"
        };
        String jsonBody = json.encode(body);
        final response = await http.post(url, body: jsonBody, headers: headers);
        var data = jsonDecode(response.body);
        print(data);
        if (data['status']) {
          setState(() {
            loader = true;
            qnt = 0;
          });
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text('${data['message']}'),
            duration: Duration(seconds: 3),
          ));
        } else {
          setState(() {
            qnt = qty;
            loader = true;
          });
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text('${data['message']}'),
            duration: Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  a() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = _prefs.getString('uid');
    });
    var result = await Connectivity().checkConnectivity();
    print(result.index);
    if (result.index != 2) {
      setState(() {
        loader = false;
      });
      var productDescriptionse = http.get(
        "https://mercadosagricolaspr.com/farmer-new/apis/product/get_all_product_by_name?pname=${widget.pid}",
      );

      var predictDataResponse = http.get(
          'https://mercadosagricolaspr.com/farmer-new/apis/product/get_all_product_by_name?pname=${widget.pid}');
      var responseData =
          await Future.wait([productDescriptionse, predictDataResponse]);

      print(
          "https://mercadosagricolaspr.com/farmer-new/apis/product/get_all_product_by_name?pname=${widget.pid}");
      final data1 = jsonDecode(responseData[0].body);
      final data2 = jsonDecode(responseData[1].body);
      print(data1);
      print(data2);
      if (data1['status']) {
        setState(() {
          productDetails = data1['data'][0];
          predictData = data2['data'];
          getIconVal();
          loader = true;
        });
      } else {
        setState(() {
          isRspAvlb = false;
        });
      }
    }
  }

  int iconval = 0;
  getIconVal() async {
    final _prefs = await SharedPreferences.getInstance();
    final uid = _prefs.getString('uid');
    try {
      String url =
          "https://mercadosagricolaspr.com/farmer-new/apis/order/showcart_byuid?uid=$uid";
      final response = await http.get(url);
      var rsp = jsonDecode(response.body);
      if (rsp['status']) {
        setState(() {
          iconval = rsp['total_qty'];
          print(url);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    a();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kPrimaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        // leading: InkWell(
        //   child: Image.asset(
        //     'assets/images/back-ico.png',
        //     // height: 4,
        //     // width: 4,
        //   ).p(5),
        //   onTap: () => Navigator.pop(context),
        // ),
        actions: [
          InkWell(
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MyCartPage())),
                  child: CartIconHome().p(3.09))
              .p(5)
        ],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Detalles de producto"
                .text
                .textStyle(GoogleFonts.openSans())
                .make(),
          ],
        ),
      ),
      body: Container(
        child: isRspAvlb
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)),
                    ),
                  ).pOnly(bottom: 10),

                  loader == true
                      ? Column(children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.height * 0.28,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.20,
                                  // width: MediaQuery.of(context).size.width,
                                  // margin: EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    child: Image.network(
                                        productDetails['image'],
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        "${productDetails['name']}"
                                            .text
                                            .bold
                                            .textStyle(GoogleFonts.openSans())
                                            .make(),
                                        "\$: ${widget.price}"
                                            .text
                                            .xl
                                            .bold
                                            .textStyle(GoogleFonts.openSans())
                                            .make(),
                                      ],
                                    ),
                                    // GestureDetector(
                                    //   onTap: () =>
                                    //       addToCart(productDetails['pid'], "1"),
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //         color: Colors.green,
                                    //         borderRadius: BorderRadius.circular(8)),
                                    //     child: "AÑADIR AL CARRITO"
                                    //         .text
                                    //         .textStyle(GoogleFonts.openSans())
                                    //         .bold
                                    //         .white
                                    //         .size(10)
                                    //         .make()
                                    //         .p(8),
                                    //   ).pOnly(right: 10),
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          ).pOnly(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.03),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Detalles"
                                    .text
                                    .textStyle(GoogleFonts.openSans())
                                    .bold
                                    .uppercase
                                    .make()
                                    .pOnly(bottom: 5),
                                "${productDetails['description']}"
                                    .text
                                    .textStyle(GoogleFonts.openSans())
                                    .size(4)
                                    .letterSpacing(0)
                                    .make()
                              ],
                            ),
                          ).pOnly(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.043),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: ListView.builder(
                              itemCount: predictData.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            predictData[i]['image'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ).p(10).pOnly(right: 10),
                                      Container(
                                        // width: MediaQuery.of(context).size.width * 0.60,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            "${predictData[i]['name']}"
                                                .text
                                                .bold
                                                .textStyle(
                                                    GoogleFonts.openSans())
                                                .size(8)
                                                .make(),
                                            "${predictData[i]['farmerName']}"
                                                .text
                                                .bold
                                                .textStyle(
                                                    GoogleFonts.openSans())
                                                .size(8)
                                                .make(),
                                            "Seleccionar Producto"
                                                .text
                                                .textStyle(
                                                    GoogleFonts.openSans())
                                                .bold
                                                .make(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                // "\$ : ${predictData[i]['sell_price']}"
                                                //     .text
                                                //     .xl
                                                //     .bold
                                                //     .make()
                                                //     .pOnly(
                                                //         right: MediaQuery.of(context)
                                                //                 .size
                                                //                 .width *
                                                //             0.07),
                                                InkWell(
                                                  onTap: () {
                                                    qnt != 0
                                                        ? addToCart(
                                                            predictData[i]
                                                                ['pid'],
                                                            qnt)
                                                        : context.showToast(
                                                            bgColor:
                                                                kPrimaryColor,
                                                            textColor:
                                                                Colors.white,
                                                            msg:
                                                                "Please increase value");
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: "Añadir"
                                                        .text
                                                        .textStyle(GoogleFonts
                                                            .openSans())
                                                        .white
                                                        .size(10)
                                                        .make()
                                                        .p(8),
                                                  ).pOnly(right: 10),
                                                ),

                                                Container(
                                                    alignment: Alignment.center,
                                                    color: Color(0xFFFFD456),
                                                    child: VxStepper(
                                                      inputBoxColor:
                                                          Colors.white,
                                                      actionButtonColor:
                                                          Colors.transparent,
                                                      onChange: (v) {
                                                        print(v);
                                                        setState(() => qnt = v);
                                                      },
                                                    )).pOnly(left: 0, right: 0)
                                              ],
                                            ).pOnly(bottom: 10)
                                          ],
                                          // ),
                                        ),
                                      ).pOnly(top: 30)
                                    ],
                                  ),
                                ).pOnly(bottom: 10);
                              },
                            ),

                            // Column(
                            //   children: [

                            //   ],
                            // ),
                          )
                        ])
                      : Center(
                          child: CircularProgressIndicator().pOnly(top: 30)),
                  // BottomAppBar(
                  //   child: Container(
                  //     height: 20,
                  //     width: MediaQuery.of(context).size.width,
                  //   ),
                  //   color: Colors.red,
                  // )
                ],
              )
            : Center(
                child: "No Data Available".text.make(),
              ),
      ),
      // bottomNavigationBar: Container(
      //   color: kPrimaryColor,
      //   height: 55,
      //   alignment: Alignment.center,
      //   child:
      //       //  Row(
      //       //   children: [
      //       "ir al carrito"
      //           .text
      //           .white
      //           .textStyle(GoogleFonts.openSans())
      //           .xl2
      //           .bold
      //           .uppercase
      //           .make(),
      //   // Image.asset('')
      //   //   ],
      //   // ),
      // ),
    );
  }

  final List<String> imgList = [
    'assets/images/veg0.png',
    'assets/images/veg1.png',
    'assets/images/veg2.png',
  ];

// final List<Widget> imageSliders = imgList
//     .map((item) => Container(
//           child: Container(
//             margin: EdgeInsets.all(5.0),
//             child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                 child: Stack(
//                   children: <Widget>[
//                     Image.asset(item, fit: BoxFit.cover, width: 1000.0),
//                   ],
//                 )),
//           ),
//         ))
//     .toList();

  // 'https://mercadosagricolaspr.com/farmer-new/apis/product/searchproductbyid?pid=${widget.pid}'
  // 'https://mercadosagricolaspr.com/farmer-new/apis/product/searchproductbycatagory?cid=${widget.cid}'
}
