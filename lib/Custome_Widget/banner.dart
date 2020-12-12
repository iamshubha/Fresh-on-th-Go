import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFD553),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: Image.asset(
                'assets/images/delevery-ico.png',
                fit: BoxFit.cover,
              )).p(8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "ENTREGA EN".text.bold.textStyle(GoogleFonts.openSans()).size(2).make(),
                "P ROXIMA RANURA DE ENTERGA EL RIEMPO DE ENTEREGA"
                    .text.textStyle(GoogleFonts.openSans())
                    .bold
                    .size(4)
                    .make(),
                Text(
                  "SABADO, 12 DE DICIEMBRE DE 2020",
                  style: GoogleFonts.openSans(),//GoogleFonts.openSansTextTheme(),
                ).text.size(7).make(),
              ],
            ),
          ),
          Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child:
                      Image.asset('assets/images/edit.png', fit: BoxFit.cover))
              .p(8)
        ],
      ),
    );
  }
}