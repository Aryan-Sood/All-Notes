import 'package:all_notes/models/note_structure.dart';
import 'package:flutter/material.dart';

Map<String, dynamic> serializeNoteData(
    Color color, String title, DateTime created) {
  return {
    'color': color.value.toRadixString(16),
    'title': title,
    'createdAt': created.toString(),
  };
}

NoteStructure deserializeNoteData(Map<String, dynamic> data) {
  return NoteStructure(
    color: Color(
      int.parse(data['color'], radix: 16),
    ),
    title: data['title'],
    created: DateTime.parse(
      data['createdAt'],
    ),
  );
}
