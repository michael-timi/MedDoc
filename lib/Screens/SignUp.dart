
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Screens/CompleteDoctorProfile.dart';
import 'package:meddoc/Styles/applayout.dart';

import '../Styles/styles.dart';
import '../Widgets/PrimaryButton.dart';
import '../Widgets/TitleContainer.dart';
import '../Widgets/TitlewithNavigation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'CompletePatientProfile.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController=TextEditingController();
  final _surNameController=TextEditingController();
  final _nameController=TextEditingController();
  final _emailController=TextEditingController();
  final _ageController=TextEditingController();
  final _passwordController=TextEditingController();

  String imageFile="";

  bool imageSet=false;
  bool _nameValidate=false;
  bool _emailValidate=false;
  bool _ageValidate=false;
  bool _passValidate=false;
  bool _firstNameValidate=false;
  bool _surNameValidate=false;


  String type="doctor";
  String gender="Male";
  Color _genderswitchColor=Styles.secondryColor;
  Color _genderswitchColor2=Styles.bgColor;
  Color _gendertxtColor=Colors.white;
  Color _gendertxtColor2=Colors.black;
  Color _typeswitchColor=Styles.secondryColor;
  Color _typeswitchColor2=Styles.bgColor;
  Color _typetxtColor=Colors.white;
  Color _typetxtColor2=Colors.black;
  String _imageAsset="assets/images/maledoctor.png";

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _firstNameController.dispose();
    _surNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      body: Column(
            children: [
              Row(
                children: [
                  TitleNavigation(title: "SIGN UP",),
                ],

              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.all(20),
                      width: size.width,
                      decoration:BoxDecoration(
                        color: Styles.bgColor,
                      ),
                      child:
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [

                                    imageSet? Container(
                                      width: 100,
                                      height: 100,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Styles.primaryColor,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(File(imageFile)),
                                          )
                                      ),
                                    ):
                                    Container(
                                      width: 100,
                                      height: 100,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Styles.primaryColor,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(_imageAsset),
                                          )
                                      ),
                                    ),
                                    Positioned(
                                        left: 60,
                                        top: 60,
                                        child: IconButton(
                                          iconSize: 28,
                                          color: Styles.secondryColor,
                                          icon: Icon(Icons.add_a_photo_outlined),
                                          onPressed: () {

                                            openGallery();

                                          },
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            Gap(20),
                            Form(
                              key:_formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextField(
                                        controller: _firstNameController,
                                        style: GoogleFonts.montserrat(fontSize: 16,color: Colors.black),
                                        decoration: InputDecoration(
                                          errorText: _firstNameValidate?'Must Enter Your First Name':null,
                                          contentPadding:
                                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                          prefixIcon: Icon(Icons.person,color: Styles.primaryColor,),
                                          prefixIconColor: Colors.white,
                                          hintText: "Enter Your First Name",
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
                                        controller: _nameController,
                                        style: GoogleFonts.montserrat(fontSize: 16,color: Colors.black),
                                        decoration: InputDecoration(
                                          errorText: _nameValidate?'Must Enter Your Middle Name':null,
                                          contentPadding:
                                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                          prefixIcon: Icon(Icons.person,color: Styles.primaryColor,),
                                          prefixIconColor: Colors.white,
                                          hintText: "Enter Your Middle Name",
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
                                        controller: _surNameController,
                                        style: GoogleFonts.montserrat(fontSize: 16,color: Colors.black),
                                        decoration: InputDecoration(
                                          errorText: _surNameValidate?'Must Enter Your Last Name':null,
                                          contentPadding:
                                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                          prefixIcon: Icon(Icons.person,color: Styles.primaryColor,),
                                          prefixIconColor: Colors.white,
                                          hintText: "Enter Your Last Name",
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
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          errorText: _emailValidate?'Must Enter Email':null,
                                          contentPadding:
                                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                          prefixIcon: Icon(Icons.email_outlined,color: Styles.primaryColor),
                                          prefixIconColor: Colors.white,
                                          hintText: "Enter Your Email Address",
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
                                      controller: _ageController,
                                        style: GoogleFonts.montserrat(fontSize: 16,color: Colors.black),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          errorText: _ageValidate?'Must Enter Age':null,
                                          contentPadding:
                                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                          prefixIcon: Icon(Icons.numbers_outlined,color: Styles.primaryColor),
                                          prefixIconColor: Colors.white,
                                          hintText: "Enter Your Age",
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
                                      controller: _passwordController,
                                        style: GoogleFonts.montserrat(fontSize: 16,color: Colors.black),
                                        keyboardType: TextInputType.visiblePassword,
                                        obscureText: true,
                                        enableSuggestions: false,
                                        decoration: InputDecoration(
                                          errorText: _passValidate?'Must Enter Password':null,
                                          contentPadding:
                                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                          prefixIcon: Icon(Icons.password_outlined,color: Styles.primaryColor),
                                          prefixIconColor: Colors.white,
                                          hintText: "Enter Your Password",
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
                                              borderRadius: BorderRadius.circular(25.0)
                                          ),

                                        )
                                    ),
                                  ],
                                )
                            ),
                            Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Gender: ",style: GoogleFonts.montserrat(fontSize: 16,color: Colors.black),),
                                Row(
                                  children: [
                                    GestureDetector(
                                      child:  Container(
                                          width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: _genderswitchColor,
                                              border:Border.all(color: Styles.secondryColor,width: 1)
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("Male",style:
                                            GoogleFonts.montserrat(fontSize: 14,color:_gendertxtColor),),
                                          )
                                      ),
                                      onTap: (){
                                        setState(() {
                                          _genderswitchColor2=Styles.bgColor;
                                          _genderswitchColor=Styles.secondryColor;
                                          _gendertxtColor=Colors.white;
                                          _gendertxtColor2=Colors.black;
                                          gender="Male";
                                          if(type=="doctor"){
                                            _imageAsset="assets/images/maledoctor.png";
                                          }else{
                                            _imageAsset="assets/images/femaleperson.png";
                                          }


                                        });
                                      },
                                    ),

                                    GestureDetector(
                                      child:  Container(
                                          width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: _genderswitchColor2,
                                              border:Border.all(color: Styles.secondryColor,width: 1)
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("Female",style:
                                            GoogleFonts.montserrat(fontSize: 14,color:_gendertxtColor2),),
                                          )
                                      ),
                                      onTap: (){
                                        setState(() {
                                          _genderswitchColor2=Styles.secondryColor;
                                          _genderswitchColor=Styles.bgColor;
                                          _gendertxtColor=Colors.black;
                                          _gendertxtColor2=Colors.white;
                                          gender="Female";

                                          if(type=="doctor"){
                                            _imageAsset="assets/images/femaledoctor.png";

                                          }else{
                                            _imageAsset="assets/images/maleperson.png";
                                          }

                                        });

                                      },
                                    )
                                  ],
                                )


                              ],
                            ),
                            Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Are you a:",style: GoogleFonts.montserrat(fontSize: 16,color: Colors.black),),
                                Row(
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                          width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: _typeswitchColor,
                                              border:Border.all(color: Styles.secondryColor,width: 1)
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("Specialist",style:
                                            GoogleFonts.montserrat(fontSize: 14,color:_typetxtColor),),
                                          )
                                      ),
                                      onTap: (){
                                        setState(() {
                                          _typeswitchColor2=Styles.bgColor;
                                          _typeswitchColor=Styles.secondryColor;
                                          _typetxtColor=Colors.white;
                                          _typetxtColor2=Colors.black;
                                          type="doctor";
                                          if(gender=="Male"){
                                            _imageAsset="assets/images/maledoctor.png";
                                          }else{
                                            _imageAsset="assets/images/femaledoctor.png";
                                          }

                                        });
                                      },
                                    ),
                                    GestureDetector(
                                      child:     Container(
                                          width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: _typeswitchColor2,
                                              border:Border.all(color: Styles.secondryColor,width: 1)
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("Patient",style:
                                            GoogleFonts.montserrat(fontSize: 14,color:_typetxtColor2),),
                                          )
                                      ),
                                      onTap: (){
                                        setState(() {
                                          _typeswitchColor2=Styles.secondryColor;
                                          _typeswitchColor=Styles.bgColor;
                                          _typetxtColor=Colors.black;
                                          _typetxtColor2=Colors.white;
                                          type="patient";
                                          if(gender=="Male"){
                                            _imageAsset="assets/images/femaleperson.png";
                                          }else{
                                            _imageAsset="assets/images/maleperson.png";
                                          }
                                        });
                                      },
                                    )
                                  ],
                                )


                              ],
                            ),
                            Gap(40),
                            GestureDetector(
                                child: PrimaryButton(width: size.width,height: 50,title: "Proceed"),
                                onTap:(){
                                  processData();

                                }
                            )


                          ],
                        ),


                  ),
                ),
              )

            ],
          ),

    );
  }

  void processData() {
    setState(() {
      if(validateFields()){
        if(type=="doctor"){
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>CompleteDoctorProfile(imageURL: imageFile,email: _emailController.text,age: _ageController.text,password: _passwordController.text, name: _nameController.text,gender: gender,type: type,firstName: _firstNameController.text,surName: _surNameController.text,)));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>CompletePatientProfile(imageURL: imageFile,email: _emailController.text,age: _ageController.text,password: _passwordController.text, name: _nameController.text,gender: gender,type: type,firstName: _firstNameController.text,surName: _surNameController.text,)));
        }

      }
    });


  }

  bool validateFields() {
    if(_nameController.text.isEmpty){
      _nameValidate=true;
      return false;
    }else if(_emailController.text.isEmpty){
      _emailValidate=true;
      return false;
    }else if(_ageController.text.isEmpty){
      _ageValidate=true;
      return false;
    }else if(_passwordController.text.length<6){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password Length should be greater than 6')),
      );
      return false;
    }else if(_passwordController.text.isEmpty){
      _passValidate=true;
      return false;
    }else if(_firstNameController.text.isEmpty){
      _firstNameValidate=true;
      return false;
    }else if(_surNameController.text.isEmpty){
      _surNameValidate=true;
      return false;
    }else if(!imageSet){
      showMessage("Image not set");
      return false;
    }
    return true;

  }

  void showMessage(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(s)),
    );
  }

   openGallery() async {

     final ImagePicker _picker = ImagePicker();

     XFile? pickedFile = await _picker.pickImage( source: ImageSource.gallery);
     setState(() {
       imageFile=pickedFile!.path;
       imageSet=true;
     });


  }

}
