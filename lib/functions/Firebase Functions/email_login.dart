import 'package:all_notes/functions/Firebase%20Functions/create_email_account.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> signInWithEmail(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print("User Signed In");
  } catch (e) {
    if (e is FirebaseAuthException) {
      if (e.code == 'user-not-found') {
        // Handle user not found error here
        print('No user found with that email.');
        print("creating account ........");
        await createUserWithEmail(email, password);
        print("account created");
      } else {
        // Handle other FirebaseAuthException errors
        print('Failed to sign in: ${e.message}');
        print("creating account ........");
        await createUserWithEmail(email, password);
        print("account created");
      }
    } else {
      // Handle other errors
      print('Failed to sign in: $e');
      print("creating account ........");
      await createUserWithEmail(email, password);
      print("account created");
    }
  }
}
