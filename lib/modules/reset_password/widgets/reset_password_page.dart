import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/modules/reset_password/bloc/reset_password_bloc.dart';
import 'package:simple_app/modules/reset_password/repos/reset_password_repository.dart';
import 'package:simple_app/modules/reset_password/widgets/reset_password_view.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ForgotPasswordPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ResetPasswordBloc(resetPasswordRepository: ResetPasswordRepository()),
      child: Scaffold(body: ResetPasswordView()),
    );
  }
}
