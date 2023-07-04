import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Styles/applayout.dart';

import '../Styles/styles.dart';

class GreetingContainer extends StatefulWidget {
  String title,imageAsset;
  GreetingContainer({Key? key, required this.title,required this.imageAsset}) : super(key: key);

  @override
  State<GreetingContainer> createState() => _GreetingContainerState();
}

class _GreetingContainerState extends State<GreetingContainer> {
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return  Container(
      width: size.width,
      height: size.height*0.16,
      decoration: BoxDecoration(
        color: Styles.primaryColor,
      ),
      child: Column(
        children: [
          Gap(30),
          Padding(padding: EdgeInsets.all(26),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("👋 Hello,",style: GoogleFonts.montserrat(fontSize: 16,color: Colors.white),),
                            ],
                          ),
                          Gap(5),
                          Row(
                            children: [
                              Text(widget.title,style: GoogleFonts.montserrat(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ],
                      ),
                     widget.imageAsset==""?Container(
                       width: 50,
                       height: 50,
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,

                       ),
                       child: Image.asset("assets/images/appicon.png"),
                     ):CircleAvatar(
                       radius: 25.0,
                       backgroundImage:
                       NetworkImage(widget.imageAsset),
                       backgroundColor: Colors.transparent,
                     ),

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
