import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordDialog extends StatefulWidget {
  String uid;
   ChangePasswordDialog({Key? key,required this.uid}) : super(key: key);

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final password=TextEditingController();
  final confirmpassword=TextEditingController();

  bool validate=true;

  @override
  void dispose() {
    password.dispose();
    confirmpassword.dispose();
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
                  controller: password,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
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
                      labelText: "Enter new Password",
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
                  controller: confirmpassword,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
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
                      labelText: "Re-enter password",
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
        CupertinoButton(child: Text("Save Password",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),), onPressed: (){
          if(validate){
            if(password.text==confirmpassword.text){
              FirebaseAuth.instance.currentUser!.updatePassword(password.text).catchError((onError){
                showMessage(onError.toString());
              }).then((value) => {
                Navigator.pop(context),
              });
            }else{
              showMessage("Passwords are not same..");
            }
          }else{
            showMessage("Fields are empty");
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
}
