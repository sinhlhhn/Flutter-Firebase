part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String userName;
  final String password;
  final bool isLogin;
  final FormSubmissionStatus formSubmissionStatus;

  const LoginState({
    this.userName = "",
    this.password = "",
    this.isLogin = true,
    this.formSubmissionStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? userName,
    String? password,
    bool? isLogin,
    FormSubmissionStatus? formSubmissionStatus,
  }) {
    return LoginState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isLogin: isLogin ?? this.isLogin,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
    );
  }

  @override
  List<Object> get props => [userName, password, formSubmissionStatus, isLogin];
}
