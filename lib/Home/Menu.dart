import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:fresh_on_the_go/Custome_Widget/const.dart';
import 'package:fresh_on_the_go/Screens/ProductDetails.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: kPrimaryColor,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Container(
                // width: MediaQuery.of(context).size.width*0.80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: TextFormField(
                      decoration: InputDecoration( hintText: "Buscar producto",
                        border: InputBorder.none,
                        prefixIcon: Image.asset('assets/images/search.png').p(10)
                      ),
                    ),
              ).pOnly(left:MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),
            ),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.32,
                  alignment: Alignment.center,
                  child: "OFFER DEl HOY".text.make(),
                ),
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
                  child: "Categorias".text.white.make(),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.32,
                  alignment: Alignment.center,
                  child: "FAVORITE".text.make(),
                )
              ],
            )
            // .pOnly(right: 25, left: 25)
            ,
            Container(
              child: Column(
                children: [
                  ExpansionTileCard(
                    baseColor: Colors.grey[800],
                    expandedColor: Colors.grey[200],
                    key: cardB,
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Image.asset(
                          'assets/images/titleicon.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        )),
                    title: 'VEGETALES FRESCOS'.text.size(14).black.make(),
                    subtitle:
                        'FRESH VAGITABLE PARAA TI'.text.black.size(5).make(),
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
                                    builder: (_) => ProductDetailsPage())),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Image.asset(
                                  'assets/images/veg1.png',
                                  fit: BoxFit.cover,
                                )).pOnly(left: 10),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductDetailsPage())),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Image.asset(
                                  'assets/images/veg2.png',
                                  fit: BoxFit.cover,
                                )),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductDetailsPage())),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Image.asset(
                                  'assets/images/veg3.png',
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
                                    builder: (_) => ProductDetailsPage())),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Image.asset(
                                  'assets/images/veg4.png',
                                  fit: BoxFit.cover,
                                )).pOnly(left: 10),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductDetailsPage())),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Image.asset(
                                  'assets/images/veg5.png',
                                  fit: BoxFit.cover,
                                )),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductDetailsPage())),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Image.asset(
                                  'assets/images/veg6.png',
                                  fit: BoxFit.cover,
                                )).pOnly(right: 10),
                          ),
                        ],
                      ).pOnly(bottom: 10),
                    ],
                  ).p(20)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
