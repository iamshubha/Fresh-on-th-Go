import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Custome_Widget/banner.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class CheckOutPaymentPage extends StatefulWidget {
  @override
  _CheckOutPaymentPageState createState() => _CheckOutPaymentPageState();
}

class _CheckOutPaymentPageState extends State<CheckOutPaymentPage> {
  final bool _selectionMethod = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _time = false;
  String _singleValue = "Text alignment right";
  List _timeList = [];
  String _verticalGroupValue;
  bool tabbar = true;
  List _delvAddress = [];
  bool loader = true;
  String _selectedAddress;
  String _initialLocationVal = 'Click Here For Location';
  // List<String> _status = ["Pending", "Released", "Blocked"];
  getTimeAddress() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final uid = _prefs.getString('uid');
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
            "https://mercadosagricolaspr.com/farmer-new/apis/store_addresses/get_customer_delivery_options?uid=$uid";
        var response = await http.get(url);
        var rsp = jsonDecode(response.body);

        if (response.statusCode == 200) {
          print(rsp);

          print(uid);
          setState(() {
            _timeList = rsp['home_delivery_timing'];
            _verticalGroupValue = _timeList[0];
            rsp['delivery_address'].forEach((element) {
              print(element.keys == 'Caribbean' ? "shubha" : 'kk');
              setState(() {
                if (element.keys.toList()[0] == 'Caribbean') {
                  _delvAddress.add(element['Caribbean']);
                } else if (element.keys.toList()[0] == 'Oficina') {
                  _delvAddress.add(element['Oficina']);
                }
              });
            });
            loader = true;
          });
          // setState(() => loader = true);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  _showPopUp({BuildContext ctx}) {
    Alert(
        style: AlertStyle(
          backgroundColor: Color(0xFFFFD552),
          titleStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        context: ctx,
        title: "ELEGIRLA UBICACIÓN",
        content: Container(
          height: 400,
          width: 500,
          child: ListView.builder(
            itemBuilder: (ctx, i) {
              return Column(
                children: [
                  InkWell(
                          onTap: () {
                            setState(() {
                              _initialLocationVal = _delvAddress[i];
                              _selectedAddress = _delvAddress[i];
                            });
                            Navigator.of(ctx).pop();
                          },
                          child: "${_delvAddress[i]}".text.make())
                      .p(10),
                  Divider(
                    color: Colors.green,
                    thickness: 2,
                  )
                ],
              );
            },
            itemCount: _delvAddress.length,
          ),
        )).show();
  }

  @override
  void initState() {
    getTimeAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
            child: Image.asset(
              'assets/images/back-ico.png',
              height: 4,
              width: 4,
            ),
            onTap: () => Navigator.pop(context),
          ),
          // actions: [CartIcon().p(12)],
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Checkout".text.make(),
              // "Baishnab para Santipur Nadia".text.size(10).make(),
            ],
          ),
          // leading: Icon(Icons.ac_unit),
        ),
        body: loader
            ? Container(
                child: Column(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              tabbar = true;
                            });
                          },
                          child: Container(
                              height: 45,
                              color: tabbar ? kPrimaryColor : Color(0xFFB0E0CA),
                              alignment: Alignment.center,
                              child: "DELEVERY TO HOME"
                                  .text
                                  .textStyle(GoogleFonts.openSans())
                                  .bold
                                  .white
                                  .letterSpacing(-0.2)
                                  .uppercase
                                  .make()
                                  .p(10)),
                        ),
                        SizedBox(width: 25),
                        InkWell(
                          onTap: () {
                            setState(() {
                              tabbar = false;
                            });
                          },
                          child: Container(
                              color: tabbar ? Color(0xFFB0E0CA) : kPrimaryColor,
                              height: 45,
                              child: "pick form carribian"
                                  .text
                                  .uppercase
                                  .textStyle(GoogleFonts.openSans())
                                  .bold
                                  .white
                                  .letterSpacing(-0.2)
                                  .makeCentered()
                                  .p(10)),
                        )
                      ],
                    ).pOnly(bottom: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BannerWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        tabbar
                            ? Container(
                                color: Colors.white,
                                height:
                                    MediaQuery.of(context).size.height * 0.489,
                                // width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    "RESUMEN DEL PEDIDO"
                                        .text
                                        .bold
                                        .make()
                                        .pOnly(bottom: 20),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      // width: MediaQuery.of(context).size.width * 0.50,
                                      child: RadioGroup<dynamic>.builder(
                                        groupValue: _verticalGroupValue,
                                        onChanged: (value) => setState(() {
                                          _verticalGroupValue = value;
                                        }),
                                        items: _timeList,
                                        itemBuilder: (item) =>
                                            RadioButtonBuilder(
                                          item,
                                        ),
                                      ),
                                    ),
                                  ],
                                ).pOnly(
                                    left: 20,
                                    right: 20,
                                    top: 20), //.pOnly(left: 20, top: 20),
                              )
                            : Container(
                                color: Colors.white,
                                height:
                                    MediaQuery.of(context).size.height * 0.489,
                                child: Center(
                                    child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width:
                                      MediaQuery.of(context).size.width * 0.850,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFD552),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: ListTile(
                                    onTap: () => _showPopUp(ctx: context),
                                    title: _initialLocationVal.text.bold.make(),
                                    trailing: Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                )),
                              )
                      ],
                    ).pOnly(left: 10, right: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.08,
                              color: Color(0xFF2DB573),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  "Total :"
                                      .text
                                      .color(Colors.grey[200])
                                      .textStyle(GoogleFonts.openSans())
                                      .bold
                                      .make(),
                                  "\$ 200"
                                      .text
                                      .bold
                                      .white
                                      .textStyle(GoogleFonts.openSans())
                                      .xl2
                                      .make()
                                ],
                              )),
                        ),
                        Expanded(
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              color: Color(0xFFFFD553),
                              alignment: Alignment.center,
                              child: "PAY NOW"
                                  .text
                                  .bold
                                  .textStyle(GoogleFonts.openSans())
                                  .make()),
                        )
                      ],
                    )
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}

