import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:meddoc/Screens/SignIn.dart';
import 'package:meddoc/Screens/SignUp.dart';
import 'package:meddoc/Styles/applayout.dart';
import 'package:meddoc/Widgets/LargeIcon.dart';

import '../Styles/styles.dart';
import '../Widgets/LoadingContainer.dart';
import '../Widgets/PrimaryButton.dart';
import '../Widgets/TitleContainer.dart';
import 'dart:io';
import '../Widgets/TitlewithNavigation.dart';
import 'NewSplashScreen.dart';

class VerificationScreen extends StatefulWidget {
  String uid;
  VerificationScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool under = false;
  String imageFile1 = "";
  String imageFile2 = "";
  String uri1 = "";
  String uri2 = "";
  bool loading = false;
  bool mainLoading = true;

  bool imageSet1 = false;
  String name = '';
  bool imageSet2 = false;

  @override
  void initState() {
    checkPending();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: mainLoading
          ? LoadingContainer()
          : Column(
              children: [
                TitleContainer(
                  title: 'Verifcation',
                ),
                under
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your documents are",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "Under Revision",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "it may take 1 to 2 days to verify your documents.",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(22),
                            child: Lottie.asset(
                              "animations/checkingdocuments.json",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Once its get verified you will be notified. Thank you!",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: LargeIcon(
                                      icon: Icons.home_outlined,
                                      iconColor: Styles.primaryColor,
                                      bgColor: Colors.white),
                                  onTap: () async {
                                    User? user =
                                        FirebaseAuth.instance.currentUser;
                                    if (user == null) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) => SignIn()));
                                    } else {
                                      await FirebaseAuth.instance
                                          .signOut()
                                          .then((value) => {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (builder) =>
                                                            SignIn())),
                                              });
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(22),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "You need to upload your",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Gap(2),
                                  Text(
                                    "Doctor Documents",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Gap(2),
                                  Text(
                                    "that can be used to verifiy your doctor profile.",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width,
                              height: size.height * 0.35,
                              margin: EdgeInsets.only(left: 35, right: 35),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      openOptionsfirst();
                                    },
                                    child: Container(
                                      width: size.width * 0.40,
                                      decoration: BoxDecoration(
                                        color: Styles.simpleBlue,
                                      ),
                                      child: imageSet1
                                          ? Image.file(
                                              File(imageFile1),
                                              fit: BoxFit.fitHeight,
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                LargeIcon(
                                                  icon: Icons
                                                      .add_a_photo_outlined,
                                                  iconColor:
                                                      Styles.primaryColor,
                                                  bgColor: Colors.white,
                                                )
                                              ],
                                            ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      openOptionssecond();
                                    },
                                    child: Container(
                                      width: size.width * 0.40,
                                      decoration: BoxDecoration(
                                        color: Styles.simpleBlue,
                                      ),
                                      child: imageSet2
                                          ? Image.file(File(imageFile2),
                                              fit: BoxFit.fitHeight)
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                LargeIcon(
                                                  icon: Icons
                                                      .add_a_photo_outlined,
                                                  iconColor:
                                                      Styles.primaryColor,
                                                  bgColor: Colors.white,
                                                )
                                              ],
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your documents will be highly secured, and privacy protected, only used for verification for better experience of users.",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                            Gap(20),
                            loading
                                ? CircularProgressIndicator()
                                : GestureDetector(
                                    onTap: () {
                                      if (imageSet1 && imageSet2) {
                                        setState(() {
                                          loading = true;
                                        });
                                        uploadImages();
                                      } else {
                                        showMessage(
                                            "Please select both front and back");
                                      }
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.all(22),
                                        child: PrimaryButton(
                                          width: size.width,
                                          height: size.height * 0.05,
                                          title: 'Submit',
                                        )),
                                  ),
                          ],
                        ),
                      ))
              ],
            ),
    );
  }

  void openOptionsfirst() {
    showCupertinoModalPopup(
        context: context,
        builder: (builder) {
          return CupertinoActionSheet(
            title: Text(
              "Select any",
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text("Open Camera",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                isDefaultAction: true,
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();

                  XFile? pickedFile =
                      await _picker.pickImage(source: ImageSource.camera);
                  setState(() {
                    Navigator.pop(context);
                    imageFile1 = pickedFile!.path;
                    imageSet1 = true;
                  });
                },
              ),
              CupertinoActionSheetAction(
                child: Text("Open Gallery",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                isDefaultAction: true,
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();

                  XFile? pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    Navigator.pop(context);
                    imageFile1 = pickedFile!.path;
                    imageSet1 = true;
                  });
                },
              ),
              CupertinoActionSheetAction(
                child: Text("Reset",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    imageFile1 = "";
                    imageSet1 = false;
                  });
                },
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text("Cancel",
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.w400)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          );
        });
  }

  void openOptionssecond() {
    showCupertinoModalPopup(
        context: context,
        builder: (builder) {
          return CupertinoActionSheet(
            title: Text(
              "Select any",
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text("Open Camera",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                isDefaultAction: true,
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();

                  XFile? pickedFile =
                      await _picker.pickImage(source: ImageSource.camera);
                  setState(() {
                    Navigator.pop(context);
                    imageFile2 = pickedFile!.path;
                    imageSet2 = true;
                  });
                },
              ),
              CupertinoActionSheetAction(
                child: Text("Open Gallery",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                isDefaultAction: true,
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();

                  XFile? pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    Navigator.pop(context);
                    imageFile2 = pickedFile!.path;
                    imageSet2 = true;
                  });
                },
              ),
              CupertinoActionSheetAction(
                child: Text("Reset",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);

                  setState(() {
                    imageFile2 = "";
                    imageSet2 = false;
                  });
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text("Cancel",
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.w400)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          );
        });
  }

  void showMessage(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s)),
    );
  }

  Future<void> uploadImages() async {
    final storageRef = FirebaseStorage.instance
        .ref("VerificationDocuments")
        .child(widget.uid)
        .child("doc1");

    File file = File(imageFile1);

    await storageRef.putFile(file).whenComplete(() => {
          storageRef
              .getDownloadURL()
              .then((value) => {
                    setState(() {
                      uri1 = value.toString();
                    }),
                    uploadSecondImage()
                  })
              .catchError((onError) {
            setState(() {
              loading = false;
            });
          }),
        });
  }

  addtoDatabase(String uid) {
    Map<String, Object> map = {
      'uid': uid,
      'doc1': uri1,
      'doc2': uri2,
    };
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("Verifications").child(uid);
    ref.update(map).then((value) => {
          setState(() {
            loading = false;
            under = true;
            showMessage("Uploaded Successfully..");
          }),
          sendNotification(),
        });
  }

  Future<void> sendNotification() async {
    try {
      await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAfVecfvE:APA91bFLQDYmEYp6vFbBxdncTgeOwzZBd0NH83aK9sJi7TtNfdxFJDjviDKS3xFSaiXOYtFgQj3ZDQIFhIiPvz5aeHo3dzGQ0D3IMAXdBKLDZxEIbAQ6EJgUEI4M_RNxG4USHri3KLMD'
          },
          body: jsonEncode(
            <String, dynamic>{
              'priority': 'high',
              'data': <String, dynamic>{
                'click-action': 'FLUTTER_NOTIFICATION_CLICK',
                'status': 'done',
                'body': name,
                'title': 'New Doctor Profile Request',
              },
              "notification": <String, dynamic>{
                "title": 'New Doctor Profile Request',
                'body': name,
                "android_channel_id": 'mainChannel',
              },
              'to': '/topics/admin',
            },
          ));
    } catch (e) {
      print("Message Exception: " + e.toString());
    }
  }

  uploadSecondImage() async {
    final storageRef = FirebaseStorage.instance
        .ref("VerificationDocuments")
        .child(widget.uid)
        .child("doc2");

    File file = File(imageFile2);

    await storageRef.putFile(file).whenComplete(() => {
          storageRef
              .getDownloadURL()
              .then((value) => {
                    setState(() {
                      uri2 = value.toString();
                    }),
                    addtoDatabase(widget.uid)
                  })
              .catchError((onError) {
            setState(() {
              loading = false;
            });
          }),
        });
  }

  void checkPending() {
    DatabaseReference reference =
        FirebaseDatabase.instance.ref("Verifications").child(widget.uid);
    reference.once().then((value) => {
          if (value.snapshot.exists)
            {
              setState(() {
                under = true;
                mainLoading = false;
              }),
            }
          else
            {
              setState(() {
                mainLoading = false;
              }),
            }
        });
  }

  void getName() {
    DatabaseReference reference = FirebaseDatabase.instance
        .ref("Users")
        .child("Doctors")
        .child(widget.uid);
    reference.once().then((value) => {
          setState(() {
            name = value.snapshot.child("name").value.toString();
          }),
        });
  }
}
