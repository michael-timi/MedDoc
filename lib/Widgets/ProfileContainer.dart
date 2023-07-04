import 'package:flutter/cupertino.dart';
import 'package:meddoc/Styles/applayout.dart';
import 'package:meddoc/Styles/styles.dart';

import 'ProfilePictureContainer.dart';

class ProfileContainer extends StatefulWidget {
  String imageAsset;
  String name;
   ProfileContainer({Key? key,required this.imageAsset,required this.name}) : super(key: key);

  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Container(
      width: size.width,
      height: size.height*0.30,
      decoration: BoxDecoration(
        color: Styles.primaryColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfilePictureContainer(imageAsset: widget.imageAsset,name:widget.name,age: "",clinicAddress: "",phonenumber: "",),
        ],
      ),
    );
  }
}
