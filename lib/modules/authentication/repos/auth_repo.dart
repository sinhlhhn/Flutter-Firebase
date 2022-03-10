import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

enum AuthenticationStatus { unknown, autheticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> login(String userName, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userName, password: password);
      _controller.add(AuthenticationStatus.autheticated);
    } on PlatformException catch (e) {
      _controller.addError(e);
      return;
    } catch (e) {
      _controller.addError(e);
      return;
    }
  }

  Future<void> register(String userName, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userName, password: password);
      _controller.add(AuthenticationStatus.autheticated);
    } on PlatformException catch (e) {
      _controller.addError(e);
      return;
    } catch (e) {
      _controller.addError(e);
      return;
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      _controller.add(AuthenticationStatus.unauthenticated);
    } catch (e) {
      _controller.addError(e);
      return;
    }
  }

  void dispose() {
    _controller.close();
  }
}
