import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String? email;

  const UserModel(this.id, this.email);

  @override
  List<Object> get props => [id];

  static const empty = UserModel("-", "-");
}
