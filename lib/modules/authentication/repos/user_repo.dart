import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_app/modules/authentication/models/user.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;

    final user = await FirebaseAuth.instance.currentUser();
    final id = user.uid;
    final email = user.email;

    return User(id, email);
  }
}
