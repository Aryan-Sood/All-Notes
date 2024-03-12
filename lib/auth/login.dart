import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _Loginpage();
}

class _Loginpage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blue),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/notes_animation.json',
            width: 200,
            height: 200,
          )
        ],
      ),
    );
  }
}
