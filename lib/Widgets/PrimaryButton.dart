import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Styles/applayout.dart';

import '../Styles/styles.dart';

class PrimaryButton extends StatefulWidget {

  double width,height;
  String title;
  PrimaryButton({Key? key,required this.width,required this.height,required this.title}) : super(key: key);


  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Styles.secondryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Styles.offWhite.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(widget.title,style: GoogleFonts.montserrat(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w400),),
      ),

    );
  }
}
