import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class PaymentContainer extends StatefulWidget {
  final Color setColor;
  // final bool isSelect;
  final String string;
  PaymentContainer(
      {Key key,
      @required this.setColor,
      // @required this.isSelect,
      @required this.string})
      : super(key: key);

  @override
  _PaymentContainerState createState() => _PaymentContainerState();
}

class _PaymentContainerState extends State<PaymentContainer> {
  bool _time = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.14,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _time == true ? widget.setColor : Color(0xFFE9E9E9)),
      child: ListTile(
        onTap: () {
          if (_time == true) {
            setState(() {
              _time = false;
            });
          } else {
            setState(() {
              _time = true;
            });
          }
        },
        leading: _time == true
            ? widget.string.text
                .textStyle(GoogleFonts.openSans())
                .uppercase
                .white
                .make()
            : widget.string.text
                .textStyle(GoogleFonts.openSans())
                .uppercase
                .black
                .make(),
        trailing: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
          ),
          height: MediaQuery.of(context).size.height * 0.045,
          width: MediaQuery.of(context).size.width * 0.08,
          alignment: Alignment.center,
          child: _time == true
              ? Image.asset('assets/images/click.png')
              : Container(),
        ),
      ),
    ).pOnly(bottom: 10);
  
  }
}
