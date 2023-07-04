import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Styles/applayout.dart';

import '../Styles/styles.dart';

class TitleNavigation extends StatefulWidget {
  String title;
 TitleNavigation({Key? key,required this.title}) : super(key: key);

  @override
  State<TitleNavigation> createState() => _TitleNavigationState();
}

class _TitleNavigationState extends State<TitleNavigation> {
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return      Container(
      width: size.width,
      padding: EdgeInsets.all(25),
      height:size.height*0.13,
      decoration: BoxDecoration(
          color: Styles.primaryColor
      ),
      child: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Gap(20),
           Row(
             children: [
               Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 18,),
               Gap(20),
               Text(widget.title,style: GoogleFonts.montserrat(color: Colors.white,fontSize: 18),)
             ],
           )

         ],
        ),
        onTap: ()=>{
          Navigator.pop(context),
        },
      ),
    );
  }
}
