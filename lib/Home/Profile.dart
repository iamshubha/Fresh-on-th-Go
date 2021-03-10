import 'dart:convert';
import 'package:FreshOnTheGo/Custome_Widget/cartwidget.dart';
import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Custome_Widget/CustomDrawer.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:FreshOnTheGo/Screens/ContactUs.dart';
import 'package:FreshOnTheGo/Screens/LoginPage.dart';
import 'package:FreshOnTheGo/Screens/MyCart.dart';
import 'package:FreshOnTheGo/Screens/OderList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool loader = false;
  String uid;
  var data;
  // CounterProvider _counterProvider = CounterProvider();
  getDataFromServer() async {
    final _prefs = await SharedPreferences.getInstance();
    uid = _prefs.getString('uid');
    String url =
        "https://mercadosagricolaspr.com/farmer-new/apis/customer/get_details_by_id?id=$uid";
    final response = await http.get(url);
    setState(() {
      data = jsonDecode(response.body);
      loader = true;
    });
    print(data);
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
          print(data);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getIconVal();
    getDataFromServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: "Perfil de Usuário".text.make(),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset(
                'assets/images/menu.png',
              ).p(5),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MyCartPage())),
              child: CartIconHome().p(10))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
            child: loader == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      Container(
                        color: Colors.transparent,
                        // height: MediaQuery.of(context).size.height * 0.18,
                        // width: MediaQuery.of(context).size.width * 0.3,
                        // decoration: BoxDecoration(
                        //     color: Colors.yellow,
                        //     borderRadius: BorderRadius.circular(1000)),
                        child: Image.asset(
                          'usernameico.png',
                          fit: BoxFit.cover,
                        ),
                      ).pOnly(
                          bottom: 50,
                          top: MediaQuery.of(context).size.height * 0.051),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.06,
                      ),

                      //   ],
                      // ),
                      Divider(
                        color: Colors.white,
                        thickness: 1.7,
                      ).pOnly(
                          left: MediaQuery.of(context).size.width * 0.08,
                          right: MediaQuery.of(context).size.width * 0.08),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "${data['data'][0]['email']}"
                              .text
                              .xl
                              .white
                              .extraBold
                              .textStyle(GoogleFonts.openSans())
                              .make(),
                          // Expanded(child: SizedBox()),
                          // "Editar Perfil"
                          //     .text
                          //     .xl
                          //     .white
                          //     .textStyle(GoogleFonts.openSans())
                          //     .extraBold
                          //     .make()
                        ],
                      ).pOnly(
                          left: MediaQuery.of(context).size.width * 0.15,
                          right: MediaQuery.of(context).size.width * 0.15),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green[400],
                    ),
                  ),
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.38,
            child: ListView(
              children: [
                ListTile(
                  leading: Image.asset('assets/images/order-list.png'),
                  title: "Lista de Pedidos".text.make(),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => OrderListPage())),
                ).pOnly(top: 10),
                // ListTile(
                //   leading: Image.asset('assets/images/account-details.png'),
                //   title: "Detalles de Cuenta".text.make(),
                // ).pOnly(top: 10),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ContactUsPage()));
                  },
                  leading: Image.asset('assets/images/helpsupport.png'),
                  title: "Ayuda & Apoyo".text.make(),
                ).pOnly(top: 10),
                ListTile(
                    leading: Image.asset('assets/images/logout.png'),
                    title: "Cerrar Sessión".text.make(),
                    onTap: () async {
                      final _prefs = await SharedPreferences.getInstance();
                      _prefs.clear();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => LoginPage()));
                    }).pOnly(top: 10),
              ],
            ),
          ).pOnly(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.03)
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
