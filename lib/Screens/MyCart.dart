import 'dart:convert';
import 'package:FreshOnTheGo/Custome_Widget/cartwidget.dart';
import 'package:FreshOnTheGo/Screens/CheckOutPage.dart';
import 'package:FreshOnTheGo/Screens/CheckOutPayment.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Custome_Widget/banner.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
// import 'package:FreshOnTheGo/Screens/CheckOutPage.dart';
import 'package:FreshOnTheGo/Screens/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class MyCartPage extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String uid;
  var data;
  bool loader = true;
  bool _payloader = true;
  getCartData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    uid = _prefs.getString('uid');
    try {
      setState(() => loader = false);
      var network = await Connectivity().checkConnectivity();
      print(network.index);
      if (network.index == 2) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text('Please Check Your Internet Connection'),
        ));
      } else {
        String url =
            "https://mercadosagricolaspr.com/farmer-new/apis/order/showcart_byuid?uid=$uid"; //121
        print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
        print(uid);
        var response = await http.get(url);
        var rsp = jsonDecode(response.body);
        setState(() {
          data = rsp;
          loader = true;
        });
        print(data);
        if (data['status']) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text('${data['message']}'),
            duration: Duration(seconds: 3),
          ));
        } else {
          setState(() {});
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

  updateProductQty(String cartId, String mode) async {
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
            "https://mercadosagricolaspr.com/farmer-new/apis/order/updatecartbyid";
        Map<String, dynamic> body = {
          "cart_id": "$cartId",
          "qty": "1",
          "mode": "$mode",
        };
        String jsonBody = json.encode(body);
        final headers = {'Content-Type': 'application/json'};
        final response = await http.post(url, body: jsonBody, headers: headers);
        var data = jsonDecode(response.body);
        print(data);
        if (data['status']) {
          setState(() {
            print(data['message']);
            getCartData();
          });
        } else {
          print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  postCheckout(List cartId, String total) async {
    try {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => CheckOutPaymentPage(
                  totalPrice: data['total_price'],
                  totalqty: data['total_qty'],
                  cartids: data['cart_ids'],
                  totalrec: data['total_rec'])));
      // total_price: 110, total_qty: 2, cart_ids: [335], total_rec: 1

      //TODO:function work here...
      // var network = await Connectivity().checkConnectivity();
      // print(network.index);
      // if (network.index == 2) {
      //   _scaffoldKey.currentState.showSnackBar(SnackBar(
      //     backgroundColor: kPrimaryColor,
      //     content: Text('Please Check Your Internet Connection'),
      //   ));
      // } else {
      //   setState(() => _payloader = false);
      //   String url = "https://mercadosagricolaspr.com/farmer-new/apis/order/addorder";
      //   final headers = {'Content-Type': 'application/json'};
      //   Map<String, dynamic> body = {
      //     "cart_id": cartId,
      //     "tot_price": total.toString(),
      //     "status": "1",
      //     "remarks": "ordered...",
      //     "created_by": uid.toString(),
      //     //TODO:add key here
      //     // preferred_delivery_address
      //   };
      //   String jsonBody = json.encode(body);
      //   final response = await http.post(url, body: jsonBody, headers: headers);
      //   var postData = jsonDecode(response.body);
      //   print(postData);
      //   if (postData['status']) {
      //     setState(() => _payloader = true);
      //     Fluttertoast.showToast(
      //         msg: postData['message'],
      //         toastLength: Toast.LENGTH_SHORT,
      //         gravity: ToastGravity.BOTTOM,
      //         timeInSecForIosWeb: 1,
      //         backgroundColor: kPrimaryColor,
      //         textColor: Colors.white,
      //         fontSize: 16.0);
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (_) => HomePage()));
      //   }
      // }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCartData();
  }

  @override
  void dispose() {
    super.dispose();
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
        //     height: 4,
        //     width: 4,
        //   ),
        //   onTap: () => Navigator.pop(context),
        // ),
        // actions: [
        //   InkWell(
        //       onTap: () => Navigator.push(
        //           context, MaterialPageRoute(builder: (_) => MyCartPage())),
        //       child: CartIcon().p(10))
        // ],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Mi Carrito".text.make(),

            // "Baishnab para Santipur Nadia".text.size(10).make(),
          ],
        ),
        // leading: Icon(Icons.ac_unit),
      ),
      body: Container(
        child: Column(
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
            BannerWidget().pOnly(left: 10, right: 10, bottom: 10),
            loader == true
                ? Column(children: [
                    Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.6,
                      // width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // "ORDER SUMMERY".text.bold.make().pOnly(bottom: 20),
                          data['status'] == true
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  // width: MediaQuery.of(context).size.width * 0.50,
                                  child: ListView.builder(
                                    itemCount: data['data'].length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                data['data'][i]['image'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ).p(20),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.60,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                "${data['data'][i]['pname']}"
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
                                                    .make()
                                                    .pOnly(top: 10),
                                                // DropdownButtonHideUnderline(
                                                //     child: DropdownButton(
                                                //         // value: _selectedItem,
                                                //         // items: _dropdownMenuItems,
                                                //         onChanged: (value) {
                                                //   // setState(() {
                                                //   // _selectedItem = value;
                                                //   // });
                                                // })),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    "\$: ${data['data'][i]['price']}"
                                                        .text
                                                        .xl
                                                        .textStyle(GoogleFonts
                                                            .openSans())
                                                        .make(),
                                                    IconButton(
                                                      icon: Image.asset(
                                                          'assets/images/cart1.png'),
                                                      onPressed: () {
                                                        setState(() =>
                                                            loader = false);
                                                        updateProductQty(
                                                            '${data['data'][i]['cart_id']}',
                                                            "+");
                                                      },
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      // color: Color(0xFFFFD456),
                                                      child:
                                                          "Qty: ${data['data'][i]['qty']}"
                                                              .text
                                                              .xl
                                                              .textStyle(
                                                                  GoogleFonts
                                                                      .openSans())
                                                              .make(),
                                                    ),
                                                    IconButton(
                                                      icon: Image.asset(
                                                        'assets/images/shopping-cart-minus.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                      onPressed: () {
                                                        setState(() =>
                                                            loader = false);
                                                        updateProductQty(
                                                            '${data['data'][i]['cart_id']}',
                                                            "-");
                                                      },
                                                    ),
                                                    // Expanded(child: SizedBox()),
                                                    // Container(
                                                    //   decoration: BoxDecoration(
                                                    //       color: Colors.green,
                                                    //       borderRadius:
                                                    //           BorderRadius.circular(8)),
                                                    //   child: "ADD"
                                                    //       .text
                                                    //       .white
                                                    //       .textStyle(GoogleFonts.openSans())
                                                    //       .size(10)
                                                    //       .make()
                                                    //       .p(8),
                                                    // ).pOnly(right: 10),
                                                  ],
                                                )
                                              ],
                                              // ),
                                            ),
                                          ).pOnly(top: 30)
                                        ],
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: "No hay datos disponibles"
                                      .text
                                      .make()
                                      .pOnly(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2))
                        ],
                      ).pOnly(
                          left: 0,
                          right: 0,
                          top: 0), //.pOnly(left: 20, top: 20),
                    ).pOnly(left: 10, right: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.09,
                            color: Color(0xFF2DB573),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Total :"
                                    .text
                                    .textStyle(GoogleFonts.openSans())
                                    .color(Colors.grey[200])
                                    .bold
                                    .make(),
                                data['status'] == true
                                    ? "\$ ${data['total_price']}"
                                        .text
                                        .textStyle(GoogleFonts.openSans())
                                        .bold
                                        .white
                                        .xl2
                                        .make()
                                    : "\$ : 0.00"
                                        .text
                                        .textStyle(GoogleFonts.openSans())
                                        .bold
                                        .white
                                        .xl2
                                        .make()
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              data['status'] == true
                                  ? postCheckout(data['cart_ids'],
                                      '${data['total_price']}')
                                  : _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                      backgroundColor: kPrimaryColor,
                                      content: Text('Carrito vacio'),
                                      duration: Duration(seconds: 3),
                                    ));
                            },
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                                color: Color(0xFFFFD553),
                                alignment: Alignment.center,
                                child: _payloader == true
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          "PAGAR"
                                              .text
                                              .textStyle(GoogleFonts.openSans())
                                              .bold
                                              .make(),
                                          Image.asset(
                                              'assets/images/basket-ico.png')
                                        ],
                                      )
                                    : Center(
                                        child: CircularProgressIndicator())),
                          ),
                        )
                      ],
                    ).pOnly(left: 10, right: 10)
                  ])
                : Center(
                    child: CircularProgressIndicator()
                        .pOnly(top: MediaQuery.of(context).size.height * 0.2),
                  )
          ],
        ),
      ),
    );
  }
}
