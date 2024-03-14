import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

Future<bool> checkIfUserExists(String email) async {
  try {
    List<String> signInMethods =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    // (signInMethods.isNotEmpty) ? print("exists") : print("not exists");
    print(signInMethods);
    return signInMethods.isNotEmpty;
  } catch (e) {
    print("Failed to check user existence");
    throw e;
  }
}
