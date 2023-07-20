import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Styles/applayout.dart';
import 'package:meddoc/Widgets/MediumIcon.dart';

import '../Styles/styles.dart';

class ListPropertiesTile extends StatefulWidget {
  String top, bottom;
  IconData icon;
  ListPropertiesTile(
      {Key? key, required this.top, required this.bottom, required this.icon})
      : super(key: key);

  @override
  State<ListPropertiesTile> createState() => _ListPropertiesTileState();
}

class _ListPropertiesTileState extends State<ListPropertiesTile> {
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      width: size.width,
      height: size.height * 0.09,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            MediumIcon(
                icon: widget.icon,
                bgColor: Styles.shadeColorPrimary,
                iconColor: Styles.primaryColor),
            Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: size.height * 0.19,
                    child: Text(
                      widget.top,
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      maxLines: 3,
                    )),
                Gap(5),
                Text(
                  widget.bottom,
                  style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
