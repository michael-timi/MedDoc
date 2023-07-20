import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Styles/applayout.dart';
import '../Styles/styles.dart';

class TitleContainer extends StatefulWidget {
  String title;
  TitleContainer({Key? key, required this.title}) : super(key: key);

  @override
  State<TitleContainer> createState() => _TitleContainerState();
}

class _TitleContainerState extends State<TitleContainer> {
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      width: size.width,
      height: size.height * 0.16,
      decoration: BoxDecoration(
        color: Styles.primaryColor,
      ),
      child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Center(
            child: Text(
              widget.title,
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          )),
    );
  }
}
