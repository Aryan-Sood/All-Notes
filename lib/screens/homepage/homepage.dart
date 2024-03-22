import 'dart:convert';

import 'package:all_notes/Utils/serial_deserial_notes.dart';
import 'package:all_notes/Utils/change_login_state.dart';
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

    updateLocalNotesFromServer().then((value) {}).then(
      (value) {
        retrieveLocalNotes().then(
          (value) {
            setState(() {
              notes = List.from(value);
              loading = false;
            });
          },
        );
      },
    );
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

  Color stringToColor(String colorString) {
    if (colorString.startsWith('#')) {
      colorString = colorString.substring(1);
    }
    if (colorString.length == 6) {
      colorString = 'FF' + colorString;
    }
    int colorHex = int.parse(colorString, radix: 16);
    return Color(colorHex);
  }

  void logOutUser() async {
    await FirebaseAuth.instance.signOut();
    changeLoginState(false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  Future<List<NoteStructure>> retrieveLocalNotes() async {
    notesPrefs = await getSharedPreferences(notesPrefName);
    List<String> noteJson = notesPrefs.getStringList('notes') ?? [];
    return noteJson
        .map((json) => deserializeNoteData(jsonDecode(json)))
        .toList();
  }

  Future<void> updateLocalNotesFromServer() async {
    User user = FirebaseAuth.instance.currentUser!;
    String UID = user.uid;
    notesPrefs = await getSharedPreferences(notesPrefName);
    List<String> fetchedNotes = [];
    List<NoteStructure> serverNotes = [];
    DatabaseReference notesRef = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(UID)
        .child('Notes');
    await notesRef.once().then(
      (DatabaseEvent event) {
        Map<dynamic, dynamic>? notesMap =
            event.snapshot.value as Map<dynamic, dynamic>;
        if (notesMap.isNotEmpty) {
          notesMap.forEach(
            (key, value) {
              serverNotes.add(
                NoteStructure(
                  id: value['id'],
                  color: stringToColor(value['color']),
                  title: value['title'],
                  created: DateTime.parse(
                    value['created'],
                  ),
                ),
              );
              fetchedNotes.add(
                json.encode(
                  serializeNoteData(
                    value['id'],
                    stringToColor(value['color']),
                    value['title'],
                    DateTime.parse(
                      value['created'],
                    ),
                  ),
                ),
              );
            },
          );
          // setState(() {
          //   notes = List.from(serverNotes);
          // });
          //
        }
      },
    );
    print("length of fetched notes: ${fetchedNotes}");
    await notesPrefs.setStringList('notes', fetchedNotes);
  }

  void addNewNote(NoteStructure newNote) {
    setState(() {
      notes.add(
        NoteStructure(
          id: newNote.id,
          color: newNote.color,
          title: newNote.title,
          created: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          backgroundColor: Colors.white,
          actions: _appBarActionsDefault,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text("Log Out"),
                onTap: () {
                  logOutUser();
                },
              ),
            ],
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Loading your notes',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    } else {
      if (notes.isEmpty) {
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
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Settings",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text("Log Out"),
                  onTap: () {
                    logOutUser();
                  },
                ),
              ],
            ),
          ),
          body: Stack(children: [
            const Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Seems empty!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 16,
                right: 16,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shadowColor: Colors.blue),
                  onPressed: () {
                    addNoteSheet(context, addNewNote);
                  },
                  child: const Text(
                    "+",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ))
          ]),
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
                const DrawerHeader(
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
                  title: const Text("Log Out"),
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
                padding: const EdgeInsets.only(
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
                          icon: const Icon(Icons.delete),
                        ),
                      ];
                    });
                  },
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                        padding: const EdgeInsets.all(15),
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shadowColor: Colors.blue),
                    onPressed: () {
                      addNoteSheet(context, addNewNote);
                    },
                    child: const Text(
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
}
