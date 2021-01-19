import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:velocity_x/velocity_x.dart';
/**
 * 
 * [3:31 PM, 1/19/2021] +91 98303 28321: Get in touch = 
[3:31 PM, 1/19/2021] +91 98303 28321: Always within your reach = 
[3:31 PM, 1/19/2021] +91 98303 28321: Open Map = 
 */
class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: "contáctenos"
            .text
            .white
            .xl3
            .extraBold
            .letterSpacing(2)
            .uppercase
            .make(),
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
            child:
                // Column(
                //   children: [
                "Siempre a su alcance".text.bold.white.make(),
            //   ],
            // ),
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height * 0.031,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
          ).pOnly(bottom: 5),
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 0.79,
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
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Column(
                          children: [
                            Image.asset('assets/images/contact-map.png')
                                .pOnly(bottom: 15),
                            "Caribbean Produce Exchange"
                                .text
                                .uppercase
                                .black
                                .bold
                                .make().pOnly(bottom:10),
                            Container(
                              width: MediaQuery.of(context).size.width*0.80,
                              child: "Calle 869 KM 2.8 Interior Las Palmas Cataño, PR 00962"
                                  .text.center
                                  .uppercase
                                  .black
                                  .bold
                                  .make()
                                  .pOnly(bottom: 10),
                            ),
                            "Abrir el Mapa".text.bold.color(kPrimaryColor).make()
                          ],
                        ).pOnly(top: MediaQuery.of(context).size.height * 0.02),
                      ).pOnly(top: MediaQuery.of(context).size.height * 0.01),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Column(
                          children: [
                            Image.asset('assets/images/contact-mail.png')
                                .pOnly(bottom: 15),
                            "787-793-0750"
                                .text
                                .uppercase
                                .black
                                .bold
                                .make(),
                            
                            "ainfo@mercadosagricolaspr.com"
                                .text
                                .bold
                                .color(kPrimaryColor)
                                .make()
                          ],
                        ).pOnly(top: MediaQuery.of(context).size.height * 0.02),
                      ).pOnly(top: MediaQuery.of(context).size.height * 0.01),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/contact-time.png')
                                .pOnly(bottom: 15),
                            Container(
                              child: "Lunes a Viernes de\n 8:30am – 5:30pm / Sábados 9am -12pm"
                                  .text
                                  .uppercase.center
                                  .bold
                                  .make(),
                            ),
                            // "9am - 5pm".text.uppercase.black.bold.make(),
                            // "saturday - sunday"
                            //     .text
                            //     .uppercase
                            //     .black
                            //     .bold
                            //     .make(),
                            // "9am - 12pm"
                            //     .text
                            //     .uppercase
                            //     .black
                            //     .bold
                            //     .make()
                            //     .pOnly(bottom: 10),
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

/*
Email: info@mercadosagricolaspr.com
Compañía: 
Dirección: 
Teléfono: 
Horario: Lunes a Viernes de 8:30am – 5:30pm / Sábados 9am -12pm
*/
