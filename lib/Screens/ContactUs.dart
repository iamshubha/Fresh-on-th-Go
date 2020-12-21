import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:velocity_x/velocity_x.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: "".text.xl2.extraBold.letterSpacing(2).uppercase.make(),
        leading: InkWell(
          child: Image.asset(
            'assets/images/back-ico.png',
            height: 4,
            width: 4,
          ),
          onTap: () => Navigator.pop(context),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[350],
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                "Get in Touch"
                    .text
                    .white
                    .xl3
                    .extraBold
                    .letterSpacing(2)
                    .uppercase
                    .make(),
                "Always within yourreach".text.bold.white.make(),
              ],
            ),
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
          ).pOnly(bottom: 10),
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 0.65,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.19,
                        child: Column(
                          children: [
                            Image.asset('assets/images/contact-map.png')
                                .pOnly(bottom: 15),
                            "267 julien motorway"
                                .text
                                .uppercase
                                .black
                                .bold
                                .make(),
                            "ipsum lorem. partugal"
                                .text
                                .uppercase
                                .black
                                .bold
                                .make()
                                .pOnly(bottom: 10),
                            "Open Map".text.bold.color(kPrimaryColor).make()
                          ],
                        ).pOnly(top: MediaQuery.of(context).size.height * 0.02),
                      ).pOnly(top: MediaQuery.of(context).size.height * 0.01),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.19,
                        child: Column(
                          children: [
                            Image.asset('assets/images/contact-mail.png')
                                .pOnly(bottom: 15),
                            "+00 12121212121212"
                                .text
                                .uppercase
                                .black
                                .bold
                                .make(),
                            "+00 1111111111111111"
                                .text
                                .uppercase
                                .black
                                .bold
                                .make()
                                .pOnly(bottom: 10),
                            "abc@gmail.com"
                                .text
                                .bold
                                .color(kPrimaryColor)
                                .make()
                          ],
                        ).pOnly(top: MediaQuery.of(context).size.height * 0.02),
                      ).pOnly(top: MediaQuery.of(context).size.height * 0.01),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.19,
                        child: Column(
                          children: [
                            Image.asset('assets/images/contact-time.png')
                                .pOnly(bottom: 15),
                            "Monday to friday".text.uppercase.black.bold.make(),
                            "9am - 5pm".text.uppercase.black.bold.make(),
                            "saturday - sunday"
                                .text
                                .uppercase
                                .black
                                .bold
                                .make(),
                            "9am - 12pm"
                                .text
                                .uppercase
                                .black
                                .bold
                                .make()
                                .pOnly(bottom: 10),
                          ],
                        ).pOnly(top: MediaQuery.of(context).size.height * 0.02),
                      ).pOnly(top: MediaQuery.of(context).size.height * 0.01),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
