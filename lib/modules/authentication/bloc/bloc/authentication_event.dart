part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);
  final AuthenticationStatus status;
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
