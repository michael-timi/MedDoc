import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Styles/applayout.dart';
import '../Styles/styles.dart';

class TitleContainer extends StatefulWidget {
  String title;
   TitleContainer({Key? key,required this.title}) : super(key: key);

  @override
  State<TitleContainer> createState() => _TitleContainerState();
}

class _TitleContainerState extends State<TitleContainer> {
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Container(
      width: size.width,
      height: size.height*0.16,
      decoration: BoxDecoration(
        color: Styles.primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Padding(padding: EdgeInsets.all(26),
              child: Column(

                children: [
                  Gap(15),
                  Row(
                    children: [
                      Text(widget.title,style: GoogleFonts.montserrat(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),),
                    ],
                  ),

                ],
              )
          ),
        ],
      ),
    );
  }
}
