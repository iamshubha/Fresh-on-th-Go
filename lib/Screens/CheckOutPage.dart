import 'package:flutter/material.dart';
import 'package:fresh_on_the_go/Custome_Widget/const.dart';
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
              "DELEVERY".text.bold.make(),
              SizedBox(width: 18),
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    color: Color(0xFFE7E6E6),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Image.asset('assets/images/checkout-top-select.png'),
              ),
              "PAYMENT".text.bold.make(),
              Expanded(child: SizedBox()),
            ],
          ).pOnly(bottom: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Color(0xFFFFD553),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        child: Image.asset(
                          'assets/images/delevery-ico.png',
                          fit: BoxFit.cover,
                        )).p(8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "ENTREGA EN".text.bold.size(10).make(),
                          "P ROXIMA RANURA DE ENTRREGA PROXIMA RANURA DE ENTERGA EL RIEMPO DE ENTEREGA"
                              .text
                              .bold
                              .size(7)
                              .make(),
                          "SABADO, 12 DE DICIEMBRE DE 2020".text.make(),
                        ],
                      ),
                    ),
                    Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Image.asset('assets/images/edit.png',
                                fit: BoxFit.cover))
                        .p(8)
                  ],
                ),
              ),
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
                    "ORDER SUMMERY".text.bold.make().pOnly(bottom: 20),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      // width: MediaQuery.of(context).size.width * 0.50,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int i) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  "Product Name $i".text.make(),
                                  Expanded(child: SizedBox()),
                                  "Qty : $i".text.make(),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  "\$250".text.make(),
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
                    left: 20, right: 20, top: 20), //.pOnly(left: 20, top: 20),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.07,
                        color: Color(0xFF2DB573),
                        child: "Total".text.bold.make()),
                  ),
                  Expanded(
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        color: Color(0xFFFFD553),
                        alignment: Alignment.center,
                        child: "CONFIRM ORDER".text.bold.make()),
                  )
                ],
              )
            ],
          ).pOnly(left: 10, right: 10)
        ],
      ),
    );
  }
}
