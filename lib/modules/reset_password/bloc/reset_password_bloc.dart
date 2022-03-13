import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_app/modules/authentication/repos/auth_repo.dart';
import 'package:simple_app/modules/reset_password/repos/reset_password_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordRepository _resetPasswordRepository;

  ResetPasswordBloc({required ResetPasswordRepository resetPasswordRepository})
      : _resetPasswordRepository = resetPasswordRepository,
        super(ResetPasswordInitial()) {
    on<SendTapped>(_onSendTapped);
  }

  void _onSendTapped(SendTapped event, Emitter<ResetPasswordState> emit) async {
    emit(ResetPasswordProcessing());
    try {
      await _resetPasswordRepository.resetPassword(event.email);
      emit(ResetPasswordFinished());
    } catch (e) {
      emit(ResetPasswordFailed());
    }
  }
}
