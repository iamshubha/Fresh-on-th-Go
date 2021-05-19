import 'dart:convert';

import 'package:FreshOnTheGo/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:FreshOnTheGo/Screens/HomePage.dart';
import 'package:FreshOnTheGo/Screens/LoginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List data = [];
  bool loader = true;
  // String uid;
  getData() async {
    final _prefs = await SharedPreferences.getInstance();
    final uid = _prefs.getString('uid');
    try {
      String url =
          "https://mercadosagricolaspr.com/farmer-new/apis/order/show_latest_order_add_time?uid=$uid";
      final response = await http.get(url);
      var rsp = jsonDecode(response.body);
      if (rsp['status']) {
        setState(() {
          data = rsp['data'];
          loader = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    loader = false;
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _prefs = Provider.of<PrefsUtils>(context, listen: false);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(
                    "assets/images/menu-bottom.png",
                    fit: BoxFit.cover,
                  ),
                ).pOnly(right: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<PrefsUtils>(
                      // stream: null,
                      builder: (context, snapshot,_) {
                        return snapshot.name ==null? Container(
                          child: "Hola Bienvenido a: \nTu Mercado Agrìcola"
                              .text
                              .bold
                              .size(10)
                              .textStyle(GoogleFonts.openSans())
                              .make(),
                        ):Container(
                          width: MediaQuery.of(context).size.width*0.35,
                          child: "Hola ${snapshot.name} bienvenidos a \nFresh on the go"
                              .text
                              .bold
                              .size(10)
                              .textStyle(GoogleFonts.openSans())
                              .make(),
                        );
                      }
                    ),
                    // "Nombre de Usuário"
                    //     .text
                    //     .bold
                    //     .size(10)
                    //     .textStyle(GoogleFonts.openSans())
                    //     .make(),
                    // "Título: Sr. Sra, Srta"
                    //     .text
                    //     .size(10)
                    //     .textStyle(GoogleFonts.openSans())
                    //     .make(),
                    // "Direcclón : lorem Ipsum"
                    //     .text
                    //     .size(10)
                    //     .textStyle(GoogleFonts.openSans())
                    //     .make(),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(color: kPrimaryColor),
          ),
          // Consumer<PrefsUtils>(

          //   builder: (context, preoviderprefs, child) {
          //     return Container(child:
          //     _prefs.uid != null
          //         ? loader == true
          //             ? ListTile(
          //                 leading: Image.asset(
          //                   'assets/images/delevery-ico.png',
          //                   fit: BoxFit.contain,
          //                   height: MediaQuery.of(context).size.height * 0.065,
          //                 ).p(5),
          //                 title: Text("Detalles de la Entrega"),
          //                 onTap: () {
          //                   showDialog(
          //                       context: context,
          //                       child: AlertDialog(
          //                         title: Text("Detalles de la Entrega"),
          //                         content: Container(
          //                           height:
          //                               MediaQuery.of(context).size.height * 0.50,
          //                           width: MediaQuery.of(context).size.width * 0.70,
          //                           child: Column(children: [
          //                             Container(
          //                                     decoration: BoxDecoration(
          //                                         // color: kPrimaryColor,
          //                                         borderRadius: BorderRadius.all(
          //                                             Radius.circular(10))),
          //                                     child: Container(
          //                                       alignment: Alignment.center,
          //                                       width: MediaQuery.of(context)
          //                                               .size
          //                                               .width *
          //                                           0.37,
          //                                       child: Column(
          //                                         children: [
          //                                           "Address: "
          //                                               .text
          //                                               .bold
          //                                               .black
          //                                               .make(),
          //                                           "${data[0]['delivery_address']}"
          //                                               .text
          //                                               // .textStyle(TextStyle(fontSize: 6))
          //                                               .textStyle(
          //                                                   GoogleFonts.openSans())
          //                                               .bold
          //                                               .make(),
          //                                         ],
          //                                       ),
          //                                     ).p(40))
          //                                 .p(10),
          //                             Container(
          //                                     decoration: BoxDecoration(
          //                                         // color: kPrimaryColor,
          //                                         borderRadius: BorderRadius.all(
          //                                             Radius.circular(10))),
          //                                     child: Container(
          //                                       alignment: Alignment.center,
          //                                       // width:
          //                                       //     MediaQuery.of(context).size.width *
          //                                       //         0.7,
          //                                       child: Column(
          //                                         children: [
          //                                           "Time: ".text.bold.black.make(),
          //                                           "${data[0]['delivery_time']}"
          //                                               .text
          //                                               // .textStyle(TextStyle(fontSize: 6))
          //                                               .textStyle(
          //                                                   GoogleFonts.openSans())
          //                                               .bold
          //                                               .make(),
          //                                         ],
          //                                       ),
          //                                     ).p(10))
          //                                 .p(10),
          //                             Container(
          //                                     decoration: BoxDecoration(
          //                                         // color: kPrimaryColor,
          //                                         borderRadius: BorderRadius.all(
          //                                             Radius.circular(10))),
          //                                     child: Container(
          //                                       alignment: Alignment.center,
          //                                       // width:
          //                                       //     MediaQuery.of(context).size.width *
          //                                       //         0.37,
          //                                       child: Column(
          //                                         children: [
          //                                           "Delivery On: "
          //                                               .text
          //                                               .bold
          //                                               .black
          //                                               .make(),
          //                                           "${data[0]['delivery_on']}"
          //                                               .text
          //                                               // .textStyle(TextStyle(fontSize: 6))
          //                                               .textStyle(
          //                                                   GoogleFonts.openSans())
          //                                               .bold
          //                                               .make(),
          //                                         ],
          //                                       ),
          //                                     ).p(10))
          //                                 .p(10),
          //                           ]),
          //                         ),
          //                         actions: [
          //                           FlatButton(
          //                             onPressed: () {
          //                               Navigator.pop(context);
          //                             },
          //                             child: Text('Cancel'),
          //                           ),
          //                         ],
          //                       ));
          //                 })
          //             : Center(child: CircularProgressIndicator())
          //         : Container());
          //   }
          // ),

          ListTile(
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomePage())),
            leading: Image.asset("assets/images/menu-icon.png"),
            title: "CATEGORIA".text.textStyle(GoogleFonts.openSans()).make(),
          ),
          _prefs.uid != null ? Divider() : Container(),
          _prefs.uid != null
              ? ListTile(
                  leading: Image.asset("assets/images/menu-icon.png"),
                  title: "Cerrar Sessión"
                      .text
                      .uppercase
                      .textStyle(GoogleFonts.openSans())
                      .make(),
                  onTap: () async {
                    final _prefs = await SharedPreferences.getInstance();
                    _prefs.clear();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => HomePage()),
                        (r) => false);
                  },
                )
              : Container(),
          Divider(),
          _prefs.uid == null
              ? ListTile(
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => LoginPage())),
                  leading: Image.asset("assets/images/menu-icon.png"),
                  title: "Acceso / Registro".text.uppercase.textStyle(GoogleFonts.openSans()).make(),
                )
              : Container(),
          _prefs.uid == null ? Divider() : Container(),
        ],
      ),
      elevation: 0,
    );
  }
}
