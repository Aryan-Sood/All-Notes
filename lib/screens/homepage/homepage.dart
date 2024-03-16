import 'package:all_notes/Providers/notes_provider.dart';
import 'package:all_notes/functions/change_login_state.dart';
import 'package:all_notes/screens/auth/login.dart';
import 'package:all_notes/models/note.dart';
import 'package:all_notes/widgets/add_note_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User user;
  late DatabaseReference notesReference;

  late List<NoteStructure> notes = [];

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

  @override
  void initState() {
    super.initState();
    print("running init state");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        updateNotesLocally();
      });
    });
    print("init state finished");

    // user = FirebaseAuth.instance.currentUser!;
    // notesReference = FirebaseDatabase.instance
    //     .ref()
    //     .child('users')
    //     .child(user.uid)
    //     .child('notes');
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
        Provider.of<NotesProvider>(context, listen: false).notesList;
    print("old size: ${notes.length}");
    notes = [...localNotes];
    print("new size ${notes.length}");
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
