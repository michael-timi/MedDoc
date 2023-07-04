import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Styles/applayout.dart';

import 'LargeImage.dart';

class ProfilePictureContainer extends StatefulWidget {
  String imageAsset;
  String name;
  String age;
  String clinicAddress;
  String phonenumber;
   ProfilePictureContainer({Key? key,required this.imageAsset,required this.name,required this.age,required this.clinicAddress,required this.phonenumber}) : super(key: key);

  @override
  State<ProfilePictureContainer> createState() => _ProfilePictureContainerState();
}

class _ProfilePictureContainerState extends State<ProfilePictureContainer> {
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Container(
      width: size.width,
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
       color: Colors.white,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(22),bottomLeft: Radius.circular(22)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LargeImage(imageAsset: widget.imageAsset,),
          Gap(10),
          Text(widget.name,style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.w500),),
          Gap(5),
          Text("Age: "+widget.age,style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400),),
          Gap(5),
          Text("Clinic Address: "+widget.clinicAddress,style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
           Gap(5),
          Text("Phone Number: "+widget.phonenumber,style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400),),

        ],
        
      ),
    );
  }
}
