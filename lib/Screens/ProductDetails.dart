import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fresh_on_the_go/Custome_Widget/const.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetailsPage extends StatefulWidget {
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final Connectivity _stateNet = Connectivity();
  int _current = 0;
  a() async {
    var result = await Connectivity().checkConnectivity();
    print(result);
  }

  @override
  void initState() {
    a();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          child: Image.asset(
            'assets/images/back-ico.png',
            height: 4,
            width: 4,
          ),
          onTap: () => Navigator.pop(context),
        ),
        actions: [Image.asset('assets/images/cart.png')],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "My Cart".text.make(),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
          ).pOnly(bottom: 10),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.32,
            child: Column(
              children: [
                CarouselSlider(
                  items: imageSliders,
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.map((url) {
                    int index = imgList.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Color.fromRGBO(0, 0, 0, 0.9)
                            : Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Regulardor de platano".text.make(),
                        "\$ : 200".text.xl.make(),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        a();
                        // print();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                        child:
                            "ADD TO CART".text.bold.white.size(10).make().p(8),
                      ).pOnly(right: 10),
                    ),
                  ],
                )
              ],
            ),
          ).pOnly(bottom: MediaQuery.of(context).size.height * 0.043),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Details".text.bold.uppercase.make().pOnly(bottom: 5),
                "Lorem Ipsum es simplemente texto ficticio de la inpresion y la composicionLorem Ipsum es simplemente texto ficticio de la inpresion y la composicionLorem Ipsum es simplemente texto ficticio de la inpresion ."
                    .text
                    .size(4)
                    .letterSpacing(0)
                    .make()
              ],
            ),
          ).pOnly(bottom: MediaQuery.of(context).size.height * 0.043),
          Container(
            // color: Colors.red,
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.27,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/veg$i.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ).p(10),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            "Fresh & go $i".text.size(8).make(),
                            "Regulador de platano $i".text.bold.make(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                "\$: $i".text.xl.make().pOnly(
                                    right: MediaQuery.of(context).size.width *
                                        0.135),
                                //  Expanded(child: SizedBox()),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: "ADD".text.white.size(10).make().p(8),
                                ).pOnly(right: 10),
                                Container(
                                    alignment: Alignment.center,
                                    color: Color(0xFFFFD456),
                                    child: VxStepper(
                                      inputBoxColor: Colors.grey[350],
                                      actionButtonColor: Colors.transparent,
                                      onChange: (v) {
                                        print(v);
                                      },
                                    ).pOnly(left: 5, right: 5))
                              ],
                            )
                          ],
                          // ),
                        ),
                      ).pOnly(top: 30)
                    ],
                  ),
                ).pOnly(bottom: 10);
              },
            ),

            // Column(
            //   children: [

            //   ],
            // ),
          ),
          // BottomAppBar(
          //   child: Container(
          //     height: 20,
          //     width: MediaQuery.of(context).size.width,
          //   ),
          //   color: Colors.red,
          // )
        ],
      ),
      bottomNavigationBar: Container(
        color: kPrimaryColor,
        height: 55,
        alignment: Alignment.center,
        child:
        //  Row(
        //   children: [
            "ir al carrito".text.white.xl2.bold.uppercase.make(),
            // Image.asset('')//TODO:Image add here
        //   ],
        // ),
      ),
    );
  }
}

final List<String> imgList = [
  'assets/images/veg0.png',
  'assets/images/veg1.png',
  'assets/images/veg2.png',
];
final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                  ],
                )),
          ),
        ))
    .toList();
