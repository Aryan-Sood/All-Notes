import 'package:firebase_auth/firebase_auth.dart';

Future<int> signInWithEmail(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print("User Signed In");
    return 0;
  } catch (e) {
    if (e is FirebaseAuthException) {
      if (e.code == 'user-not-found') {
        // Handle user not found error here
        print('No user found with that email.');
        return 1;
      } else {
        // Handle other FirebaseAuthException errors
        print('Failed to sign in: ${e.message}');
        return 1;
      }
    } else {
      // Handle other errors
      print('Failed to sign in: $e');
      return 1;
    }
  }
}
