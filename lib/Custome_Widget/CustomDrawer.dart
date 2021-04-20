import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:FreshOnTheGo/Screens/HomePage.dart';
import 'package:FreshOnTheGo/Screens/LoginPage.dart';
import 'package:google_fonts/google_fonts.dart';
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
                    "Nombre de Usuário"
                        .text
                        .bold
                        .size(10)
                        .textStyle(GoogleFonts.openSans())
                        .make(),
                    "Título: Sr. Sra, Srta"
                        .text
                        .size(10)
                        .textStyle(GoogleFonts.openSans())
                        .make(),
                    "Direcclón : lorem Ipsum"
                        .text
                        .size(10)
                        .textStyle(GoogleFonts.openSans())
                        .make(),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(color: kPrimaryColor),
          ),
          Container(
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(70))),
            height: MediaQuery.of(context).size.height * 0.08,
            child: loader == true
                ? Row(
                    children: [
                      Image.asset(
                        'assets/images/delevery-ico.png',
                        fit: BoxFit.contain,
                      ).p(5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "${data[0]['delivery_address']}"
                              .text
                              .size(1)
                              .textStyle(GoogleFonts.openSans())
                              .bold
                              .make(),
                          "${data[0]['delivery_time']}"
                              .text
                              .white
                              .textStyle(GoogleFonts.openSans())
                              .bold
                              .make()
                        ],
                      )
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
          ).p(10),
          ListTile(
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomePage())),
            leading: Image.asset("assets/images/menu-icon.png"),
            title: "CATEGORIAS".text.textStyle(GoogleFonts.openSans()).make(),
          ),
          Divider(),
          ListTile(
            leading: Image.asset("assets/images/menu-icon.png"),
            title: "Cerrar Sessión"
                .text
                .uppercase
                .textStyle(GoogleFonts.openSans())
                .make(),
            onTap: () async {
              final _prefs = await SharedPreferences.getInstance();
              _prefs.clear();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
          ),
          Divider()
        ],
      ),
      elevation: 0,
    );
  }
}
