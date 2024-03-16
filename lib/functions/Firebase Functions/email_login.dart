import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signInWithEmail(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print("User Signed In");
    return true;
  } catch (e) {
    if (e is FirebaseAuthException) {
      if (e.code == 'user-not-found') {
        // Handle user not found error here
        print('No user found with that email.');
        return false;
      } else {
        // Handle other FirebaseAuthException errors
        print('Failed to sign in: ${e.message}');
        return false;
      }
    } else {
      // Handle other errors
      print('Failed to sign in: $e');
      return false;
    }
  }
}
