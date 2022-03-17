import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_app/modules/authentication/models/user.dart';

class UserRepository {
  UserModel? _user;

  Future<UserModel?> getUser() async {
    if (_user == null) {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _user = UserModel.empty;
      } else {
        final id = user.uid;
        final email = user.email;
        _user = UserModel(id, email);
      }
    }
    return _user;
  }
}
