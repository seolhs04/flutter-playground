import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _firebase = FirebaseAuth.instance;

  static createUser(String email, String password) async {
    try {
      return await _firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (err) {
      throw Exception(err.message);
    }
  }

  static signIn(String email, String password) async {
    try {
      return await _firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (err) {
      throw Exception(err.message);
    }
  }
}
