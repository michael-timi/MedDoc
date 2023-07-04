import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:meddoc/Screens/PatientNavigationBar.dart';
import 'package:meddoc/Styles/applayout.dart';
import 'package:unicons/unicons.dart';
import 'dart:io';
import '../Styles/styles.dart';
import '../Widgets/PrimaryButton.dart';
import '../Widgets/TitlewithNavigation.dart';
import 'DoctorsBottomBar.dart';
import 'SignIn.dart';

class CompletePatientProfile extends StatefulWidget {
  String imageURL;
  String name;
  String email;
  String age;
  String password;
  String gender;
  String type;
  String firstName;
  String surName;
  CompletePatientProfile({Key? key,required this.imageURL,required this.name,required this.email,required this.age,required this.password,required this.gender,required this.type,required this.firstName,required this.surName}) : super(key: key);

  @override
  State<CompletePatientProfile> createState() => _CompletePatientProfileState();
}

class _CompletePatientProfileState extends State<CompletePatientProfile> {


  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();


  bool _addressValidate = false;
  bool _phoneNumberValidate= false;
  String? token;
  bool _loading=false;

  @override
  Widget build(BuildContext context) {
    String imageAsset=widget.imageURL;
    final size=AppLayout.getSize(context);
    return Scaffold(
        backgroundColor: Styles.primaryColor,
        body: Column(
          children: [
            TitleNavigation(title: "Just a Step Away.."),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: size.width,
                  height: size.height*0.87,
                  decoration:BoxDecoration(
                    color: Styles.bgColor,
                  ),
                  child:
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Styles.primaryColor,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:  FileImage(File(imageAsset)),
                                )
                            ),
                          ),
                        ],
                      ),
                      Gap(20),
                      Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                  style: GoogleFonts.montserrat(fontSize: 16,color: Colors.black),
                                  controller: _addressController,
                                  decoration: InputDecoration(
                                    errorText: _addressValidate?'Must Enter Address':null,
                                    contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    prefixIcon: Icon(Icons.home_outlined,color: Styles.primaryColor,),
                                    prefixIconColor: Colors.white,
                                    hintText: "Address",
                                    border: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 32.0),
                                        borderRadius: BorderRadius.circular(15.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 32.0),
                                        borderRadius: BorderRadius.circular(20.0)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 32.0),
                                        borderRadius: BorderRadius.circular(15.0)
                                    ),

                                  )
                              ),
                              Gap(20),
                              TextField(
                                  style: GoogleFonts.montserrat(fontSize: 16,color: Colors.black),
                                  keyboardType: TextInputType.phone,
                                  controller: _phoneNumberController,
                                  decoration: InputDecoration(
                                    errorText: _phoneNumberValidate?'Must Enter Phone Number':null,
                                    contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    prefixIcon: Icon(UniconsLine.phone,color: Styles.primaryColor),
                                    prefixIconColor: Colors.white,
                                    hintText: "Phone Number",
                                    border: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 32.0),
                                        borderRadius: BorderRadius.circular(15.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 32.0),
                                        borderRadius: BorderRadius.circular(20.0)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 32.0),
                                        borderRadius: BorderRadius.circular(15.0)
                                    ),

                                  )
                              ),
                              Gap(20),

                            ],
                          )
                      ),
                      Gap(20),



                      Gap(20),
                      _loading?Center(child: CircularProgressIndicator()):GestureDetector(
                          child: PrimaryButton(width: size.width,height: 50,title: "Finish"),
                          onTap:(){
                            processData();
                          }
                      )


                    ],
                  ),


                ),
              ),
            ),
          ],
        )
    );
  }
  void processData() {
    setState(() {
      _loading=true;
      if (validateFields()) {
        FirebaseAuth.instance.createUserWithEmailAndPassword(email: widget.email, password: widget.password).then((value) =>
        {
          if(value!=null){
            UploadImage(widget.imageURL,value.user!.uid),
           // addtoDatabase(value.user!.uid),

          }
        }).onError((error, stackTrace) => {
          showError(error),
        });;



      }
    });
  }
  bool validateFields() {
    if (_addressController.text.isEmpty) {
      _addressValidate = true;
      return false;
    } else if (_phoneNumberController.text.isEmpty) {
      _phoneNumberValidate = true;
      return false;
    }
    return true;
  }

  void addtoDatabase(String uid, String downloadURL) {
    Map<String,Object> map={
      'name':widget.firstName+" "+widget.name+" "+widget.surName,
      'email':widget.email,
      'password':widget.password,
      'age':widget.age,
      'type':widget.type,
      'gender':widget.gender,
      'imgURL':downloadURL,
      'phonenumber':_phoneNumberController.text,
      'address':_addressController.text,
      'emailVerified':false,
    };

    DatabaseReference ref= FirebaseDatabase.instance.ref("Users").child("Patients").child(uid);
    ref.update(map).whenComplete( (){
      setToken(uid, "Patients");
      showEmailVerificationDialog(uid);




    }).onError((error, stackTrace) => {
      setState(() {
        _loading=false;
      })
    });


  }
  void showEmailVerificationDialog(String uid) {
    User user=FirebaseAuth.instance.currentUser!;
    user.sendEmailVerification(

    ).whenComplete(() => {
      showCupertinoDialog(context: context, builder: (builder){
        return CupertinoAlertDialog(
          title: Text("Email Verification",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),),
          content: Column(
            children: [
              Gap(10),
              Lottie.asset("animations/emailverify.json",
                  width: 250, height: 180, repeat: false),
              Gap(5),
              Text("A verification email has sent to:\n"+widget.email+"\nPlease check your inbox to get verified",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
              Gap(5),
              Text("Login, after verification completes",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w300),textAlign: TextAlign.center,),
              CupertinoDialogAction(child: Text("Ok..",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400),),isDefaultAction:true,isDestructiveAction:false,onPressed: (){
                setState(() {
                  _loading=false;
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SignIn()), (route) => false);
                });
              },),

            ],
          ),

        );
      })



    });

  }
  bool verfiyUser() {
    User user=FirebaseAuth.instance.currentUser!;
    return user.emailVerified;

  }


  showError(Object? error) {
    setState(() {
      _loading=false;
      showMessage(""+error.toString());
    });
  }
  void showMessage(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s)),
    );
  }

  void setToken(String user, String type) async{
    await FirebaseMessaging.instance.getToken().then((value) => {
      setState((){
        token=value;
        print('token'+token!);
      }),
      saveToken(user,type),
    });
  }

  saveToken(String user, String type)async {
    DatabaseReference reference=FirebaseDatabase.instance.ref("Users").child(type).child(user);
    Map<String,Object> map={
      'token':token!,
      'emailVerified':true,
    };
    await reference.update(map);
  }

  UploadImage(String imageURL, String uid) async {
    String dataUrl = 'data:text/plain;base64,SGVsbG8sIFdvcmxkIQ==';

    final storageRef = FirebaseStorage.instance.ref("ProfileImages").child(uid);
    File file = File(imageURL);

    await storageRef.putFile(file).whenComplete(() => {
      storageRef.getDownloadURL().then((value) => {
        addtoDatabase(uid,value),
      }).onError((error, stackTrace) => {
        setState(() {
          _loading=false;
        })
      })

    });
  }
}
