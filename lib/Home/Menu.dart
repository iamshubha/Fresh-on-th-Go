import 'package:FreshOnTheGo/Custome_Widget/cartwidget.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Custome_Widget/CustomDrawer.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:FreshOnTheGo/Screens/MyCart.dart';
import 'package:FreshOnTheGo/Screens/ProductDetails.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListItem {
  int value;
  String name;
  ListItem(this.value, this.name);
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int qnt;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<ListItem> _dropdownItems = [
    ListItem(1, "First Value"),
    ListItem(2, "Second Item"),
    ListItem(3, "Third Item"),
    ListItem(4, "Fourth Item")
  ];
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;
  var getDataForAllCategory;
  var data;
  bool loader = false;
  String uid;
  getDataFromServer() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = _prefs.getString('uid');
    });
    var url = http.get(
        "http://888travelthailand.com/farmers/apis/product/searchallproduct");
    var urlForCat = http.get(
        "http://888travelthailand.com/farmers/apis/product/getallcategories");
    var response = await Future.wait([url, urlForCat]);
    setState(() {
      final data1 = jsonDecode(response[0].body);
      final data2 = jsonDecode(response[1].body);
      print(data2);
      print(data1);
      data = data1['data'];
      getDataForAllCategory = data2['data'];
      loader = true;
    });
    print("${data.length} " +
        "shubha" +
        "${getDataForAllCategory.length}" +
        "--" +
        uid);
  }

  fetchDataWithCatType(String cid) async {
    setState(() {
      loader = false;
    });
    var response = await http.get(
        "http://888travelthailand.com/farmers/apis/product/searchproductbycatagory?cid=$cid");

    setState(() {
      var getResponse = jsonDecode(response.body);
      print(getResponse);
      data = getResponse['data'];
      loader = true;
    });
  }

  addToCart(String pid, String qty) async {
    try {
      var network = await Connectivity().checkConnectivity();
      print(network.index);
      if (network.index == 2) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text('Please Check Your Internet Connection'),
        ));
      } else {
        String url = "http://888travelthailand.com/farmers/apis/order/addcart";
        final headers = {'Content-Type': 'application/json'};
        Map<String, dynamic> body = {
          "pid": "$pid",
          "qty": "$qty",
          "uid": "$uid"
        };
        String jsonBody = json.encode(body);
        final response = await http.post(url, body: jsonBody, headers: headers);
        var data = jsonDecode(response.body);
        print(data);
        if (data['status']) {
          setState(() {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              backgroundColor: kPrimaryColor,
              content: Text('${data['message']}'),
              duration: Duration(seconds: 3),
            ));
          });
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text('${data['message']}'),
            duration: Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
    getDataFromServer();
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
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
                  context, MaterialPageRoute(builder: (_) => MyCartPage())),
              child: CartIcon().p(10))
        ],
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "LUGAR DE ENTERGA"
                .text
                .size(10)
                .textStyle(GoogleFonts.openSans())
                .make(),
            "B-12 TOURCHTHREETEEN, SEC-15, PARTUGAL"
                .text
                .size(3)
                .textStyle(GoogleFonts.openSans())
                .make(),
          ],
        ),
        // leading: Icon(Icons.ac_unit),
      ),
      drawer: CustomDrawer(),
      body: Container(
        color: Colors.grey[350],
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                  ),
                ),
                Container(
                  height: 28,
                  width: MediaQuery.of(context).size.width * 0.40,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                  ),
                  alignment: Alignment.topCenter,
                  child: "FRUTA FRESCA"
                      .text
                      .textStyle(GoogleFonts.openSans())
                      .white
                      .make(),
                ).pOnly(bottom: 10)
              ],
            ),
            loader == true
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.091,
                    color: Colors.white,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: getDataForAllCategory.length,
                      itemBuilder: (_, i) {
                        return InkWell(
                          onTap: () {
                            fetchDataWithCatType(
                                getDataForAllCategory[i]['cid']);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: "${getDataForAllCategory[i]['name']}"
                                .text
                                .textStyle(GoogleFonts.openSans())
                                .center
                                .black
                                .make()
                                .p(4),
                          ).p(7),
                        );
                      },
                    ),
                  )
                : Container(),
            Container(
              color: kPrimaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  loader == true
                      ? Text("${data.length} Artículos")
                          .text
                          .textStyle(GoogleFonts.openSans())
                          .white
                          .bold
                          .size(18)
                          .make()
                      : Container(
                          child: CircularProgressIndicator(),
                        ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width * 0.2,
                  //   decoration: BoxDecoration(
                  //     color: Color(0xFFFFD456),
                  //     borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       "Filter".text.textStyle(GoogleFonts.openSans()).make(),
                  //       Image.asset('assets/images/filter-bg.png')
                  //     ],
                  //   ).pOnly(left: 5, right: 2),
                  // )
                ],
              ).pOnly(top: 10, bottom: 10, right: 20, left: 20),
            ),
            loader == true
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.544,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ProductDetailsPage(
                                          cid: data[i]['cid'],
                                          pid: data[i]['pid']))),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "${data[i]['image']}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ).p(18),
                            ),
                            Container(
                              // width: MediaQuery.of(context).size.width * 0.,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  "${data[i]['name']}"
                                      .text
                                      .textStyle(GoogleFonts.openSans())
                                      .size(8)
                                      .make(),
                                  "${data[i]['category']}"
                                      .text
                                      .textStyle(GoogleFonts.openSans())
                                      .bold
                                      .make()
                                      .pOnly(bottom: 20),
                                  // DropdownButtonHideUnderline(
                                  //     child: DropdownButton(
                                  //         value: _selectedItem,
                                  //         items: _dropdownMenuItems,
                                  //         onChanged: (value) {
                                  //           setState(() {
                                  //             // _selectedItem = value;
                                  //           });
                                  //         })),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      "\$: ${data[i]['cost_price']}"
                                          .text
                                          .textStyle(GoogleFonts.openSans())
                                          .xl
                                          .make(),
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: "AÑADIR"
                                              .text
                                              .textStyle(GoogleFonts.openSans())
                                              .white
                                              .size(10)
                                              .make()
                                              .p(4),
                                        ).pOnly(right: 10),
                                        onTap: () =>
                                            addToCart(data[i]['pid'], "$qnt"),
                                      ),
                                      Container(
                                        // alignment: Alignment.,
                                        color: Color(0xFFFFD456),
                                        child: VxStepper(
                                          inputBoxColor: Colors.grey[350],
                                          actionButtonColor: Colors.transparent,
                                          onChange: (v) {
                                            print(v);
                                            setState(() => qnt = v);
                                          },
                                        ).pOnly(left: 5, right: 5),
                                      ).pOnly(right: 5)
                                    ],
                                  )
                                ],
                                // ),
                              ),
                            ).pOnly(top: 30)
                          ],
                        );
                      },
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
