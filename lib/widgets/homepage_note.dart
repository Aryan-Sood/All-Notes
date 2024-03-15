import 'package:flutter/material.dart';

class NoteStructure extends StatefulWidget {
  late int position;
  late Color cardColor;

  NoteStructure(int position, Color color) {
    this.position = position;
    this.cardColor = color;
  }

  @override
  State<StatefulWidget> createState() => _NoteStructure();
}

class _NoteStructure extends State<NoteStructure> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${widget.position}'),
          ),
        );
      },
      child: Card(
        color: widget.cardColor,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            '${widget.position}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
