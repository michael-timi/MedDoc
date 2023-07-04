import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Styles/styles.dart';

class SmallIcon extends StatefulWidget {
  IconData icon;
  Color bgColor;
  Color iconColor;
  SmallIcon({Key? key,required this.icon,required this.bgColor,required this.iconColor}) : super(key: key);

  @override
  State<SmallIcon> createState() => _SmallIconState();
}

class _SmallIconState extends State<SmallIcon> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.bgColor,
      ),
      child: Icon(widget.icon,size: 20,color: widget.iconColor,),
    );
  }
}
