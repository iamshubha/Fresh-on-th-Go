import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fresh_on_the_go/Custome_Widget/const.dart';
import 'package:fresh_on_the_go/Home/Home.dart';
import 'package:fresh_on_the_go/Home/Menu.dart';
import 'package:fresh_on_the_go/Home/Profile.dart';
import 'package:fresh_on_the_go/Screens/CheckOutPage.dart';
import 'package:fresh_on_the_go/Screens/MyCart.dart';
import 'package:google_fonts/google_fonts.dart';
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
      // drawer: CustomDrawer(),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [Menu(), Home(), Profile()],
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
            // title: 'Menu'.text.black.make(),
            label: "Menu",
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
