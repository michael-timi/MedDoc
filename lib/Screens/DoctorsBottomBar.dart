import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meddoc/Screens/DoctorsDashboard.dart';
import 'package:unicons/unicons.dart';

import '../Styles/styles.dart';
import 'DoctorsAppointment.dart';
import 'DoctorsMessages.dart';
import 'DoctorsProfile.dart';

class DoctorsNavigationBar extends StatefulWidget {
  int selectedIndex;
   DoctorsNavigationBar({Key? key,required this.selectedIndex}) : super(key: key);

  @override
  State<DoctorsNavigationBar> createState() => _DoctorsNavigationBarState();
}

class _DoctorsNavigationBarState extends State<DoctorsNavigationBar> {

  final List<Widget> _widgetsList=<Widget>[
    DoctorsDashboard(),
    DoctorsAppointment(),
    DoctorsMessages(),
    DoctorsProfile(doctor: true,docID: FirebaseAuth.instance.currentUser!.uid),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(seconds: 0,milliseconds: 500),
        child: _widgetsList[widget.selectedIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Styles.secondryColor,
        items: [
          Icon(Icons.dashboard_outlined,size: 20,),
          Icon(Icons.calendar_today_outlined,size: 20,),
          Icon(UniconsLine.message,size: 20,),
          Icon(Icons.person_outline_outlined,size: 20,),
        ],
        index: widget.selectedIndex,
        animationDuration:Duration(days: 0,minutes: 0,seconds: 0,milliseconds: 500),
        onTap: (index){
          setState(() {
            tapchange(index);
          });
        },
      ),

    );
  }
  void tapchange(int index) {

    widget.selectedIndex=index;

  }
}
