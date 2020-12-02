import 'package:expansion_tile_card/expansion_tile_card.dart';
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
              decoration: BoxDecoration(
                color: Color(0xFF5BB774),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
              ),
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  'assets/images/app-banner.png',
                  fit: BoxFit.fitWidth,
                ),
              ).pOnly(left: 20, right: 20, bottom: 20, top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: "OFFER DEl HOY".text.make(),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Color(0xFF5BB774)),
                  // height: 20,
                  height: MediaQuery.of(context).size.height * 0.045,
                  width: MediaQuery.of(context).size.width * 0.40,
                  alignment: Alignment.center,
                  child: "Categorias".text.white.make(),
                ),
                Container(
                  alignment: Alignment.center,
                  child: "FAVORITE".text.size(10).make(),
                )
              ],
            ).pOnly(right: 25, left: 25),
            Container(
              // color: Colors.red,
              // height: MediaQuery.of(context).size.height * 0.40,
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
                          Container(
                              height: MediaQuery.of(context).size.height * 0.10,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Image.asset(
                                'assets/images/veg1.png',
                                fit: BoxFit.cover,
                              )).pOnly(left: 10),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.10,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Image.asset(
                                'assets/images/veg2.png',
                                fit: BoxFit.cover,
                              )),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.10,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Image.asset(
                                'assets/images/veg3.png',
                                fit: BoxFit.cover,
                              )).pOnly(right: 10),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.10,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Image.asset(
                                'assets/images/veg4.png',
                                fit: BoxFit.cover,
                              )).pOnly(left: 10),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.10,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Image.asset(
                                'assets/images/veg5.png',
                                fit: BoxFit.cover,
                              )),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.10,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Image.asset(
                                'assets/images/veg6.png',
                                fit: BoxFit.cover,
                              )).pOnly(right: 10),
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
