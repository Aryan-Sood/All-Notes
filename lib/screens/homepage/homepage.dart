import 'dart:convert';

import 'package:all_notes/Utils/serial_deserial_notes.dart';
import 'package:all_notes/functions/Others/change_login_state.dart';
import 'package:all_notes/models/note_structure.dart';
import 'package:all_notes/screens/auth/login.dart';
import 'package:all_notes/widgets/add_note_sheet.dart';
import 'package:all_notes/widgets/home_note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User user;
  late DatabaseReference notesReference;
  bool loading = true;
  List<NoteStructure> allLocalNotes = [];

  late SharedPreferences notesPrefs;

  late List<NoteStructure> notes = [];

  List<Widget> _appBarActionsDefault = [
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.search),
    ),
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.star),
    ),
  ];

  @override
  void initState() {
    super.initState();
    print("running init state");
    retrieveLocalNotes().then((value) {
      print("initial value: ${value.length}");
      allLocalNotes = List.from(value);
      setState(() {
        notes = List.from(allLocalNotes);
        print("set state: ${notes.length}");
        notes.forEach((element) {
          print(element.title);
        });
        loading = false;
      });
    });

    // updateNotesLocallyFromServer().then(
    //   (_) => setState(
    //     () {
    //       loading = false;
    //     },
    //   ),
    // );
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {
    //     updateNotesLocally();
    //   });
    // });
    print("init state finished");
  }

  Future<SharedPreferences> getSharedPreferences(String name) async {
    return await SharedPreferences.getInstance();
  }

  void printLoginData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    print(user!.displayName);
    print(user.email);
    print(user.uid);
  }

  String colorToString(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
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

  Future<List<NoteStructure>> retrieveLocalNotes() async {
    notesPrefs = await getSharedPreferences(notesPrefName);
    List<String> noteJson = notesPrefs.getStringList('notes') ?? [];
    return noteJson.map((json) => deserializeNoteData(jsonDecode(json))).toList();;
  }

  Future<void> updateNotesLocallyFromServer() async {
    User user = FirebaseAuth.instance.currentUser!;
    String UID = user.uid;
    // DatabaseReference notesRef = FirebaseDatabase.instance
    //     .ref()
    //     .child('users')
    //     .child(UID)
    //     .child('Notes');
    // print('Key is: ${notesRef.key}');
    // print('get reference: ${notesRef.root.get().toString()}');
    // DatabaseEvent event = await notesRef.once();
    // print('event: ${event.snapshot.children}');

    DatabaseReference reference = FirebaseDatabase.instance.ref();
    DatabaseEvent event = await reference.child('users').once();
    DataSnapshot snapshot = event.snapshot;
    // Map<dynamic, dynamic> usersData = Map.fromIterable(snapshot.value);
  }

  void addNewNote(NoteStructure newNote) {
    setState(() {
      notes.add(NoteStructure(
          color: newNote.color, title: newNote.title, created: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Notes"),
          backgroundColor: Colors.white,
          actions: _appBarActionsDefault,
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
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              width: double.infinity,
              height: double.infinity,
              child: GestureDetector(
                onLongPress: () {
                  setState(() {
                    _appBarActionsDefault = [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete),
                      ),
                    ];
                  });
                },
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return GridTile(
                      child: HomeNote(
                        title: notes[index].title,
                        color: notes[index].color,
                      ),
                    );
                  },
                  itemCount: notes.length,
                ),
              ),
            ),
            Positioned(
                bottom: 16,
                right: 16,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      shape: CircleBorder(),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shadowColor: Colors.blue),
                  onPressed: () {
                    addNoteSheet(context, addNewNote);
                  },
                  child: Text(
                    "+",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ))
          ],
        ),
      );
    }
  }
}
