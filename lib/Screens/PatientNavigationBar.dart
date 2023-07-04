import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../Styles/styles.dart';
import 'PatientAppointments.dart';
import 'PatientDashboard.dart';
import 'PatientDoctorSearch.dart';
import 'PatientMessages.dart';
import 'PatientProfile.dart';

class PatientNavigationBar extends StatefulWidget {
  int selectedindex;
   PatientNavigationBar({Key? key,required this.selectedindex}) : super(key: key);

  @override
  State<PatientNavigationBar> createState() => _PatientNavigationBarState();
}

class _PatientNavigationBarState extends State<PatientNavigationBar> {

  final List<Widget> _widgetsList=<Widget>[
    PatientDashboard(),
    PatientDoctorSearch(),
    PatientMessages(),
    PatientAppointments(),
    PatientProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(seconds: 0,milliseconds: 500),
        child: _widgetsList[widget.selectedindex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Styles.secondryColor,
        items: [
          Icon(Icons.dashboard_outlined,size: 20,),
          Icon(UniconsLine.search,size: 20,),
          Icon(UniconsLine.message,size: 20,),
          Icon(Icons.calendar_today_outlined,size: 20,),
          Icon(Icons.person_outline_outlined,size: 20,),
        ],
        index: widget.selectedindex,
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
    widget.selectedindex=index;

  }
}
