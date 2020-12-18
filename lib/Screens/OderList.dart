import 'package:flutter/material.dart';
import 'package:fresh_on_the_go/Custome_Widget/banner.dart';
import 'package:fresh_on_the_go/Custome_Widget/const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: "Order List"
            .text
            .uppercase
            .bold
            .textStyle(GoogleFonts.openSans())
            .make(),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerWidget().pOnly(left: 10, right: 10),
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.065,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xFFEEECED),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "order id".text.uppercase.make(),
                          "Oreder status".text.uppercase.make(),
                          "action".text.uppercase.make()
                        ],
                      ).pOnly(left: 10, right: 10),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "#2525".text.make(),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: kPrimaryColor,
                            ),
                            child: "Deilverd"
                                .text
                                .white
                                .bold
                                .uppercase
                                .make()
                                .pOnly(left: 5, right: 5),
                          ),
                          Row(
                            children: [
                              Image.asset('assets/images/cross-ico.png')
                            ],
                          )
                        ],
                      ).pOnly(left: 16, right: 16),
                    ).pOnly(top: 5),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          color: Color(0xFFFEF4D7),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "#2525".text.make(),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFFBD552),
                            ),
                            child:
                                "Pending".text.white.bold.uppercase.make().p(6),
                          ),
                          Row(
                            children: [
                              Image.asset('assets/images/cross-ico.png')
                            ],
                          )
                        ],
                      ).pOnly(left: 16, right: 16),
                    ).pOnly(top: 5),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "#2525".text.make(),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: kPrimaryColor,
                            ),
                            child: "Deilverd"
                                .text
                                .white
                                .bold
                                .uppercase
                                .make()
                                .p(6),
                          ),
                          Row(
                            children: [
                              Image.asset('assets/images/cross-ico.png')
                            ],
                          )
                        ],
                      ).pOnly(left: 16, right: 16),
                    ).pOnly(top: 5),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          color: Color(0xFFFEF4D7),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "#2525".text.make(),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFFBD552),
                            ),
                            child:
                                "Pending".text.white.bold.uppercase.make().p(6),
                          ),
                          Row(
                            children: [
                              Image.asset('assets/images/cross-ico.png')
                            ],
                          )
                        ],
                      ).pOnly(left: 16, right: 16),
                    ).pOnly(top: 5),
                  ],
                ).pOnly(
                    left: 10, right: 10, top: 20), //.pOnly(left: 20, top: 20),
              ).pOnly(left: 10, right: 10),
            ],
          ).pOnly(left: 10, right: 10)
        ],
      ),
    );
  }
}
