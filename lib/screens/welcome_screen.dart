import 'package:chatapp/screens/register_screen.dart';
import 'package:chatapp/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = "welcome_screen";
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 250,
            child: Image.asset("assets/images/chaticon.jpg"),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Fast Msg",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w900, fontSize: 30),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          Buttons(
            color: const Color(0xff003944),
            title: "SignIn",
            tabButton: () {
              Navigator.pushNamed(context, SignInScreen.screenRoute);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Buttons(
            color: const Color(0xFFfffe58),
            title: "Register",
            tabButton: () {
              Navigator.pushNamed(context, RegisterScreen.screenRoute);
            },
          ),
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  Buttons({
    required this.color,
    required this.title,
    required this.tabButton,
  });

  final Color color;
  final String title;
  final VoidCallback tabButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Material(
        elevation: 6,
        color: color,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed: tabButton,
          minWidth: 510,
          height: 30,
          child: Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
