import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_app/commom/constant/user_default.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final Future<SharedPreferences> _userDefault =
      SharedPreferences.getInstance();

  Stream<AuthenticationStatus> get status async* {
    // await Future<void>.delayed(const Duration(seconds: 1));
    yield await _getCurrentAuthenStatus();
    yield* _controller.stream;
  }

  Future<void> login(String userName, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userName, password: password);
      _controller.add(AuthenticationStatus.authenticated);
      _saveCurrentAuthenStatus(true);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> register(String userName, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userName, password: password);
      _controller.add(AuthenticationStatus.authenticated);
      _saveCurrentAuthenStatus(true);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      _controller.add(AuthenticationStatus.unauthenticated);
      _saveCurrentAuthenStatus(false);
    } catch (_) {
      rethrow;
    }
  }

  Future<AuthenticationStatus> _getCurrentAuthenStatus() async {
    final userDefault = await _userDefault;
    final isAuthenticated =
        userDefault.getBool(UserDefaultKey.isAuthenticated) ?? false;

    return isAuthenticated
        ? AuthenticationStatus.authenticated
        : AuthenticationStatus.unauthenticated;
  }

  void _saveCurrentAuthenStatus(bool isAuthenticated) async {
    final userDefault = await _userDefault;
    userDefault.setBool(UserDefaultKey.isAuthenticated, isAuthenticated);
  }

  void dispose() {
    _controller.close();
  }
}
