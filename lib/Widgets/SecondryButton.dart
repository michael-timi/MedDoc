import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Styles/applayout.dart';

import '../Styles/styles.dart';

class SecondryButton extends StatefulWidget {
  String title;
   SecondryButton({Key? key,required this.title}) : super(key: key);

  @override
  State<SecondryButton> createState() => _SecondryButtonState();
}

class _SecondryButtonState extends State<SecondryButton> {
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      width: size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Styles.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Styles.primaryColor.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1), //
          )
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          widget.title,
          style: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ),
    );
  }
}
