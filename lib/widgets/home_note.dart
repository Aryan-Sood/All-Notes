import 'package:all_notes/screens/others/detailed_note.dart';
import 'package:flutter/material.dart';

class HomeNote extends StatefulWidget {
  late Color color;
  late String title;
  late String content;
  late String time;

  HomeNote(
      {super.key,
      required this.title,
      required this.color,
      required this.content,
      required this.time});

  @override
  State<StatefulWidget> createState() => _HomeNote();
}

class _HomeNote extends State<HomeNote> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailedNote(
              title: widget.title,
              content: widget.content,
              time: widget.time,
            ),
          ),
        );
      },
      child: Card(
        color: widget.color,
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
      ),
    );
  }
}
