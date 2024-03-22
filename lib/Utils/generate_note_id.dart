import 'package:uuid/uuid.dart';

String generateNoteId() {
  var uuid = const Uuid();
  return uuid.v4();
}
