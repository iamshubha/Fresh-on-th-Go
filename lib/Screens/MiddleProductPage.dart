import 'dart:convert';

import 'package:FreshOnTheGo/Custome_Widget/cartwidget.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:FreshOnTheGo/Screens/LoginPage.dart';
import 'package:FreshOnTheGo/Screens/MyCart.dart';
import 'package:FreshOnTheGo/Screens/ProductDetails.dart';
import 'package:FreshOnTheGo/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

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
        // leading: InkWell(
        //   child: Image.asset(
        //     'assets/images/back-ico.png',
        //     // height: 4,
        //     // width: 4,
        //   ).p(5),
        //   onTap: () => Navigator.pop(context),
        // ),
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
          })
        ],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Caribbean Produce Exchange"
                .text
                .size(10)
                .textStyle(GoogleFonts.openSans())
                .make(),
            "Calle 869 KM 2.8 Interior Las Palmas Cataño, PR 00962"
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
              height: MediaQuery.of(context).size.height * 0.80,
              width: MediaQuery.of(context).size.width,
              child: data.length != null
                  ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductDetailsPage(
                                      price: data[i]['sell_price'],
                                      cid: data[i]['category'], //category
                                      pid: data[i]['name']))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
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
                                        "\$: ${data[i]['sell_price']} / ${data[i]['unit']}"
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
                          ),
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
