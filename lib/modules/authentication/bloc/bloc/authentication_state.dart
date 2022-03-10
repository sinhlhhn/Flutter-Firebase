part of 'authentication_bloc.dart';

class AuthenticationState {
  const AuthenticationState({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  const AuthenticationState.unknown() : this();

  const AuthenticationState.authenticated(User user)
      : this(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;
}