// Row(
//   children: [
//     Expanded(
//       child: Container(
//           alignment: Alignment.center,
//           height: MediaQuery.of(context).size.height * 0.07,
//           color: Color(0xFF2DB573),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               "Total :".text.color(Colors.grey[200]).bold.make(),
//               "\$ : 200".text.bold.white.xl2.make()
//             ],
//           )),
//     ),
//     Expanded(
//       child: Container(
//           height: MediaQuery.of(context).size.height * 0.07,
//           color: Color(0xFFFFD553),
//           alignment: Alignment.center,
//           child: "PAY NOW".text.bold.make()),
//     )
//   ],
// )

// ListView.builder(
//   itemBuilder: (_, i) {
//     return InkWell(
//       onTap: () {
//         // setState(() {
//         if (_time == true) {
//           setState(() {
//             _time = false;
//           });
//         } else {
//           setState(() {
//             _time = true;
//           });
//         }
//         // });
//       },
//       // child: PaymentContainer(
//       //   setColor: kPrimaryColor,
//       //   // isSelect: _time,
//       //   string: "$i",
//       // ),
//       child: RadioGroup<String>.builder(
//         groupValue: _verticalGroupValue,
//         onChanged: (value) => setState(() {
//           _verticalGroupValue = value;
//         }),
//         items: _status,
//         itemBuilder: (item) => RadioButtonBuilder(
//           item,
//         ),
//       ),
//     );
//   },
//   // children: [
//   //   PaymentContainer(
//   //     setColor: kPrimaryColor,
//   //     isSelect: _selectionMethod,
//   //     string: "Billetera upi",
//   //   ),
//   //   PaymentContainer(
//   //     setColor: kPrimaryColor,
//   //     isSelect: !_selectionMethod,
//   //     string: "Banca neta",
//   //   ),
//   //   // PaymentContainer(
//   //   //   setColor: kPrimaryColor,
//   //   //   isSelect: !_selectionMethod,
//   //   //   string: "Tarjeta de crédito / débito / cajero automático",
//   //   // ),
//   //   PaymentContainer(
//   //     setColor: kPrimaryColor,
//   //     isSelect: !_selectionMethod,
//   //     string: "Contra reembolso",
//   //   ),
//   // ],
// ),
