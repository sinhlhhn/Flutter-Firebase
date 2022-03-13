import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;

  const User(this.id, this.email);

  @override
  List<Object> get props => [id];

  static const empty = User("-", "-");
}
