import 'package:firebase_auth/firebase_auth.dart';

class UserConfiguration {
  late String UID;
  late String email;

  void setData() {
    User user = FirebaseAuth.instance.currentUser!;
    UID = user.uid;
    email = user.email!;
  }
}
