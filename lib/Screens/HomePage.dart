import 'package:flutter/material.dart';
import 'package:fresh_on_the_go/Home/Home.dart';
import 'package:fresh_on_the_go/Home/Menu.dart';
import 'package:fresh_on_the_go/Home/Profile.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _currectIndex;
  @override
  void initState() {
    _currectIndex = 0;
    _pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    super.initState();
  }

  // = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5BB774),
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              // iconSize: 3,
              icon: Image.asset(
                'assets/images/menu.png',
              ),

              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        // InkWell(
        //   child: Image.asset(
        //     'assets/images/menu.png',
        //     height: 4,
        //     width: 4,
        //   ),
        //   onTap: () => Scaffold.of(context).CustomDrawer(),

        // ),
        actions: [Image.asset('assets/images/cart.png')],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Shubha Banerjee".text.size(10).make(),
            "Baishnab para Santipur Nadia".text.size(10).make(),
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
              decoration: BoxDecoration(color: Colors.green),
            ),
            ListTile(
              leading: Image.asset("assets/images/menu-icon.png"),
              title: "CATEGORIAS".text.make(),
            ),
            Divider(),
            ListTile(
              leading: Image.asset("assets/images/menu-icon.png"),
              title: "CATEGORIAS".text.make(),
            ),
            Divider(),
            ListTile(
              leading: Image.asset("assets/images/menu-icon.png"),
              title: "CATEGORIAS".text.make(),
            ),
            Divider(),
            ListTile(
              leading: Image.asset("assets/images/menu-icon.png"),
              title: "CATEGORIAS".text.make(),
            ),
            Divider()
          ],
        ),
        elevation: 0,
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [Menu(), Home(), Profile()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 5,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.black,
        unselectedItemColor: Color(0xFFE6E6E6), //Colors.white.withOpacity(.60),
        // selectedFontSize: 16,
        // unselectedFontSize: 12,
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
            backgroundColor: Colors.grey[400],
            title: Text('Home'),
            icon: Image.asset('assets/images/home-icon.png'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey[400],
            title: Text('Menu'),
            icon: Image.asset('assets/images/menu-bottom.png'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.grey[400],
            title: Text('Profile'),
            icon: Image.asset('assets/images/profile-bottom.png'),
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
