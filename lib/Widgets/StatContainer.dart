import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Styles/applayout.dart';
import '../Styles/styles.dart';

class StatContainer extends StatefulWidget {
  String heading1, description1, heading2, description2, heading3, description3;
  StatContainer(
      {Key? key,
      required this.heading1,
      required this.description1,
      required this.heading2,
      required this.description2,
      required this.heading3,
      required this.description3})
      : super(key: key);

  @override
  State<StatContainer> createState() => _StatContainerState();
}

class _StatContainerState extends State<StatContainer> {
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
        width: size.width,
        height: size.height * 0.14,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Styles.primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(22),
              bottomRight: Radius.circular(22)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.description2,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                Gap(2),
                Text(
                  widget.heading2,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.description1,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Gap(2),
                Text(
                  widget.heading1,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.description3,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                Gap(2),
                Text(
                  widget.heading3,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ));
  }
}
