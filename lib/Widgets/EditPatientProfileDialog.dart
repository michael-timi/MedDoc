import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPatientProfileDialog extends StatefulWidget {
  String uid,age,address,name,phonenumber;
  bool doctor;
   EditPatientProfileDialog({Key? key,required this.doctor,required this.address,required this.phonenumber,required this.name,required this.uid,required this.age}) : super(key: key);

  @override
  State<EditPatientProfileDialog> createState() => _EditPatientProfileDialogState();
}

class _EditPatientProfileDialogState extends State<EditPatientProfileDialog> {
  final _ageController=TextEditingController();
  final _addressController=TextEditingController();
  final _nameController=TextEditingController();
  final _phoneNumberController=TextEditingController();

  bool validate=true;

  @override
  void initState() {
    _ageController.text=widget.age;
    _addressController.text=widget.address;
    _nameController.text=widget.name;
    _phoneNumberController.text=widget.phonenumber;
  }

  @override
  void dispose() {
    _ageController.dispose();
    _addressController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(10),
        Card(
            color: Colors.transparent,
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value){
                    if(value.length<1){
                      setState(() {
                        validate=false;
                      });
                    }else{
                      setState(() {
                        validate=true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Name",
                      filled: true,
                      border: OutlineInputBorder(
                        gapPadding: 2,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      fillColor: Colors.white),
                ),
              ],
            )),
        Gap(5),
        Card(
            color: Colors.transparent,
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _addressController,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value){
                    if(value.length<1){
                      setState(() {
                        validate=false;
                      });
                    }else{
                      setState(() {
                        validate=true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Address",
                      filled: true,
                      border: OutlineInputBorder(
                        gapPadding: 2,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      fillColor: Colors.white),
                ),
              ],
            )),
        Gap(5),
        Card(
            color: Colors.transparent,
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value){
                    if(value.length<1){
                      setState(() {
                        validate=false;
                      });
                    }else{
                      setState(() {
                        validate=true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Age",
                      filled: true,
                      border: OutlineInputBorder(
                        gapPadding: 2,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      fillColor: Colors.white),
                ),
              ],
            )),
        Gap(5),
        Card(
            color: Colors.transparent,
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value){
                    if(value.length<1){
                      setState(() {
                        validate=false;
                      });
                    }else{
                      setState(() {
                        validate=true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Phone Number",
                      filled: true,
                      border: OutlineInputBorder(
                        gapPadding: 2,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      fillColor: Colors.white),
                ),
              ],
            )),
        Gap(10),
        CupertinoButton(child: Text("Save",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),), onPressed: (){

          if(widget.doctor){
            saveDoctor();
          }else{
            savePatient();
          }


        }),

      ],

    );
  }
  void showMessage(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s)),
    );
  }

  void savePatient() {
    if(validate){
      DatabaseReference ref=FirebaseDatabase.instance.ref("Users").child("Patients").child(widget.uid);
      Map<String,Object> map={
        'name':_nameController.text,
        'age':_ageController.text,
        'address':_addressController.text,
        'phonenumber':_phoneNumberController.text,
      };
      ref.update(map).whenComplete(() => {
        Navigator.pop(context),
      });
    }else{
      showMessage("Some Fields are Empty...");
    }
  }

  void saveDoctor() {
    if(validate){
      DatabaseReference ref=FirebaseDatabase.instance.ref("Users").child("Doctors").child(widget.uid);
      Map<String,Object> map={
        'name':_nameController.text,
        'age':_ageController.text,
        'hospitalAddress':_addressController.text,
        'phonenumber':_phoneNumberController.text,
      };
      ref.update(map).whenComplete(() => {
        Navigator.pop(context),
      });
    }else{
      showMessage("Some Fields are Empty...");
    }
  }
}
