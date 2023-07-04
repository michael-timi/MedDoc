import 'package:flutter/cupertino.dart';

class LargeIcon extends StatefulWidget {
  IconData icon;
  Color bgColor;
  Color iconColor;

   LargeIcon({Key? key,required this.icon,required this.bgColor,required this.iconColor}) : super(key: key);

  @override
  State<LargeIcon> createState() => _LargeIconState();
}

class _LargeIconState extends State<LargeIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.bgColor,
      ),
      child: Icon(widget.icon,size: 28,color: widget.iconColor,),
    );
  }
}
