import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Styles/applayout.dart';
import '../Styles/styles.dart';

class MediumImage extends StatefulWidget {
  String imageAsset;
   MediumImage({Key? key,required this.imageAsset}) : super(key: key);

  @override
  State<MediumImage> createState() => _MediumImageState();
}

class _MediumImageState extends State<MediumImage> {
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Styles.primaryColor,


      ),

      child: widget.imageAsset==""?Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,

        ),
        child: Image.asset("assets/images/appicon.png"),
      ):CircleAvatar(
        radius: 30.0,
        backgroundImage:
        NetworkImage(widget.imageAsset),
        backgroundColor: Colors.transparent,
      ),

    );
  }
}
