import 'package:flutter/material.dart';
import 'package:fresh_on_the_go/Custome_Widget/const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.asset(
                      "assets/images/menu-bottom.png",
                      fit: BoxFit.cover,
                    ),
                  ).pOnly(right: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Nombre de usuario".text.bold.size(10).textStyle(GoogleFonts.openSans()).make(),
                      "Género masculino".text.size(10).textStyle(GoogleFonts.openSans()).make(),
                      "Direcclòn : lorem Ipsum".text.size(10).textStyle(GoogleFonts.openSans()).make(),
                      "EDITAR PERFIL".text.white.size(10).textStyle(GoogleFonts.openSans()).make()
                    ],
                  ),
                ],
              ),
              // UserAccountsDrawerHeader(
              //   currentAccountPicture: CircleAvatar(child: Image.asset('assets/images/home-icon.png',fit: BoxFit.cover,)),
              // ),
              // "bfgfyfghfx".text.make(),
              decoration: BoxDecoration(color: kPrimaryColor),
            ),
            Container(
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(70))),
              height: MediaQuery.of(context).size.height * 0.08,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/delevery-ico.png',
                    fit: BoxFit.contain,
                  ).p(5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "proxima ranura de enterega"
                          .text
                          .size(1).textStyle(GoogleFonts.openSans())
                          .bold
                          .uppercase
                          .make(),
                      "Sabado. 12de dicilmbre de".text.white.textStyle(GoogleFonts.openSans()).bold.make()
                    ],
                  )
                ],
              ),
            ).p(10),
            ListTile(
              leading: Image.asset("assets/images/menu-icon.png"),
              title: "CATEGORIAS".text.textStyle(GoogleFonts.openSans()).make(),
            ),
            Divider(),
            ListTile(
              leading: Image.asset("assets/images/menu-icon.png"),
              title: "perfil".text.uppercase.textStyle(GoogleFonts.openSans()).make(),
            ),
            Divider(),
            ListTile(
              leading: Image.asset("assets/images/menu-icon.png"),
              title: "mi pedido".text.uppercase.textStyle(GoogleFonts.openSans()).make(),
            ),
            Divider(),
            ListTile(
              leading: Image.asset("assets/images/menu-icon.png"),
              title: "cerrar sesion".text.uppercase.textStyle(GoogleFonts.openSans()).make(),
            ),
            Divider()
          ],
        ),
        elevation: 0,
      )
     ;
  }
}