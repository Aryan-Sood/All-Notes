import 'package:all_notes/Utils/change_login_state.dart';
import 'package:all_notes/functions/Firebase%20Functions/email_login.dart';
import 'package:all_notes/screens/auth/register_page.dart';
import 'package:all_notes/screens/homepage/homepage.dart';
import 'package:all_notes/widgets/credentials_field.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

String pref1Name = 'loginPrefs';
late SharedPreferences loginPrefs;

Future<SharedPreferences> getSharedPreferences(String name) async {
  return await SharedPreferences.getInstance();
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _Loginpage();
}

class _Loginpage extends State<LoginPage> {
  bool loginSuccess = false;

  @override
  void initState() {
    super.initState();
    getSharedPreferences(pref1Name).then((value) => loginPrefs = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.green, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
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
              reverse: true,
            ),
            const SizedBox(
              height: 40,
            ),
            const LoginContainer(),
          ],
        ),
      ),
    );
  }
}

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<StatefulWidget> createState() => _LoginContainer();
}

class _LoginContainer extends State<LoginContainer> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loginSuccess = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 1),
            color: Colors.transparent.withOpacity(0.1),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  'Login to your existing account',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CredentialsField(
                  controller: emailController,
                  hint: 'Email',
                  icon: const Icon(Icons.email_rounded),
                ),
                const SizedBox(
                  height: 20,
                ),
                CredentialsField(
                  controller: passwordController,
                  hint: 'Password',
                  icon: const Icon(Icons.lock),
                ),
                const SizedBox(
                  height: 3,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          loginSuccess = await signInWithEmail(
                              emailController.text, passwordController.text);
                          if (loginSuccess) {
                            changeLoginState(true);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Create account here',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
