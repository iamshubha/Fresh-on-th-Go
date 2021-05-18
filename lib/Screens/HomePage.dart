import 'package:FreshOnTheGo/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:FreshOnTheGo/Home/Menu.dart';
import 'package:FreshOnTheGo/Home/Home.dart';
import 'package:FreshOnTheGo/Home/Profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _currectIndex = 1;
  String uid;
  @override
  void initState() {
    // _currectIndex = 0;
    getSharedData();
    _pageController = PageController(
      initialPage: 1,
      keepPage: true,
    );
    super.initState();
  }

  getSharedData() async {
    final _prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = _prefs.getString("uid");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _prefs = Provider.of<PrefsUtils>(context, listen: false);
    _prefs.getStringuid();
    return Consumer<PrefsUtils>(builder: (context, snapshot, _) {
      return Scaffold(
        // drawer: CustomDrawer(),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Menu(),
            Home(),
            snapshot.uid != null ? Profile() : Container()
          ],
        ),
        bottomNavigationBar: snapshot.uid != null
            ? BottomNavigationBar(
                iconSize: 2, elevation: 0,
                mouseCursor: MouseCursor.uncontrolled,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.black,
                unselectedItemColor:
                    Color(0xFFE6E6E6), //Colors.white.withOpacity(.60),

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
                      'assets/menu1.png',
                      height: MediaQuery.of(context).size.height * 0.046,
                    ),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Color(0xFFE6E6E6),
                    label: 'Home',
                    icon: Image.asset(
                      'assets/home.png',
                      height: MediaQuery.of(context).size.height * 0.046,
                    ),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Color(0xFFE6E6E6),
                    label: 'Profile',
                    icon: Image.asset(
                      'assets/profile.png',
                      height: MediaQuery.of(context).size.height * 0.046,
                    ),
                  ),
                ],
              )
            : BottomNavigationBar(
                iconSize: 2, elevation: 0,
                mouseCursor: MouseCursor.uncontrolled,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.black,
                unselectedItemColor:
                    Color(0xFFE6E6E6), //Colors.white.withOpacity(.60),

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
                      'assets/menu1.png',
                      height: MediaQuery.of(context).size.height * 0.046,
                    ),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Color(0xFFE6E6E6),
                    label: 'Home',
                    icon: Image.asset(
                      'assets/home.png',
                      height: MediaQuery.of(context).size.height * 0.046,
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
