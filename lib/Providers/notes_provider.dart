import 'package:all_notes/models/homepage_note.dart';
import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {
  List<NoteStructure> notesList = [];

  void addNote(String title) {
    notesList.add(NoteStructure(Colors.green, title));
    notifyListeners();
  }
}
