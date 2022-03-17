part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.status = AuthenticationStatus.unknown,
    this.user = UserModel.empty,
  });

  const AuthenticationState.unknown() : this();

  const AuthenticationState.authenticated(UserModel user)
      : this(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final UserModel user;

  @override
  List<Object?> get props => [user, status];
}
