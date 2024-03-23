import 'package:all_notes/functions/Firebase%20Functions/create_email_account.dart';
import 'package:all_notes/screens/auth/login.dart';
import 'package:all_notes/widgets/credentials_field.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
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
            RegisterContainer(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterContainer extends StatefulWidget {
  const RegisterContainer({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterContainer();
}

class _RegisterContainer extends State<RegisterContainer> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool accountCreationSuccess = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: BoxDecoration(
            color: Colors.transparent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 1),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Let\'s get started',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  'Create an account',
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
                  icon: const Icon(Icons.person),
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
                  height: 20,
                ),
                CredentialsField(
                  controller: confirmPasswordController,
                  hint: 'Confirm Password',
                  icon: const Icon(Icons.lock),
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
                          accountCreationSuccess = await createUserWithEmail(
                              emailController.text, passwordController.text);
                          if (accountCreationSuccess) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'SIGN UP',
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
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Already have an account?',
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
