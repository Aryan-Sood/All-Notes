import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NoteStructure extends StatefulWidget {
  late Color cardColor;
  late String title;

  NoteStructure(Color color, String title) {
    this.cardColor = color;
    this.title = title;
  }

  @override
  State<StatefulWidget> createState() => _NoteStructure();
}

class _NoteStructure extends State<NoteStructure> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.cardColor,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          '${widget.title}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
