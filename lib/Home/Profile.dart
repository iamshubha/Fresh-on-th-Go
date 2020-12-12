import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fresh_on_the_go/Custome_Widget/CustomDrawer.dart';
import 'package:fresh_on_the_go/Custome_Widget/const.dart';
import 'package:fresh_on_the_go/Screens/LoginPage.dart';
import 'package:fresh_on_the_go/Screens/MyCart.dart';
import 'package:fresh_on_the_go/Screens/OderList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool loader = false;
  String uid = "17";
  var data;
  getDataFromServer() async {
    String url =
        "http://my-demo.xyz/farmers/apis/customer/get_details_by_id?id=$uid";
    final response = await http.get(url);
    setState(() {
      data = jsonDecode(response.body);
      loader = true;
    });
    print(data);
  }

  @override
  void initState() {
    super.initState();
    getDataFromServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
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
              child: Image.asset(
                'assets/images/cart.png',
                fit: BoxFit.contain,
              ).p(10))
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.18,
                            width: MediaQuery.of(context).size.width * 0.3,
                            // decoration: BoxDecoration(
                            //     color: Colors.yellow,
                            //     borderRadius: BorderRadius.circular(1000)),
                            child: ClipOval(
                                child: Image.network(
                              '${data['data'][0]['profile_img']}',
                              fit: BoxFit.cover,
                            )),
                          ).pOnly(bottom: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['data'][0]['name']}"
                                    .text
                                    .white
                                    .xl
                                    .extraBold
                                    .textStyle(GoogleFonts.openSans())
                                    .make()
                                    .pOnly(bottom: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on),
                                    "${data['data'][0]['address']}"
                                        .text
                                        .textStyle(GoogleFonts.openSans())
                                        .make()
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1.7,
                      ).pOnly(
                          left: MediaQuery.of(context).size.width * 0.08,
                          right: MediaQuery.of(context).size.width * 0.08),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "155 Pedidos"
                              .text
                              .xl
                              .white
                              .extraBold
                              .textStyle(GoogleFonts.openSans())
                              .make(),
                          Expanded(child: SizedBox()),
                          "Editar Perfil"
                              .text
                              .xl
                              .white
                              .textStyle(GoogleFonts.openSans())
                              .extraBold
                              .make()
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
                ListTile(
                  leading: Image.asset('assets/images/account-details.png'),
                  title: "Detalles de Cuenta".text.make(),
                ).pOnly(top: 10),
                ListTile(
                  leading: Image.asset('assets/images/helpsupport.png'),
                  title: "Ayuda & Apoyo".text.make(),
                ).pOnly(top: 10),
                ListTile(
                  leading: Image.asset('assets/images/logout.png'),
                  title: "Carrar Sessión".text.make(),
                  onTap: () => Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => LoginPage())),
                ).pOnly(top: 10),
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
}