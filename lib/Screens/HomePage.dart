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
        actions: [Icon(Icons.baby_changing_station)],
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
        elevation: 0,
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [Menu(), Home(), Profile()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // fixedColor: Colors.orange,
        type: BottomNavigationBarType.shifting,
        // backgroundColor: Colors.blue,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 16,
        unselectedFontSize: 12,
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
            backgroundColor: Colors.blue,
            title: Text('Favorites'),
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            title: Text('News'),
            icon: Icon(Icons.library_books),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.yellow,
            title: Text('News'),
            icon: Icon(Icons.library_books),
          ),
        ],
      ),
    );
  }
}
