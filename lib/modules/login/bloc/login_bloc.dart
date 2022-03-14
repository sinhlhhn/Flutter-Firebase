import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_app/modules/authentication/repos/auth_repo.dart';
import 'package:simple_app/modules/login/bloc/form_submission_status.dart';
import 'package:simple_app/network/firebase/authentication_exception.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUserNameChanged>(_onUserNameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<TypeChanged>(_onTypeChanged);
  }

  void _onUserNameChanged(
      LoginUserNameChanged event, Emitter<LoginState> emit) {
    final userName = event.userName;
    emit(state.copyWith(userName: userName));
  }

  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = event.password;
    emit(state.copyWith(password: password));
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    final userName = state.userName;
    final password = state.password;

    emit(state.copyWith(formSubmissionStatus: const FormSubmitting()));
    if (userName.isNotEmpty &&
        password.isNotEmpty &&
        userName.length > 2 &&
        password.length > 5) {
      try {
        await _authenticationRepository.login(userName, password);
        emit(state.copyWith(formSubmissionStatus: const SubmissionSuccess()));
      } catch (e) {
        final error = AuthenticationException.generateExceptionMessage(e);
        emit(state.copyWith(
            formSubmissionStatus: SubmissionFailed(error: error)));
      }
      return;
    }

    emit(state.copyWith(
        formSubmissionStatus: const SubmissionFailed(
            error: "User name or password is too short")));
  }

  void _onRegisterSubmitted(
      RegisterSubmitted event, Emitter<LoginState> emit) async {
    final userName = state.userName;
    final password = state.password;

    emit(state.copyWith(formSubmissionStatus: const FormSubmitting()));
    if (userName.isNotEmpty &&
        password.isNotEmpty &&
        userName.length > 2 &&
        password.length > 5) {
      try {
        await _authenticationRepository.register(userName, password);
        emit(state.copyWith(formSubmissionStatus: const SubmissionSuccess()));
      } catch (e) {
        final error = AuthenticationException.generateExceptionMessage(e);
        emit(state.copyWith(
            formSubmissionStatus: SubmissionFailed(error: error)));
      }
      return;
    }

    emit(state.copyWith(
        formSubmissionStatus: const SubmissionFailed(
            error: "User name or password is too short")));
  }

  void _onTypeChanged(TypeChanged event, Emitter<LoginState> emit) async {
    final isLogin = state.isLogin;
    emit(state.copyWith(isLogin: !isLogin));
  }
}
