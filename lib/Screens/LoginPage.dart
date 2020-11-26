import 'package:flutter/material.dart';
import 'package:fresh_on_the_go/Screens/ForgetPasswordPage.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/login.png'), fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.60,
                left: MediaQuery.of(context).size.width * 0.20,
                right: MediaQuery.of(context).size.width * 0.20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
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
                    // fillColor: Color(rgb(255,213,82)),
                    fillColor: Color(0xFFFFD552), //fromRGBO(255, 213, 82,0.0),

                    hintText: "Nombre de usuario",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
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
                    // fillColor: Color(rgb(255,213,82)),
                    fillColor: Color(0xFFFFD552), //fromRGBO(255, 213, 82,0.0),

                    hintText: "Nombre de usuario",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ForgetPasswordPage()));
                    },
                    child: Image.asset('assets/getstartedbtn.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
