import 'package:flutter/cupertino.dart';

class ExtraSmallIcon extends StatefulWidget {
  IconData icon;
  Color bgColor;
  Color iconColor;
   ExtraSmallIcon({Key? key,required this.icon,required this.bgColor,required this.iconColor}) : super(key: key);

  @override
  State<ExtraSmallIcon> createState() => _ExtraSmallIconState();
}

class _ExtraSmallIconState extends State<ExtraSmallIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.bgColor,
      ),
      child: Icon(widget.icon,size: 15,color: widget.iconColor,),
    );
  }
}
