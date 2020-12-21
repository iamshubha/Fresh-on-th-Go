import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Custome_Widget/banner.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:FreshOnTheGo/Screens/CheckOutPayment.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class CheckOutPage extends StatelessWidget {
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
        actions: [Image.asset('assets/images/cart.png')],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Revisa".text.textStyle(GoogleFonts.openSans()).make(),
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
              "ENTREGA".text.textStyle(GoogleFonts.openSans()).bold.make(),
              SizedBox(width: 18),
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    color: Color(0xFFE7E6E6),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Image.asset('assets/images/checkout-top-select.png'),
              ),
              "PAGO".text.bold.textStyle(GoogleFonts.openSans()).make(),
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
                height: MediaQuery.of(context).size.height * 0.53,
                // width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    "RESUMEN DEL PEDIDO"
                        .text
                        .bold
                        .textStyle(GoogleFonts.openSans())
                        .make()
                        .pOnly(bottom: 20),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.44,
                      // width: MediaQuery.of(context).size.width * 0.50,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int i) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  "nombre del producto $i"
                                      .text
                                      .textStyle(GoogleFonts.openSans())
                                      .make(),
                                  Expanded(child: SizedBox()),
                                  "Cant : $i"
                                      .text
                                      .textStyle(GoogleFonts.openSans())
                                      .make(),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  "\$250"
                                      .text
                                      .textStyle(GoogleFonts.openSans())
                                      .make(),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Image.asset('assets/images/cross-ico.png')
                                ],
                              ),
                              Divider()
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ).pOnly(
                    left: 10, right: 10, top: 20), //.pOnly(left: 20, top: 20),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.07,
                        color: Color(0xFF2DB573),
                        child: "Total"
                            .text
                            .bold
                            .textStyle(GoogleFonts.openSans())
                            .make()),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CheckOutPaymentPage()));
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          color: Color(0xFFFFD553),
                          alignment: Alignment.center,
                          child: "CONFIRMAR PEDIDO"
                              .text
                              .textStyle(GoogleFonts.openSans())
                              .bold
                              .make()),
                    ),
                  )
                ],
              ).pOnly(top: 1)
            ],
          ).pOnly(left: 10, right: 10)
        ],
      ),
    );
  }
}
