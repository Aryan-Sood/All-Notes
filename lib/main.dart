import 'package:all_notes/screens/auth/login.dart';
import 'package:all_notes/screens/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

String pref1Name = 'loginPrefs';
late SharedPreferences loginPrefs;

Future<SharedPreferences> getSharedPreferences(String name) async {
  return await SharedPreferences.getInstance();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  loginPrefs = await getSharedPreferences(pref1Name);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loginStatus = false;

  Future<void> getLoginState() async {
    setState(() {
      loginStatus = loginPrefs.getBool('loginState') ?? false;
    });
    print(loginStatus);
  }

  @override
  void initState() {
    super.initState();
    getLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'All Notes',
      home: Scaffold(
        body: loginStatus ? HomePage() : LoginPage(),
      ),
    );
  }
}
