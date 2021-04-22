import 'dart:convert';
import 'package:FreshOnTheGo/Custome_Widget/cartwidget.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:FreshOnTheGo/Custome_Widget/CustomDrawer.dart';
import 'package:FreshOnTheGo/Custome_Widget/const.dart';
import 'package:FreshOnTheGo/Screens/ContactUs.dart';
import 'package:FreshOnTheGo/Screens/LoginPage.dart';
import 'package:FreshOnTheGo/Screens/MyCart.dart';
import 'package:FreshOnTheGo/Screens/OderList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool loader = false;
  String uid;
  List data;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _addressEditingController = TextEditingController(text: '');
  final _phoneEditingController = TextEditingController(text: '');
  final _cNameEditingController = TextEditingController(text: '');
  final _nameEditingController = TextEditingController(text: '');
  // CounterProvider _counterProvider = CounterProvider();
  String _address = '';
  String _phone = '';
  String _cName = '';
  String _name = '';
  getDataFromServer() async {
    print("_____________________________-------------------------------------");
    final _prefs = await SharedPreferences.getInstance();
    uid = _prefs.getString('uid');
    String url =
        "https://mercadosagricolaspr.com/farmer-new/apis/customer/get_details_by_id?id=$uid";
    final response = await http.get(url);
    var rsp = jsonDecode(response.body);
    setState(() {
      data = rsp['data'];
      _addressEditingController.text =
          data[0]['address'] == null ? '' : data[0]['address'].toString();
      _phoneEditingController.text =
          data[0]['phone'] == null ? '' : data[0]['phone'].toString();
      _cNameEditingController.text =
          data[0]['cname'] == null ? '' : data[0]['cname'].toString();
      _nameEditingController.text =
          data[0]['name'] == null ? '' : data[0]['name'].toString();
      print(data[0]['phone'].toString() +
          "---------------------" +
          data[0]['address'].toString() +
          '--------------------------' +
          data[0]['cname'].toString() +
          "----------------------" +
          data[0]['name'].toString());
      print(
          "_____________________________-------------------------------------");
      loader = true;
    });
    print(data);
  }

  int iconval = 0;

  editProfile() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    uid = _prefs.getString('uid');
    try {
      var network = await Connectivity().checkConnectivity();
      print(network.index);
      if (network.index == 2) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text('Please Check Your Internet Connection'),
        ));
      } else {
        String url =
            "https://mercadosagricolaspr.com/farmer-new/apis/customer/upd_customer_by_id";
        final headers = {'Content-Type': 'application/json'};
        Map<String, dynamic> body = {
          "uid": uid,
          "name": _nameEditingController.text.toString(),
          "phone": _phoneEditingController.text.toString(),
          "address": _addressEditingController.text.toString(),
          "cname": _cNameEditingController.text.toString(),
          "age": "",
          "country": ""
        };
        String jsonBody = json.encode(body);
        final response = await http.post(url, body: jsonBody, headers: headers);
        var data = jsonDecode(response.body);
        print(data);

        if (data['status']) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text('${data['message']}'),
            duration: Duration(seconds: 3),
          ));
          getDataFromServer();
          Navigator.pop(context);
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

  @override
  void initState() {
    super.initState();
    getDataFromServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: "Perfil de Usuário".text.make(),
        centerTitle: true,
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
              child: CartIconHome().p(10))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
              ),
              child: loader == true
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        Column(
                          children: [
                            Container(
                              color: Colors.transparent,
                              // height: MediaQuery.of(context).size.height * 0.18,
                              // width: MediaQuery.of(context).size.width * 0.3,
                              // decoration: BoxDecoration(
                              //     color: Colors.yellow,
                              //     borderRadius: BorderRadius.circular(1000)),
                              child: Image.asset(
                                'usernameico.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            FlatButton.icon(
                                onPressed: () => showAlertDialog(context),
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                label: "Editar Perfil".text.white.make())
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.06,
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 1.7,
                        ).pOnly(
                            left: MediaQuery.of(context).size.width * 0.08,
                            right: MediaQuery.of(context).size.width * 0.08),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            "${data[0]['email']}"
                                .text
                                .xl
                                .white
                                .extraBold
                                .textStyle(GoogleFonts.openSans())
                                .make(),
                          ],
                        ).pOnly(
                            left: MediaQuery.of(context).size.width * 0.15,
                            right: MediaQuery.of(context).size.width * 0.15),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green[400],
                      ),
                    ),
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.38,
              child: ListView(
                children: [
                  ListTile(
                    leading: Image.asset('assets/images/order-list.png'),
                    title: "Lista de Pedidos".text.make(),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => OrderListPage())),
                  ).pOnly(top: 10),
                  // ListTile(
                  //   leading: Image.asset('assets/images/account-details.png'),
                  //   title: "Detalles de Cuenta".text.make(),
                  // ).pOnly(top: 10),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ContactUsPage()));
                    },
                    leading: Image.asset('assets/images/helpsupport.png'),
                    title: "Ayuda & Apoyo".text.make(),
                  ).pOnly(top: 10),
                  ListTile(
                      leading: Image.asset('assets/images/logout.png'),
                      title: "Cerrar Sessión".text.make(),
                      onTap: () async {
                        final _prefs = await SharedPreferences.getInstance();
                        _prefs.clear();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => LoginPage()));
                      }).pOnly(top: 10),
                ],
              ),
            ).pOnly(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                top: MediaQuery.of(context).size.height * 0.03)
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Enviar"),
      onPressed: () => editProfile(),
    );
    Widget cancleButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () => Navigator.pop(context),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(
        child: Text(
          "Editar Perfil",
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.70,
        height: MediaQuery.of(context).size.height * 0.38,
        child: ListView(
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              // initialValue: _name,
              maxLines: 1,
              controller: _nameEditingController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                hintText: 'Nombre',
              ),
              // decoration:,
              //  InputDecoration(
              //   enabledBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: Colors.grey, width: 2.0),
              //   ),
              //   // prefixIcon: Icon(Icons.per),
              // ),
            ).p(10),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: _phoneEditingController,
              // initialValue: _phone,
              maxLines: 1,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                hintText: 'Teléfono',
                // prefixIcon: Icon(Icons.mail_outline),
              ),
            ).p(10),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              controller: _addressEditingController,
              // initialValue: _address,
              maxLines: 1,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                hintText: 'Habla a',
                // prefixIcon: Icon(Icons.mail_outline),
              ),
            ).p(10),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: _cNameEditingController,
              // initialValue: _cName,
              maxLines: 1,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                hintText: 'Nombre de empresa',
                // prefixIcon: Icon(Icons.mail_outline),
              ),
            ).p(10),
          ],
        ),
      ),
      actions: [okButton, cancleButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
