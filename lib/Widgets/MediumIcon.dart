import 'package:flutter/cupertino.dart';

class MediumIcon extends StatefulWidget {
  IconData icon;
  Color bgColor;
  Color iconColor;
  MediumIcon({Key? key,required this.icon,required this.bgColor,required this.iconColor}) : super(key: key);

  @override
  State<MediumIcon> createState() => _MediumIconState();
}

class _MediumIconState extends State<MediumIcon> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.bgColor,
      ),
      child: Icon(widget.icon,size: 24,color: widget.iconColor,),
    );
  }
}
