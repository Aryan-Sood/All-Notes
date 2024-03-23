import 'dart:convert';

import 'package:all_notes/Utils/generate_note_id.dart';
import 'package:all_notes/Utils/serial_deserial_notes.dart';
import 'package:all_notes/functions/Firebase%20Functions/push_new_note.dart';
import 'package:all_notes/models/note_structure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color currentColor = Colors.green;
String notesPrefName = 'notes';
late SharedPreferences notesPrefs;
String noteId = generateNoteId();

Future<SharedPreferences> getSharedPreferences(String name) async {
  return await SharedPreferences.getInstance();
}

void setColor(Color color) {
  currentColor = color;
}

void addNoteSheet(BuildContext context, Function(NoteStructure) updateData) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20
            ),
            child: Container(
              height: MediaQuery.of(context).size.height ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "New Note",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    controller: titleController,
                    decoration: const InputDecoration(
                        labelText: "Title", alignLabelWithHint: true),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    controller: contentController,
                    decoration: const InputDecoration(
                        labelText: "Content", alignLabelWithHint: true),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ColorPicker(
                    pickerColor: currentColor,
                    onColorChanged: setColor,
                    displayThumbColor: false,
                    hexInputBar: false,
                    paletteType: PaletteType.hueWheel,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (titleController.text.isNotEmpty) {
                            updateData(
                              NoteStructure(
                                  id: noteId,
                                  color: currentColor,
                                  title: titleController.text,
                                  content: contentController.text,
                                  created: DateTime.now()),
                            );
            
                            //add note in firebase
                            pushNewNote(NoteStructure(
                                id: noteId,
                                color: currentColor,
                                title: titleController.text,
                                content: contentController.text,
                                created: DateTime.now()));
            
                            // save note locally
                            notesPrefs =
                                await getSharedPreferences(notesPrefName);
                            List<String> notes =
                                notesPrefs.getStringList(notesPrefName) ?? [];
                            notes.add(json.encode(serializeNoteData(
                                noteId,
                                currentColor,
                                titleController.text,
                                contentController.text,
                                DateTime.now())));
                            await notesPrefs.setStringList('notes', notes);
            
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text(
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
