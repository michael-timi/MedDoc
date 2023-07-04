import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Screens/DoctorsBottomBar.dart';
import 'package:meddoc/Screens/PatientNavigationBar.dart';
import 'package:meddoc/Screens/SignIn.dart';
import 'package:meddoc/Styles/applayout.dart';

import '../Styles/styles.dart';
import 'SignUp.dart';
import 'VerificationScreen.dart';

class NewSplashScreen extends StatefulWidget {
  const NewSplashScreen({Key? key}) : super(key: key);

  @override
  State<NewSplashScreen> createState() => _NewSplashScreenState();
}

class _NewSplashScreenState extends State<NewSplashScreen> {
  var _opacity=0.0;

  @override
  void initState()  {
    checkUser();
    Future.delayed(Duration(milliseconds: 300),(){
      setState(() {
        _opacity=1.0;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Gap(1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome",style: GoogleFonts.pacifico(fontSize: 40,color: Colors.white)),
            ],
          ),

          AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(milliseconds: 1300),
            child:   Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("MedDoc",style: GoogleFonts.openSans(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Doctor Finder and Appointment app",style: GoogleFonts.openSans(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),



          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: size.height*0.2700,
                width: size.width*0.50,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/doctorcare.png")
                    )
                ),

              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: ()=>{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()))
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 5),
                      width: size.width*0.2900,
                      height: size.height*0.0600,
                      decoration: BoxDecoration(
                          color: Styles.secondryColor,
                          borderRadius: BorderRadius.circular(12)

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Sign Up",style: GoogleFonts.openSans(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),),
                          Icon(Icons.navigate_next,color: Colors.white,),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(

                      margin: EdgeInsets.only(right: 5,top: 10),
                      width: size.width*0.2900,
                      height: size.height*0.0600,
                      decoration: BoxDecoration(
                          color: Styles.secondryColor,
                          borderRadius: BorderRadius.circular(12)

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Sign In",style: GoogleFonts.openSans(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),),
                          Icon(Icons.navigate_next,color: Colors.white,),
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignIn()));
                    },
                  ),

                ],

              )
            ],
          ),

        ],

      ),
    );
  }
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  Future<void> checkUser() async {
    if (FirebaseAuth.instance.currentUser != null) {

      User user = FirebaseAuth.instance.currentUser!;

      DatabaseReference reference = FirebaseDatabase.instance.ref("Users")
          .child("Doctors")
          .child(user.uid);
      final snapshot = await reference.get();
      if (snapshot.exists) {
        String status=snapshot.child("docVerified").value.toString();
        if(status=="true"){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>DoctorsNavigationBar(selectedIndex: 0,)));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>VerificationScreen(uid:FirebaseAuth.instance.currentUser!.uid)));

        }      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>PatientNavigationBar(selectedindex: 0,)),);

      }
    }
  }
}
