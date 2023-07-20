import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:meddoc/Screens/PatientNavigationBar.dart';
import 'package:meddoc/Styles/applayout.dart';
import 'package:meddoc/Styles/styles.dart';
import 'package:meddoc/Widgets/PrimaryButton.dart';
import '../Widgets/SecondryButton.dart';
import '../Widgets/TitleContainer.dart';
import 'DoctorsBottomBar.dart';
import 'PrivacyPolicy.dart';
import 'VerificationScreen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _emailValidate = false;
  bool _passValidate = false;
  String type = "doctor";
  Color _typeswitchColor = Styles.secondryColor;
  Color _typeswitchColor2 = Styles.bgColor;
  Color _typetxtColor = Colors.white;
  Color _typetxtColor2 = Colors.black;

  bool loading = false;
  String? token;
  bool validate = false;
  final _forgetEmailController = TextEditingController();

  @override
  void initState() {
    checkUser();
    requestPermission();
  }

  @override
  void dispose() {
    _forgetEmailController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Column(
        children: [
          Row(
            children: [
              TitleContainer(
                title: "SIGN IN",
              ),
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/doctorcare.png"))),
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16, color: Colors.black),
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    errorText: _emailValidate
                                        ? 'Must Enter Email'
                                        : null,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    prefixIcon: Icon(Icons.email_outlined,
                                        color: Styles.primaryColor),
                                    prefixIconColor: Colors.white,
                                    hintText: "Enter Your Email Address",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 32.0),
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 32.0),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 32.0),
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                  )),
                              Gap(20),
                              TextField(
                                  controller: _passwordController,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16, color: Colors.black),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  enableSuggestions: false,
                                  decoration: InputDecoration(
                                    errorText: _passValidate
                                        ? 'Must Enter Password'
                                        : null,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    prefixIcon: Icon(Icons.password_outlined,
                                        color: Styles.primaryColor),
                                    prefixIconColor: Colors.white,
                                    hintText: "Enter Your Password",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 32.0),
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 32.0),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 32.0),
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                  )),
                            ],
                          )),
                      Gap(40),
                      loading
                          ? CircularProgressIndicator()
                          : GestureDetector(
                              child: PrimaryButton(
                                  width: size.width,
                                  height: 50,
                                  title: "Sign In"),
                              onTap: () {
                                processData();
                              },
                            ),
                      Gap(25),
                      GestureDetector(
                          onTap: () {
                            openForgetDialog();
                          },
                          child: Text(
                            "Forget Password?",
                            style: GoogleFonts.montserrat(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          )),
                      Gap(40),
                      Container(
                        width: size.width,
                        height: 1,
                        color: Colors.grey,
                      ),
                      Gap(40),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context, _, __) =>
                                    PrivacyPolicy()));
                          },
                          child: SecondryButton(
                            title: 'Sign Up',
                          )),
                    ],
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  void showMessage(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s)),
    );
  }

  void processData() {
    setState(() {
      if (validateFields()) {
        loading = true;
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((value) => {loginPerson(value.user)})
            .onError((error, stackTrace) => {
                  showError(error),
                });
      }
    });
  }

  bool validateFields() {
    if (_emailController.text.isEmpty) {
      _emailValidate = true;
      return false;
    } else if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Password Length should be greater than 6')),
      );
      return false;
    } else if (_passwordController.text.isEmpty) {
      _passValidate = true;
      return false;
    }
    return true;
  }

  loginPerson(User? user) async {
    DatabaseReference reference = FirebaseDatabase.instance
        .ref("Users")
        .child("Doctors")
        .child(user!.uid);
    final snapshot = await reference.get();
    if (snapshot.exists) {
      String status = snapshot.child("docVerified").value.toString();
      if (verfiyUser()) {
        setToken(user, "Doctors");
        if (status == "true") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (builder) => DoctorsNavigationBar(
                        selectedIndex: 0,
                      )));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (builder) => VerificationScreen(
                      uid: FirebaseAuth.instance.currentUser!.uid)));
        }
      } else {
        showEmailVerificationDoctorDialog(user);
      }
    } else {
      if (verfiyUser()) {
        setToken(user, "Patients");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (builder) => PatientNavigationBar(
                      selectedindex: 0,
                    )));
      } else {
        showEmailVerificationDoctorDialog(user);
      }
    }
  }

  void showEmailVerificationDoctorDialog(User? user) {
    User user = FirebaseAuth.instance.currentUser!;
    user
        .sendEmailVerification()
        .whenComplete(() => {
              showCupertinoDialog(
                  context: context,
                  builder: (builder) {
                    return CupertinoAlertDialog(
                      title: Text(
                        "Email Verification",
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      content: Column(
                        children: [
                          Gap(10),
                          Lottie.asset("animations/emailverify.json",
                              width: 250, height: 180, repeat: true),
                          Gap(5),
                          Text(
                            "A verification email has sent to:\n" +
                                _emailController.text +
                                "\nPlease check your inbox to get verified",
                            style: GoogleFonts.montserrat(
                                fontSize: 14, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                          Gap(5),
                          Text(
                            "Login again, if verification completed",
                            style: GoogleFonts.montserrat(
                                fontSize: 14, fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ),
                          CupertinoDialogAction(
                            child: Text(
                              "Ok...!",
                              style: GoogleFonts.montserrat(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            isDefaultAction: true,
                            isDestructiveAction: false,
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                loading = false;
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  })
            })
        .catchError((onError) {
      showMessage(onError.toString());
    });
  }

  setVerification(User user, String type) {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("Users").child(type).child(user!.uid);
    Map<String, Object> map = {
      "emailVerified": true,
    };
    ref.update(map);
  }

  showError(Object? error) {
    setState(() {
      loading = false;
      showMessage(error.toString());
    });
  }

  bool verfiyUser() {
    User user = FirebaseAuth.instance.currentUser!;
    return user.emailVerified;
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void setToken(User user, String type) async {
    await FirebaseMessaging.instance.getToken().then((value) => {
          setState(() {
            token = value;
            print('token' + token!);
          }),
          saveToken(user, type),
        });
  }

  saveToken(User user, String type) async {
    DatabaseReference reference =
        FirebaseDatabase.instance.ref("Users").child(type).child(user.uid);
    Map<String, Object> map = {
      'token': token!,
    };
    await reference.update(map);
  }

  Future<void> checkUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      User user = FirebaseAuth.instance.currentUser!;

      DatabaseReference reference = FirebaseDatabase.instance
          .ref("Users")
          .child("Doctors")
          .child(user.uid);
      final snapshot = await reference.get();
      if (snapshot.exists) {
        String status = snapshot.child("docVerified").value.toString();

        if (verfiyUser()) {
          setToken(user, "Doctors");
          if (status == "true") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (builder) => DoctorsNavigationBar(
                          selectedIndex: 0,
                        )));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (builder) => VerificationScreen(
                        uid: FirebaseAuth.instance.currentUser!.uid)));
          }
        }
      } else {
        if (verfiyUser()) {
          setToken(user, "Patients");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (builder) => PatientNavigationBar(
                        selectedindex: 0,
                      )));
        }
      }
    }
  }

  void openForgetDialog() {
    showCupertinoDialog(
        context: context,
        builder: (builder) {
          return CupertinoAlertDialog(
            title: Text(
              "Forget Password",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            content: Column(
              children: [
                Gap(15),
                Card(
                    color: Colors.transparent,
                    elevation: 0.0,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _forgetEmailController,
                          keyboardType: TextInputType.multiline,
                          onChanged: (value) {
                            if (value.length < 1) {
                              setState(() {
                                validate = false;
                              });
                            } else {
                              setState(() {
                                validate = true;
                              });
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "E-mail Address",
                              filled: true,
                              border: OutlineInputBorder(
                                gapPadding: 2,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              fillColor: Colors.white),
                        ),
                      ],
                    )),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  "Close",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.redAccent),
                ),
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  "Reset",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Styles.primaryColor),
                ),
                isDestructiveAction: true,
                onPressed: () {
                  if (validate) {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(
                            email: _forgetEmailController.text)
                        .catchError((onError) {
                      showMessage(onError.toString());
                    }).then((value) => {
                              showMessage('Reset link sent successfully..'),
                              _forgetEmailController.clear(),
                              Navigator.pop(context),
                            });
                  } else {
                    showMessage("Enter email address");
                  }
                },
              ),
            ],
          );
        });
  }
}
