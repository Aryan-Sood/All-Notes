import 'package:all_notes/models/note_structure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void pushNewNote(NoteStructure newNote) async {
  try {
    User user = FirebaseAuth.instance.currentUser!;
    String UID = user.uid;
    DatabaseReference notesRef = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(UID)
        .child('Notes')
        .child(newNote.id);
    await notesRef.set({
      'id': notesRef.key,
      'color': colorToHex(newNote.color),
      'title': newNote.title,
      'created': DateTime.now().toString(),
    });
  } catch (error) {
    print('Error spushing note: ${error.toString()}');
  }
}
