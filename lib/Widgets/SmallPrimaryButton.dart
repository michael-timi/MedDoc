import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Styles/applayout.dart';
import '../Styles/styles.dart';

class SmallPrimaryButton extends StatefulWidget {
  String title;
  SmallPrimaryButton({Key? key,required this.title}) : super(key: key);

  @override
  State<SmallPrimaryButton> createState() => _SmallPrimaryButtonState();
}

class _SmallPrimaryButtonState extends State<SmallPrimaryButton> {
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Container(
      width: size.width*0.48,
      height: size.height*0.05,
      decoration: BoxDecoration(
        color: Styles.secondryColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(widget.title,style: GoogleFonts.montserrat(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),),
      ),
    );
  }
}
