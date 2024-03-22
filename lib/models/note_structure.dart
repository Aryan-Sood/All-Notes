import 'package:flutter/material.dart';

class NoteStructure {
  late String id;
  late Color color;
  late String title;
  late DateTime created;

  NoteStructure(
      {required this.id, required this.color, required this.title, required this.created});
}
