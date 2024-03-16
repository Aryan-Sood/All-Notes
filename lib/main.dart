import 'package:all_notes/Providers/notes_provider.dart';
import 'package:all_notes/screens/auth/login.dart';
import 'package:all_notes/screens/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
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
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    setState(() {
      loginStatus = sharedPreferences.getBool('loginState') ?? false;
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
    return ChangeNotifierProvider(
      create: (context) => NotesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'All Notes',
        home: Scaffold(
          body: loginStatus ? HomePage() : LoginPage(),
        ),
      ),
    );
  }
}
