
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Screens/SignUp.dart';
import 'package:meddoc/Styles/applayout.dart';




import '../Styles/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{



  var _opacity=0.0;

  @override
  void initState() {
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
        children: [
          Column(
            children: [
              Gap(100),

              Gap(200),
              AnimatedOpacity(
                  opacity: _opacity,
                  duration: Duration(milliseconds: 1300),
                child: Column(
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

              SizedBox(
                width: size.width,
                height: 205,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 200,
                    width: size.width*0.53,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/doctorslogo.png")
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
                          width: 140,
                          height: 50,
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
                          width: 140,
                          height: 50,
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
                      ),

                    ],

                  )
                ],
              ),


            ],
          ),



        ],
      ),
    );
  }
}
