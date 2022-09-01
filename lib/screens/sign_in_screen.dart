import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/register_screen.dart';
import 'package:chatapp/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInScreen extends StatefulWidget {
  static const String screenRoute = "signin_screen";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  bool passwordvisible = true;
  bool iconvisible = true;

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: Color(0xff003944),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 250,
                  child: Image.asset("assets/images/chaticon.jpg"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Sign in",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    /*onChanged: (value) {
                      email = value;
                    },*/
                    decoration: const InputDecoration(
                      hintText: "Enter Your E-mail...",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff003944),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff003944),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: passwordTextEditingController,
                    obscureText: passwordvisible,
                    decoration: InputDecoration(
                      hintText: "Enter Your Password...",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordvisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xff003944),
                        ),
                        onPressed: () => setState(() {
                          passwordvisible = !passwordvisible;
                        }),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff003944),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff003944),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Buttons(
                  color: const Color(0xff003944),
                  title: "Sign in",
                  tabButton: () async {
                    if (emailTextEditingController.text.isEmpty &&
                        passwordTextEditingController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Enter Your E-mail and Password, please..");
                    } else if (emailTextEditingController.text.isNotEmpty &&
                        passwordTextEditingController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Enter You Password, please..");
                    } else if (emailTextEditingController.text.isEmpty &&
                        passwordTextEditingController.text.isNotEmpty) {
                      Fluttertoast.showToast(msg: "Enter You E-mail, please..");
                    } else if (!emailTextEditingController.text.contains("@")) {
                      Fluttertoast.showToast(msg: "Email address is not Valid");
                    } else if (passwordTextEditingController.text.length < 6) {
                      Fluttertoast.showToast(
                          msg: "Password must be at least 6 Characters");
                    } else {
                      setState(() {
                        showSpinner = true;
                      });
                    }
                    try {
                      final user = await _auth
                          .signInWithEmailAndPassword(
                              email: emailTextEditingController.text.trim(),
                              password:
                                  passwordTextEditingController.text.trim())
                          .catchError((msg) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: "Error: " + msg.toString());
                      });
                      if (user != null) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (c) => ChatScreen()));
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                TextButton(
                  child: const Text(
                    "Do not have an Account? REGISTER HERE",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => RegisterScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
