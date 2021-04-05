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
          GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MyCartPage())),
              child: CartIconHome().p(10)), //TODO:send data of total
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
                                subtitle: 'Verduras frescas para ti.'
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
                                      // padding: EdgeInsets.only(
                                      //     left: 20, right: 20),
                                      //itemCount: 3,
                                      itemCount: data[i]['cdata'].length,

                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3

                                              // (orientation ==
                                              //         Orientation.portrait)
                                              //     ? 3
                                              //     : 3,
                                              //crossAxisCount: 3,
                                              ),
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
                                            // ProductDetailsPage(
                                            //     //TODO:Work here
                                            //     cid: data[i]
                                            //         [' category'],
                                            //     // [gi]['cid'],
                                            //     pid: data[i]['cdata']
                                            //         [gi]['name']),
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

class ProductPage extends StatefulWidget {
  final String cid;
  ProductPage({this.cid});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool loader = true;
  List data = [];
  fetchDataWithCatType() async {
    setState(() {
      loader = false;
    });

    var response = await http.get(
        "https://mercadosagricolaspr.com/farmer-new/apis/product/searchproductbycatagory?cid=${widget.cid}");
    print(
        "https://mercadosagricolaspr.com/farmer-new/apis/product/searchproductbycatagory?cid=${widget.cid}");
    setState(() {
      var getResponse = jsonDecode(response.body);
      if (getResponse["status"]) {
        data = getResponse['data'];
      } else {
        data = [];
      }
      print(getResponse);
      loader = true;
    });
  }

  @override
  void initState() {
    fetchDataWithCatType();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: InkWell(
          child: Image.asset(
            'assets/images/back-ico.png',
            // height: 4,
            // width: 4,
          ).p(5),
          onTap: () => Navigator.pop(context),
        ),
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: Image.asset(
        //         'assets/images/menu.png',
        //       ).p(5),
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //     );
        //   },
        // ),
        actions: [
          GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MyCartPage())),
              child: CartIconHome().p(10))
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
      body: loader == true
          ? Container(
              height: MediaQuery.of(context).size.height * 0.544,
              width: MediaQuery.of(context).size.width,
              child: data.length != null
                  ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ProductDetailsPage(
                                          cid: data[i]['category'], //category
                                          pid: data[i]['name']))),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "${data[i]['image']}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ).p(18),
                            ),
                            Container(
                              // width: MediaQuery.of(context).size.width * 0.,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  "${data[i]['name']}"
                                      .text
                                      .textStyle(GoogleFonts.openSans())
                                      .size(8)
                                      .make()
                                      .pOnly(bottom: 5),
                                  // "${data[i]['category']}"
                                  //     .text
                                  //     .textStyle(GoogleFonts.openSans())
                                  //     .bold
                                  //     .make()
                                  //     .pOnly(bottom: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      "\$: ${data[i]['cost_price']} / ${data[i]['unit']}"
                                          .text
                                          .textStyle(GoogleFonts.openSans())
                                          .xl
                                          .make(),
                                    ],
                                  )
                                ],
                                // ),
                              ),
                            ).pOnly(top: 30)
                          ],
                        );
                      },
                    )
                  : Center(
                      child: "No Data".text.make(),
                    ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
