import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoteTitleField extends TextField {
  final String title;
  final int? maxLines;
  const NoteTitleField({
    super.key,
    required this.title,
    required InputDecoration decoration,
    required TextStyle textStyle,
    this.maxLines
  }) : super(decoration: decoration, style: textStyle, maxLines: maxLines);
}
