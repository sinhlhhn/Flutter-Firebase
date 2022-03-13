import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordRepository {
  final _instance = FirebaseAuth.instance;

  Future<void> resetPassword(String email) async {
    try {
      await _instance.sendPasswordResetEmail(email: email);
    } catch (_) {
      rethrow;
    }
  }
}
