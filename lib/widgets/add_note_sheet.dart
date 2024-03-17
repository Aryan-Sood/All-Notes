import 'package:all_notes/functions/Firebase%20Functions/push_new_note.dart';
import 'package:all_notes/models/note_structure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Color currentColor = Colors.green;

void setColor(Color color) {
  currentColor = color;
}

// String colorToString(Color color) {
//   return '#${color.value.toRadixString(16).substring(2)}';
// }

// Color stringToColor(String color) {
//   return colorFromHex(color) ?? Colors.green;
// }

void AddNoteSheet(BuildContext context, Function(NoteStructure) updateData) {
  final TextEditingController _titleController = TextEditingController();
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                                    id: '1',
                                    color: currentColor,
                                    title: _titleController.text,
                                    created: DateTime.now()),
                              );
                              pushNewNote(NoteStructure(
                                  id: 'not_834hfuhuu4t',
                                  color: currentColor,
                                  title: _titleController.text,
                                  created: DateTime.now()));
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
          ),
        );
      });
}
