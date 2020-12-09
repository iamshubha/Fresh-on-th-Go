import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class PaymentContainer extends StatelessWidget {
  final Color setColor;
  final bool isSelect;
  final String string;
  const PaymentContainer(
      {Key key,
      @required this.setColor,
      @required this.isSelect,
      @required this.string})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.14,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelect == true ? setColor : Color(0xFFE9E9E9)),
      child: ListTile(
        leading: isSelect == true
            ? string.text.textStyle(GoogleFonts.openSans()).uppercase.white.make()
            : string.text.textStyle(GoogleFonts.openSans()).uppercase.black.make(),
        trailing: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
          ),
          height: MediaQuery.of(context).size.height * 0.045,
          width: MediaQuery.of(context).size.width * 0.08,
          alignment: Alignment.center,
          child: isSelect == true
              ? Image.asset('assets/images/click.png')
              : Container(),
        ),
      ),
    ).pOnly(bottom: 10);
  }
}
