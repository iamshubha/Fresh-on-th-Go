import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fresh_on_the_go/Custome_Widget/const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var data;
  int qnt;
  String uid;
  bool loader = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _name = TextEditingController();

  addToCart(String pid, String qty) async {
    // setState(() => loader = false);
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
        var data1 = jsonDecode(response.body);
        print(data1);
        if (data1['status']) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text('${data1['message']}'),
            duration: Duration(seconds: 3),
          ));
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text('${data1['message']}'),
            duration: Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  getDataFromServer() async {
    setState(() => loader = false);
    var response = await http.get(
        "http://888travelthailand.com/farmers/apis/product/searchallproduct");

    setState(() {
      final data2 = jsonDecode(response.body);
      print(data2);
      data = data2['data'];
      loader = true;
    });
    print(data);
  }

  getDataForSearch(String word) async {
    try {
      var network = await Connectivity().checkConnectivity();
      print(network.index);
      if (network.index == 2) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text('Please Check Your Internet Connection'),
        ));
      } else {
        setState(() => loader = false);
        String url =
            "http://888travelthailand.com/farmers/apis/product/searchproductbynames?pname=$word";
        final response = await http.get(url);
        var rsp = jsonDecode(response.body);
        setState(() {
          data = rsp['data'];
          loader = true;
        });
        print(data);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getDataFromServer();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        leading: InkWell(
          child: Image.asset(
            'assets/images/back-ico.png',
            height: 4,
            width: 4,
          ),
          onTap: () => Navigator.pop(context),
        ),
        elevation: 0,
        title: Container(
            color: kPrimaryColor,
            height: MediaQuery.of(context).size.height * 0.05,
            child: Container(
              // width: MediaQuery.of(context).size.width*0.80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: TextFormField(
                onChanged: (word) {
                  getDataForSearch(word);
                  print(word);
                },
                decoration: InputDecoration(
                    hintText: "Buscar producto",
                    border: InputBorder.none,
                    prefixIcon: Image.asset('assets/images/search.png').p(8)),
              ),
            )
            // .pOnly(
            //     left: MediaQuery.of(context).size.width * 0.05,
            //     right: MediaQuery.of(context).size.width * 0.05),
            ),
      ),
      body: Column(
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
          ).pOnly(bottom: 10),
          loader == true
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "${data[i]['image']}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ).p(18),
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
                                    "\$: ${data[i]['sell_price']}"
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
                  ))
              : Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}
