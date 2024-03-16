import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

Future<bool> createUserWithEmail(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = FirebaseAuth.instance.currentUser;
    String UID = user!.uid;
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('users').child(UID);
    databaseReference.set(
      {'email': user.email},
    );
    DatabaseReference datareference =
        FirebaseDatabase.instance.ref().child('users').child(UID).child('data');

    return true;
  } catch (e) {
    print("Failed to register user");
    return false;
  }
}
