import 'package:FreshOnTheGo/Custome_Widget/cartwidget.dart';
import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Custome_Widget/banner.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:FreshOnTheGo/Custome_Widget/paymentContainer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class CheckOutPaymentPage extends StatefulWidget {
  @override
  _CheckOutPaymentPageState createState() => _CheckOutPaymentPageState();
}

class _CheckOutPaymentPageState extends State<CheckOutPaymentPage> {
  final bool _selectionMethod = true;

  bool _time = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
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
        // actions: [CartIcon().p(12)],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Checkout".text.make(),
            // "Baishnab para Santipur Nadia".text.size(10).make(),
          ],
        ),
        // leading: Icon(Icons.ac_unit),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
            height: MediaQuery.of(context).size.height * 0.019,
            width: MediaQuery.of(context).size.width,
          ).pOnly(bottom: 20),
          Row(
            children: [
              Expanded(child: SizedBox()),
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    color: Color(0xFFE7E6E6),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Image.asset('assets/images/checkout-top-select.png'),
              ),
              "ENTREGA".text.bold.make(),
              SizedBox(width: 18),
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    color: Color(0xFFE7E6E6),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Image.asset('assets/images/checkout-top-select.png'),
              ),
              "PAGO".text.bold.make(),
              Expanded(child: SizedBox()),
            ],
          ).pOnly(bottom: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerWidget(),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.489,
                // width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    "RESUMEN DEL PEDIDO".text.bold.make().pOnly(bottom: 20),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      // width: MediaQuery.of(context).size.width * 0.50,
                      child: ListView.builder(
                        itemBuilder: (_, i) {
                          return InkWell(
                            onTap: () {
                              // setState(() {
                              if (_time == true) {
                                setState(() {
                                  _time = false;
                                });
                              } else {
                                setState(() {
                                  _time = true;
                                });
                              }
                              // });
                            },
                            child: PaymentContainer(
                              setColor: kPrimaryColor,
                              isSelect: _time,
                              string: "$i",
                            ),
                          );
                        },
                        // children: [
                        //   PaymentContainer(
                        //     setColor: kPrimaryColor,
                        //     isSelect: _selectionMethod,
                        //     string: "Billetera upi",
                        //   ),
                        //   PaymentContainer(
                        //     setColor: kPrimaryColor,
                        //     isSelect: !_selectionMethod,
                        //     string: "Banca neta",
                        //   ),
                        //   // PaymentContainer(
                        //   //   setColor: kPrimaryColor,
                        //   //   isSelect: !_selectionMethod,
                        //   //   string: "Tarjeta de crédito / débito / cajero automático",
                        //   // ),
                        //   PaymentContainer(
                        //     setColor: kPrimaryColor,
                        //     isSelect: !_selectionMethod,
                        //     string: "Contra reembolso",
                        //   ),
                        // ],
                      ),
                    ),
                  ],
                ).pOnly(
                    left: 20, right: 20, top: 20), //.pOnly(left: 20, top: 20),
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //           alignment: Alignment.center,
              //           height: MediaQuery.of(context).size.height * 0.07,
              //           color: Color(0xFF2DB573),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               "Total :".text.color(Colors.grey[200]).bold.make(),
              //               "\$ : 200".text.bold.white.xl2.make()
              //             ],
              //           )),
              //     ),
              //     Expanded(
              //       child: Container(
              //           height: MediaQuery.of(context).size.height * 0.07,
              //           color: Color(0xFFFFD553),
              //           alignment: Alignment.center,
              //           child: "PAY NOW".text.bold.make()),
              //     )
              //   ],
              // )
            ],
          ).pOnly(left: 10, right: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.07,
                    color: Color(0xFF2DB573),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        "Total :"
                            .text
                            .color(Colors.grey[200])
                            .textStyle(GoogleFonts.openSans())
                            .bold
                            .make(),
                        "\$ 200"
                            .text
                            .bold
                            .white
                            .textStyle(GoogleFonts.openSans())
                            .xl2
                            .make()
                      ],
                    )),
              ),
              Expanded(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    color: Color(0xFFFFD553),
                    alignment: Alignment.center,
                    child: "PAY NOW"
                        .text
                        .bold
                        .textStyle(GoogleFonts.openSans())
                        .make()),
              )
            ],
          )
        ],
      ),
    );
  }
}
