import 'package:FreshOnTheGo/Custome_Widget/cartwidget.dart';
import 'package:FreshOnTheGo/Screens/LoginPage.dart';
import 'package:FreshOnTheGo/Screens/MiddleProductPage.dart';
import 'package:FreshOnTheGo/Screens/SearchPage.dart';
import 'package:FreshOnTheGo/utils/prefs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:FreshOnTheGo/Custome_Widget/CustomDrawer.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:FreshOnTheGo/Screens/MyCart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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

  List data;
  String uid;
  getCartData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = _prefs.getString('uid');
      loader = false;
    });
    var response = await http.get(
        "https://mercadosagricolaspr.com/farmer-new/apis/product/searchproductbycatagory_6prod?limit=6");
    setState(() {
      var getResponse = jsonDecode(response.body);
      data = getResponse['data'];
      print("==================================================");
      print(data);
      loader = true;
    });
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
          print("==================");
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
    getIconVal();
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
          Consumer<PrefsUtils>(builder: (context, snapshot, _) {
            return GestureDetector(
                onTap: () => snapshot.uid != null
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MyCartPage()))
                    : Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginPage())),
                child: snapshot.uid != null
                    ? CartIconHome().p(10)
                    : ZeroCartIconHome().p(10));
          }),
        ],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Tu Mercado Agrícola"
                .text
                .size(10)
                .textStyle(GoogleFonts.openSans())
                .make(),
            ""
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
                  child: "Categoria"
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
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.50,
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, i) {
                              return ExpansionTileCard(
                                baseColor: Colors.grey[300],
                                expandedColor: Colors.grey[200],
                                // key: cardB,
                                leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(90),
                                    child: Image.network(
                                      '${data[i]['c_img']}',
                                      fit: BoxFit.cover,
                                    )),
                                title: '${data[i]['category']}'
                                    .text
                                    .size(14)
                                    .textStyle(GoogleFonts.openSans())
                                    .black
                                    .make(),
                                subtitle: '${data[i]['cdesc']}'
                                    .text
                                    .black
                                    .textStyle(GoogleFonts.openSans())
                                    .size(5)
                                    .make(),
                                initiallyExpanded: true,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.27,
                                    child: GridView.builder(
                                      itemCount: data[i]['cdata'].length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3),
                                      itemBuilder: (_, gi) {
                                        print(data[i]);
                                        return InkWell(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ProductPage(
                                                  cid: data[i]['cdata'][gi]
                                                      ['cid']),
                                            ),
                                          ),
                                          child: Container(
                                              margin: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.5,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              child: Image.network(
                                                data[i]['cdata'][gi]['image'],
                                                fit: BoxFit.cover,
                                              )),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ).p(20);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
