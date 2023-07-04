import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../Styles/applayout.dart';
import '../Styles/styles.dart';

class TitleSearchContainer extends StatefulWidget {
  String title;
  TitleSearchContainer({Key? key,required this.title}) : super(key: key);

  @override
  State<TitleSearchContainer> createState() => _TitleSearchContainerState();
}

class _TitleSearchContainerState extends State<TitleSearchContainer> {
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return  Container(
      width: size.width,
      height: size.height*0.2,
      decoration: BoxDecoration(
        color: Styles.primaryColor,
      ),
      child:Column(
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
                  Gap(15),
                  TextField(
                      style: GoogleFonts.montserrat(fontSize: 16,color: Colors.black),
                      keyboardType: TextInputType.name,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                        EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        prefixIcon: Icon(UniconsLine.search,color: Colors.black),
                        prefixIconColor: Colors.white,
                        hintText: "Search Doctor",
                        border: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(15.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(20.0)),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(25.0)
                        ),

                      )
                  ),

                ],
              )
          ),
        ],
      ),

    );
  }
}
