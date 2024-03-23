import 'package:all_notes/models/note_structure.dart';
import 'package:flutter/material.dart';

Map<String, dynamic> serializeNoteData(
    String id, Color color, String title, String content, DateTime created) {
  return {
    'id': id,
    'color': color.value.toRadixString(16),
    'title': title,
    'content': content,
    'createdAt': created.toString(),
  };
}

NoteStructure deserializeNoteData(Map<String, dynamic> data) {
  return NoteStructure(
    id: data['id'],
    color: Color(
      int.parse(data['color'], radix: 16),
    ),
    title: data['title'],
    content: data['content'],
    created: DateTime.parse(
      data['createdAt'],
    ),
  );
}
