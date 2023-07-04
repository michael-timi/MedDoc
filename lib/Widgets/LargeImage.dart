import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Styles/applayout.dart';
import '../Styles/styles.dart';

class LargeImage extends StatefulWidget {
  String imageAsset;
 LargeImage({Key? key,required this.imageAsset}) : super(key: key);

  @override
  State<LargeImage> createState() => _LargeImageState();
}

class _LargeImageState extends State<LargeImage> {
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Container(
      width: size.width*0.25,
      height: size.height*0.12,
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
