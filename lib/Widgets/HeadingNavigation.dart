import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Styles/styles.dart';

class HeadingNav extends StatefulWidget {
  String title;
  HeadingNav({Key? key, required this.title}) : super(key: key);

  @override
  State<HeadingNav> createState() => _HeadingNavState();
}

class _HeadingNavState extends State<HeadingNav> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: GoogleFonts.montserrat(
              fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        Text(
          "SEE ALL",
          style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Styles.secondryColor),
        ),
      ],
    );
  }
}
