import 'package:all_notes/Providers/notes_provider.dart';
import 'package:all_notes/models/homepage_note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void AddNoteSheet(BuildContext context, Function(NoteStructure) updateData) {
  final TextEditingController _titleController = TextEditingController();
  showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 40,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height - 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "New Note",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    controller: _titleController,
                    decoration: InputDecoration(
                        labelText: "Title", alignLabelWithHint: true),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_titleController.text.isNotEmpty) {
                            updateData(
                              NoteStructure(
                                  Colors.green, _titleController.text),
                            );
                            Provider.of<NotesProvider>(context, listen: false)
                                .addNote(_titleController.text);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
