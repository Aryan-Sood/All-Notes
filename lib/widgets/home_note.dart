import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class HomeNote extends StatefulWidget {
  late Color color;
  late String title;

  HomeNote({required this.title, required this.color});

  @override
  State<StatefulWidget> createState() => _HomeNote();
}

class _HomeNote extends State<HomeNote> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
