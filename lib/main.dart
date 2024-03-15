import 'package:all_notes/screens/auth/login.dart';
import 'package:all_notes/screens/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> getLoginState() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final bool loginState = sharedPreferences.getBool('loginState') ?? false;
    return loginState;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'All Notes',
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
