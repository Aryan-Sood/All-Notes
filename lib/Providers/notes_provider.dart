import 'package:all_notes/models/note.dart';
import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {
  List<NoteStructure> notesList = [
    NoteStructure(Colors.red, 'Monday'),
  ];

  void addNote(String title) {
    notesList.add(NoteStructure(Colors.green, title));
    notifyListeners();
  }
}
