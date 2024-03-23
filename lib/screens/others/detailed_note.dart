import 'package:all_notes/widgets/note_appbar.dart';
import 'package:all_notes/widgets/note_title_field.dart';
import 'package:flutter/material.dart';

class DetailedNote extends StatefulWidget {
  String title;
  String content;
  String time;
  bool creating;

  DetailedNote(
      {super.key,
      required this.title,
      required this.content,
      required this.time,
      required this.creating});

  @override
  State<DetailedNote> createState() => _DetailedNoteState();
}

class _DetailedNoteState extends State<DetailedNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotesAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NoteTitleField(
                    maxLines: null,
                    title: widget.creating ? 'Enter title' : widget.title,
                    decoration: const InputDecoration(
                      hintText: 'Enter title',
                      border: InputBorder.none,
                    ),
                    textStyle:
                        const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  NoteTitleField(
                    maxLines: null,
                    title: widget.creating ? 'Start writing' : widget.title,
                    decoration: const InputDecoration(
                      hintText: 'Start writing',
                      border: InputBorder.none,
                    ),
                    textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
