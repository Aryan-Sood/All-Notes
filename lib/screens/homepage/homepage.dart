import 'package:all_notes/functions/changeLoginState.dart';
import 'package:all_notes/screens/auth/login.dart';
import 'package:all_notes/widgets/homepage_note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    printLoginData();
  }

  void printLoginData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    print(user!.displayName);
    print(user.email);
    print(user.uid);
  }

  void logOutUser() async {
    await FirebaseAuth.instance.signOut();
    changeLoginState(false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.star),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Options",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              title: Text("Log Out"),
              onTap: () {
                logOutUser();
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        width: double.infinity,
        height: double.infinity,
        child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, position) {
              return NoteStructure(position, Colors.red);
            }),
      ),
    );
  }
}
