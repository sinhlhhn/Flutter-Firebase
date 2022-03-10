import 'package:simple_app/modules/authentication/models/user.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;

    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = const User("FIRST USER"),
    );
  }
}
