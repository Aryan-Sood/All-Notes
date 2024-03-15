import 'package:all_notes/Providers/notes_provider.dart';
import 'package:all_notes/functions/change_login_state.dart';
import 'package:all_notes/screens/auth/login.dart';
import 'package:all_notes/models/homepage_note.dart';
import 'package:all_notes/widgets/add_note_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NoteStructure> notes = [
    NoteStructure(Colors.red, "Monday"),
    NoteStructure(Colors.green, "Tuesday"),
    NoteStructure(Colors.blue, "Wednesday"),
    NoteStructure(Colors.orange, "Thursday"),
  ];

  List<Widget> _appBarActionsDefault = [
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.search),
    ),
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.star),
    ),
  ];

  List<Widget> _appBarActionsSecondary = [
    IconButton(
      onPressed: () {},
      icon: Icon(Icons.delete),
    ),
  ];

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

  Future<void> updateNotesLocally() async {
    List<NoteStructure> localNotes =
        await Provider.of<NotesProvider>(context).notesList;
    notes.clear();
    notes = List.from(localNotes);
  }

  void addNewNote(NoteStructure newNote) {
    setState(() {
      notes.add(NoteStructure(Colors.green, newNote.title));
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      child: NoteStructure(
                          notes[index].cardColor, notes[index].title));
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
                  AddNoteSheet(context, addNewNote);
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
