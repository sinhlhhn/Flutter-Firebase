part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class SendTapped extends ResetPasswordEvent {
  final String email;
  const SendTapped(this.email);

  @override
  List<Object> get props => [];
}
