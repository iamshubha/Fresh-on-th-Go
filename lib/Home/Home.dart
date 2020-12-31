import 'package:FreshOnTheGo/Custome_Widget/cartwidget.dart';
import 'package:FreshOnTheGo/Home/Menu.dart';
import 'package:FreshOnTheGo/Screens/SearchPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:FreshOnTheGo/Custome_Widget/CustomDrawer.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:FreshOnTheGo/Screens/MyCart.dart';
import 'package:FreshOnTheGo/Screens/ProductDetails.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  bool loader = true;
  var data;
  String uid;
  getCartData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = _prefs.getString('uid');
      loader = false;
    });
    var response = await http.get(
        "http://888travelthailand.com/farmers/apis/product/searchproductbycatagory_6prod?limit=6");
    setState(() {
      var getResponse = jsonDecode(response.body);
      data = getResponse['data'];
      getIconVal();
      loader = true;
    });
  }

  int iconval = 0;
  getIconVal() async {
    final _prefs = await SharedPreferences.getInstance();
    final uid = _prefs.getString('uid');
    try {
      String url =
          "http://888travelthailand.com/farmers/apis/order/showcart_byuid?uid=$uid";
      final response = await http.get(url);
      var rsp = jsonDecode(response.body);
      if (rsp['status']) {
        setState(() {
          iconval = rsp['data'].length;
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
    getCartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SearchPage()))),
          GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MyCartPage())),
              child: CartIcon(val: iconval).p(10)),
        ],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "LUGAR DE ENTERGA"
                .text
                .size(10)
                .textStyle(GoogleFonts.openSans())
                .make(),
            "B-12 TOURCHTHREETEEN, SEC-15, PARTUGAL"
                .text
                .size(3)
                .textStyle(GoogleFonts.openSans())
                .make(),
          ],
        ),
        // leading: Icon(Icons.ac_unit),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        // physics:
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
              ),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  'assets/images/app-banner.png',
                  fit: BoxFit.cover,
                ),
              ).pOnly(left: 20, right: 20, bottom: 20, top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   width: MediaQuery.of(context).size.width * 0.32,
                //   alignment: Alignment.center,
                //   child: "Oferta del día"
                //       .text
                //       .textStyle(GoogleFonts.openSans())
                //       .make(),
                // ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: kPrimaryColor),
                  // height: 20,
                  height: MediaQuery.of(context).size.height * 0.045,
                  // width: MediaQuery.of(context).size.width * 0.40,
                  alignment: Alignment.center,
                  child: "Categorias"
                      .text
                      .textStyle(GoogleFonts.openSans())
                      .white
                      .make(),
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width * 0.32,
                //   alignment: Alignment.center,
                //   child:
                //       "Favoritos".text.textStyle(GoogleFonts.openSans()).make(),
                // )
              ],
            ),
            loader == true
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ExpansionTileCard(
                          baseColor: Colors.grey[300],
                          expandedColor: Colors.grey[200],
                          // key: cardB,
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: Image.network(
                                '${data[0]['c_img']}',
                                fit: BoxFit.cover,
                              )),
                          title: '${data[0]['category']}'
                              .text
                              .size(14)
                              .textStyle(GoogleFonts.openSans())
                              .black
                              .make(),
                          subtitle: 'Verduras frescas para ti.'
                              .text
                              .black
                              .textStyle(GoogleFonts.openSans())
                              .size(5)
                              .make(),
                          initiallyExpanded: true,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductDetailsPage(
                                                cid: data[0]['cdata'][0]['cid'],
                                                pid: data[0]['cdata'][0]['pid'],
                                              ))),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Image.network(
                                        data[0]['cdata'][0]['image'],
                                        fit: BoxFit.cover,
                                      )).pOnly(left: 10),
                                ),
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductDetailsPage(
                                              cid: data[0]['cdata'][1]['cid'],
                                              pid: data[0]['cdata'][1]
                                                  ['pid']))),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Image.network(
                                        data[0]['cdata'][1]['image'],
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductDetailsPage(
                                              cid: data[0]['cdata'][2]['cid'],
                                              pid: data[0]['cdata'][2]
                                                  ['pid']))),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Image.network(
                                        data[0]['cdata'][2]['image'],
                                        fit: BoxFit.cover,
                                      )).pOnly(right: 10),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductDetailsPage(
                                              cid: data[0]['cdata'][3]['cid'],
                                              pid: data[0]['cdata'][3]
                                                  ['pid']))),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Image.network(
                                        data[0]['cdata'][3]['image'],
                                        fit: BoxFit.cover,
                                      )).pOnly(left: 10),
                                ),
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductDetailsPage(
                                              cid: data[0]['cdata'][4]['cid'],
                                              pid: data[0]['cdata'][4]
                                                  ['pid']))),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Image.network(
                                        data[0]['cdata'][4]['image'],
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductDetailsPage(
                                              cid: data[0]['cdata'][5]['cid'],
                                              pid: data[0]['cdata'][5]
                                                  ['pid']))),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Image.network(
                                        data[0]['cdata'][5]['image'],
                                        fit: BoxFit.cover,
                                      )).pOnly(right: 10),
                                ),
                              ],
                            ).pOnly(bottom: 10),
                          ],
                        ).p(20),
                        ExpansionTileCard(
                          baseColor: Colors.grey[300],
                          expandedColor: Colors.grey[200], // key: cardB,
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: Image.network(
                                '${data[1]['c_img']}',
                                fit: BoxFit.cover,
                              )),
                          title: '${data[1]['category']}'
                              .text
                              .size(14)
                              .textStyle(GoogleFonts.openSans())
                              .black
                              .make(),
                          subtitle: 'Verduras frescas para ti.'
                              .text
                              .black
                              .textStyle(GoogleFonts.openSans())
                              .size(5)
                              .make(),
                          initiallyExpanded: true,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductDetailsPage(
                                                cid: data[1]['cdata'][0]['cid'],
                                                pid: data[1]['cdata'][0]['pid'],
                                              ))),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Image.network(
                                        data[1]['cdata'][0]['image'],
                                        fit: BoxFit.cover,
                                      )).pOnly(left: 10),
                                ),
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductDetailsPage(
                                              cid: data[1]['cdata'][1]['cid'],
                                              pid: data[1]['cdata'][1]
                                                  ['pid']))),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Image.network(
                                        data[1]['cdata'][1]['image'],
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductDetailsPage(
                                              cid: data[1]['cdata'][2]['cid'],
                                              pid: data[1]['cdata'][2]
                                                  ['pid']))),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Image.network(
                                        data[1]['cdata'][2]['image'],
                                        fit: BoxFit.cover,
                                      )).pOnly(right: 10),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductDetailsPage(
                                              cid: data[1]['cdata'][3]['cid'],
                                              pid: data[1]['cdata'][3]
                                                  ['pid']))),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Image.network(
                                        data[1]['cdata'][3]['image'],
                                        fit: BoxFit.cover,
                                      )).pOnly(left: 10),
                                ),
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductDetailsPage(
                                              cid: data[1]['cdata'][4]['cid'],
                                              pid: data[1]['cdata'][4]
                                                  ['pid']))),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Image.network(
                                        data[1]['cdata'][4]['image'],
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductDetailsPage(
                                              cid: data[1]['cdata'][5]['cid'],
                                              pid: data[1]['cdata'][5]
                                                  ['pid']))),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Image.network(
                                        data[1]['cdata'][5]['image'],
                                        fit: BoxFit.cover,
                                      )).pOnly(right: 10),
                                ),
                              ],
                            ).pOnly(bottom: 10),
                          ],
                        ).p(20),
                        InkWell(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Menu())),
                          child: Container(
                            height: 50,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xFFFFD456),
                                borderRadius: BorderRadius.circular(30)),
                            child: "Más".text.bold.make(),
                          ),
                        )
                        //; }),
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
