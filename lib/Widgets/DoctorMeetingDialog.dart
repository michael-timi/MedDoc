import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Screens/DoctorsBottomBar.dart';
import 'package:meddoc/Styles/applayout.dart';

import '../Screens/DoctorsDashboard.dart';
import '../Styles/styles.dart';
import 'ExtraSmallIcon.dart';
import 'PrimaryButton.dart';

class DoctorMeetingDialog extends StatefulWidget {
  const DoctorMeetingDialog({Key? key}) : super(key: key);

  @override
  State<DoctorMeetingDialog> createState() => _DoctorMeetingDialogState();
}

class _DoctorMeetingDialogState extends State<DoctorMeetingDialog> {
  int _startMin = 00;
  int _startHr = 08;

  int _endMin = 00;
  int _endHr = 16;

  int _duration = 30;

  int _price = 30;

  List<int> weekends = [];

  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool saturday = false;
  bool sunday = true;
  String symbol = "NGN";
  Color unSelected = Colors.white;
  Color selected = Styles.shadeColorPrimary;
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    priceController.text = _price.toString();
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Column(
      children: [
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80,
              child: Text("Start Time: ",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                      fontSize: 14, fontWeight: FontWeight.w400)),
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    if (_startHr == 0 && _startMin == 0) {
                    } else {
                      if (_startMin == 0) {
                        _startHr--;
                        _startMin = 45;
                      } else {
                        _startMin -= 15;
                      }
                    }
                  });
                },
                child: ExtraSmallIcon(
                  icon: CupertinoIcons.minus,
                  iconColor: Colors.white,
                  bgColor: Colors.redAccent,
                )),
            Text(_startHr.toString() + ":" + _startMin.toString(),
                style: GoogleFonts.montserrat(
                    fontSize: 14, fontWeight: FontWeight.w400)),
            GestureDetector(
                onTap: () {
                  setState(() {
                    if (_startHr == 23 && _startMin == 45) {
                    } else {
                      if (_startMin == 45) {
                        _startHr++;
                        _startMin = 0;
                      } else {
                        _startMin += 15;
                      }
                    }
                  });
                },
                child: ExtraSmallIcon(
                  icon: Icons.add,
                  iconColor: Colors.white,
                  bgColor: Styles.primaryColor,
                )),
          ],
        ),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80,
              child: Text("End Time: ",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                      fontSize: 14, fontWeight: FontWeight.w400)),
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    if (_endHr == 0 && _endMin == 0) {
                    } else {
                      if (_endMin == 0) {
                        _endHr--;
                        _endMin = 45;
                      } else {
                        _endMin -= 15;
                      }
                    }
                  });
                },
                child: ExtraSmallIcon(
                  icon: CupertinoIcons.minus,
                  iconColor: Colors.white,
                  bgColor: Colors.redAccent,
                )),
            Text(_endHr.toString() + ":" + _endMin.toString(),
                style: GoogleFonts.montserrat(
                    fontSize: 14, fontWeight: FontWeight.w400)),
            GestureDetector(
                onTap: () {
                  setState(() {
                    if (_endHr == 23 && _endMin == 45) {
                    } else {
                      if (_endMin == 45) {
                        _endHr++;
                        _endMin = 0;
                      } else {
                        _endMin += 15;
                      }
                    }
                  });
                },
                child: ExtraSmallIcon(
                  icon: Icons.add,
                  iconColor: Colors.white,
                  bgColor: Styles.primaryColor,
                )),
          ],
        ),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80,
              child: Text("Duration: ",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                      fontSize: 14, fontWeight: FontWeight.w400)),
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    if (_duration == 0) {
                    } else {
                      _duration--;
                    }
                  });
                },
                child: ExtraSmallIcon(
                  icon: CupertinoIcons.minus,
                  iconColor: Colors.white,
                  bgColor: Colors.redAccent,
                )),
            Text(_duration.toString() + "Min",
                style: GoogleFonts.montserrat(
                    fontSize: 14, fontWeight: FontWeight.w400)),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _duration++;
                  });
                },
                child: ExtraSmallIcon(
                  icon: Icons.add,
                  iconColor: Colors.white,
                  bgColor: Styles.primaryColor,
                )),
          ],
        ),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80,
              child: Text("Price: ",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                      fontSize: 14, fontWeight: FontWeight.w400)),
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    if (_price == 0) {
                    } else {
                      int check = _price - 500;
                      if (check <= 0) {
                      } else {
                        setState(() {
                          _price = _price - 500;
                          priceController.text = _price.toString();
                        });
                      }
                    }
                  });
                },
                child: ExtraSmallIcon(
                  icon: CupertinoIcons.minus,
                  iconColor: Colors.white,
                  bgColor: Colors.redAccent,
                )),
            Card(
              child: SizedBox(
                width: 70,
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 2),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1,
                      ))),
                ),
              ),
            ),
            Text(symbol),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _price = _price + 500;
                    priceController.text = _price.toString();
                  });
                },
                child: ExtraSmallIcon(
                  icon: Icons.add,
                  iconColor: Colors.white,
                  bgColor: Styles.primaryColor,
                )),
          ],
        ),
        Gap(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80,
              child: Text("Weekends: ",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                      fontSize: 14, fontWeight: FontWeight.w400)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (monday == true) {
                    monday = false;
                  } else {
                    monday = true;
                  }
                });
              },
              child: Container(
                  width: 40,
                  height: 25,
                  decoration: BoxDecoration(
                      color: monday ? selected : unSelected,
                      border: Border.all(
                          color: monday ? selected : unSelected, width: 1)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Mon",
                      style: GoogleFonts.montserrat(fontSize: 12),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (tuesday == true) {
                    tuesday = false;
                  } else {
                    tuesday = true;
                  }
                });
              },
              child: Container(
                  width: 40,
                  height: 25,
                  decoration: BoxDecoration(
                      color: tuesday ? selected : unSelected,
                      border: Border.all(
                          color: tuesday ? selected : unSelected, width: 1)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Tue",
                      style: GoogleFonts.montserrat(fontSize: 12),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (wednesday == true) {
                    wednesday = false;
                  } else {
                    wednesday = true;
                  }
                });
              },
              child: Container(
                  width: 40,
                  height: 25,
                  decoration: BoxDecoration(
                      color: wednesday ? selected : unSelected,
                      border: Border.all(
                          color: wednesday ? selected : unSelected, width: 1)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Wed",
                      style: GoogleFonts.montserrat(fontSize: 12),
                    ),
                  )),
            ),
          ],
        ),
        Gap(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80,
              child: Text("",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                      fontSize: 14, fontWeight: FontWeight.w400)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (thursday == true) {
                    thursday = false;
                  } else {
                    thursday = true;
                  }
                });
              },
              child: Container(
                  width: 40,
                  height: 25,
                  decoration: BoxDecoration(
                      color: thursday ? selected : unSelected,
                      border: Border.all(
                          color: thursday ? selected : unSelected, width: 1)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Thur",
                      style: GoogleFonts.montserrat(fontSize: 12),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (friday == true) {
                    friday = false;
                  } else {
                    friday = true;
                  }
                });
              },
              child: Container(
                  width: 40,
                  height: 25,
                  decoration: BoxDecoration(
                      color: friday ? selected : unSelected,
                      border: Border.all(
                          color: friday ? selected : unSelected, width: 1)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Fri",
                      style: GoogleFonts.montserrat(fontSize: 12),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (saturday == true) {
                    saturday = false;
                  } else {
                    saturday = true;
                  }
                });
              },
              child: Container(
                  width: 40,
                  height: 25,
                  decoration: BoxDecoration(
                      color: saturday ? selected : unSelected,
                      border: Border.all(
                          color: saturday ? selected : unSelected, width: 1)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Sat",
                      style: GoogleFonts.montserrat(fontSize: 12),
                    ),
                  )),
            ),
          ],
        ),
        Gap(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80,
              child: Text("",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                      fontSize: 14, fontWeight: FontWeight.w400)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (sunday == true) {
                    sunday = false;
                  } else {
                    sunday = true;
                  }
                });
              },
              child: Container(
                  width: 40,
                  height: 25,
                  decoration: BoxDecoration(
                      color: sunday ? selected : unSelected,
                      border: Border.all(
                          color: sunday ? selected : unSelected, width: 1)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Sun",
                      style: GoogleFonts.montserrat(fontSize: 12),
                    ),
                  )),
            ),
          ],
        ),
        Gap(10),
        GestureDetector(
          onTap: () {
            processData();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (builder) => DoctorsNavigationBar(
                        selectedIndex: 0,
                      )),
              (route) => false,
            );
          },
          child: PrimaryButton(
            width: double.infinity,
            height: size.height * 0.045,
            title: "Save",
          ),
        )
      ],
    );
  }

  void processData() {
    addDataintoList();
    if (validateData()) {
      DatabaseReference reference = FirebaseDatabase.instance
          .ref("Users")
          .child("sessions")
          .child(FirebaseAuth.instance.currentUser!.uid);
      Map<String, Object> map = {
        'startHr': _startHr,
        'startMin': _startMin,
        'endHr': _endHr,
        'endMin': _endMin,
        'duration': _duration,
        'price': int.parse(priceController.text),
        'weekends': weekends
      };
      reference.update(map).whenComplete(() => () {});

      DatabaseReference docRef = FirebaseDatabase.instance
          .ref("Users")
          .child("Doctors")
          .child(FirebaseAuth.instance.currentUser!.uid);
      Map<String, Object> docMap = {'scheduled': true};
      docRef.update(docMap);
    } else {}
  }

  void showMessage(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s)),
    );
  }

  bool validateData() {
    if (priceController.text.length < 1) {
      return false;
    }

    return true;
  }

  void addDataintoList() {
    if (monday) {
      weekends.add(DateTime.monday);
    } else if (tuesday) {
      weekends.add(DateTime.tuesday);
    } else if (wednesday) {
      weekends.add(DateTime.wednesday);
    } else if (thursday) {
      weekends.add(DateTime.thursday);
    } else if (friday) {
      weekends.add(DateTime.friday);
    } else if (saturday) {
      weekends.add(DateTime.saturday);
    } else if (sunday) {
      weekends.add(DateTime.sunday);
    }
  }
}
