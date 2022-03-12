import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/modules/authentication/repos/auth_repo.dart';
import 'package:simple_app/modules/login/bloc/login_bloc.dart';
import 'package:simple_app/modules/login/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authenticationRepository:
            RepositoryProvider.of<AuthenticationRepository>(context),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: const Scaffold(
          // resizeToAvoidBottomInset: false,
          body: LoginForm(),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
