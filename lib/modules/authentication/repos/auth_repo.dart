import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _instance = FirebaseAuth.instance;

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unknown;
    yield* _controller.stream;
  }

  Future<void> login(String userName, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userName, password: password);
      _controller.add(AuthenticationStatus.authenticated);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> register(String userName, String password) async {
    try {
      await _instance.createUserWithEmailAndPassword(
          email: userName, password: password);
      _controller.add(AuthenticationStatus.authenticated);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _instance.signOut();
      _controller.add(AuthenticationStatus.unauthenticated);
    } catch (_) {
      rethrow;
    }
  }

  void dispose() {
    _controller.close();
  }
}
