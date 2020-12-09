import 'package:flutter/material.dart';
import 'package:fresh_on_the_go/Custome_Widget/const.dart';
import 'package:fresh_on_the_go/Screens/CreateAccount.dart';
import 'package:fresh_on_the_go/Screens/ForgetPasswordPage.dart';
import 'package:fresh_on_the_go/Screens/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  loginFunction() {
    try {
      if (_userEditingController.text == id) {
        if (_passwordEditingController.text == password) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomePage()));
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text('Compruebe la contraseña'),
            // duration: Duration(seconds: 3),
          ));
        }
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text('Por favor verifique su ID'),
          // duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  String id = "customer1@gmail.com";

  String password = "123";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(parent: true),
        // physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/login.png'), fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.60,
                left: MediaQuery.of(context).size.width * 0.10,
                right: MediaQuery.of(context).size.width * 0.10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _userEditingController,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: Image.asset(
                      'usernameico.png',
                      width: 10,
                    ).pOnly(top: 10, bottom: 10, right: 10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        // width: 2.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    fillColor: Color(0xFFFFD552),
                    hintText: "Nombre de usuario",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordEditingController,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: Image.asset(
                      'passwordico.png',
                      width: 10,
                    ).pOnly(top: 10, bottom: 10, right: 10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        // width: 2.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    fillColor: Color(0xFFFFD552),
                    hintText: "Nombre de usuario",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ForgetPasswordPage())),
                      child: Row(
                        children: [
                          Image.asset('assets/images/forgetpass-ico.png'),
                          "Olvidé mi \ncontraseña"
                              .text
                              .textStyle(GoogleFonts.oswald())
                              .make(),
                        ],
                      ),
                    ).pOnly(top: 5),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: InkWell(
                        onTap: () => loginFunction(),
                        child: Image.asset('assets/getstartedbtn.png'),
                      ),
                    ),
                  ],
                ).pOnly(left: 5, right: 5),
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CreateAccount())),
                  child: Container(
                    child: Column(
                      children: [
                        "NUEVA USUARIO?"
                            .text
                            .textStyle(GoogleFonts.oswald())
                            .bold
                            .make(),
                        "REGÍSTRESE CON NOSOTRAS"
                            .text
                            .textStyle(GoogleFonts.oswald())
                            .bold
                            .xl
                            .color(kPrimaryColor)
                            .make(),
                      ],
                    ),
                  ),
                ).pOnly(top: MediaQuery.of(context).size.height * 0.03)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
