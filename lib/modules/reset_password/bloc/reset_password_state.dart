part of 'reset_password_bloc.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordProcessing extends ResetPasswordState {}

class ResetPasswordFinished extends ResetPasswordState {}

class ResetPasswordFailed extends ResetPasswordState {}
