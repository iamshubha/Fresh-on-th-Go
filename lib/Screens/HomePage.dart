import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fresh_on_the_go/Custome_Widget/const.dart';
import 'package:fresh_on_the_go/Home/Home.dart';
import 'package:fresh_on_the_go/Home/Menu.dart';
import 'package:fresh_on_the_go/Home/Profile.dart';
import 'package:fresh_on_the_go/Screens/CheckOutPage.dart';
import 'package:fresh_on_the_go/Screens/MyCart.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _currectIndex = 1;
  @override
  void initState() {
    // _currectIndex = 0;
    _pageController = PageController(
      initialPage: 1,
      keepPage: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              // iconSize: 3,
              icon: Image.asset(
                'assets/images/menu.png',
              ).p(5),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MyCartPage()
                      // CheckOutPage()

                      )),
              child: Image.asset('assets/images/cart.png').p(5))
        ],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "LUGAR DE ENTERGA".text.size(10).make(),
            "B-12 TOURCHTHREETEEN, SEC-15, PARTUGAL".text.size(3).make(),
          ],
        ),
        // leading: Icon(Icons.ac_unit),
      ),
      drawer: Drawer(
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
                      "Nombre de usuario".text.bold.size(10).make(),
                      "Género masculino".text.size(10).make(),
                      "Direcclòn : lorem Ipsum".text.size(10).make(),
                      "EDITAR PERFIL".text.white.size(10).make()
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
                          .size(1)
                          .bold
                          .uppercase
                          .make(),
                      "Sabado. 12de dicilmbre de".text.white.bold.make()
                    ],
                  )
                ],
              ),
            ).p(10),
            ListTile(
              leading: Image.asset("assets/images/menu-icon.png"),
              title: "CATEGORIAS".text.make(),
            ),
            Divider(),
            ListTile(
              leading: Image.asset("assets/images/menu-icon.png"),
              title: "perfil".text.uppercase.make(),
            ),
            Divider(),
            ListTile(
              leading: Image.asset("assets/images/menu-icon.png"),
              title: "mi pedido".text.uppercase.make(),
            ),
            Divider(),
            ListTile(
              leading: Image.asset("assets/images/menu-icon.png"),
              title: "cerrar sesion".text.uppercase.make(),
            ),
            Divider()
          ],
        ),
        elevation: 0,
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [Home(), Menu(), Profile()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 2, elevation: 0,
        mouseCursor: MouseCursor.uncontrolled,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Color(0xFFE6E6E6), //Colors.white.withOpacity(.60),

        currentIndex: _currectIndex,
        onTap: (value) {
          _pageController.jumpToPage(value);
          setState(() {
            _currectIndex = value;
            print("sgddfgdfsgz");
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Color(0xFFE6E6E6),
            label: 'Menu',
            icon: Image.asset(
              'assets/images/menu-bottom.png',
              height: MediaQuery.of(context).size.height * 0.046,
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFFE6E6E6),
            label: 'Home',
            icon: Image.asset(
              'assets/images/home-icon.png',
              height: MediaQuery.of(context).size.height * 0.046,
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFFE6E6E6),
            label: 'Profile',
            icon: Image.asset(
              'assets/images/profile-bottom.png',
              height: MediaQuery.of(context).size.height * 0.046,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer();
  }
}
