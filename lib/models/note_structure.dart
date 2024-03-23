import 'package:flutter/material.dart';

class NoteStructure {
  late String id;
  late Color color;
  late String title;
  late String content;
  late DateTime created;

  NoteStructure(
      {required this.id,
      required this.color,
      required this.title,
      required this.content,
      required this.created});
}
