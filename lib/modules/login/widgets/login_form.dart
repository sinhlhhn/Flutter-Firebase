import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/commom/widgets/stateful/lhs_button.dart';
import 'package:simple_app/commom/widgets/stateless/lhs_indicator.dart';
import 'package:simple_app/commom/widgets/stateless/lhs_text_form_field.dart';
import 'package:simple_app/modules/login/bloc/form_submission_status.dart';
import 'package:simple_app/modules/login/bloc/login_bloc.dart';
import 'package:simple_app/modules/reset_password/widgets/reset_password_page.dart';
import 'package:simple_app/utils/debouncer.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginForm> {
  // This widget is the root of your application.
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();

  // Form
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        return previous.isLogin != current.isLogin ||
            previous.formSubmissionStatus != current.formSubmissionStatus;
      },
      listenWhen: (previous, current) {
        return previous.formSubmissionStatus != current.formSubmissionStatus;
      },
      listener: (context, state) {
        if (state.formSubmissionStatus is SubmissionFailed) {
          final error =
              (state.formSubmissionStatus as SubmissionFailed).error ?? "";
          Utils.showError(context, "Failed", error);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(error)),
            );
        }
      },
      builder: (context, state) {
        var isShow = false;
        if (state.formSubmissionStatus is FormSubmitting) {
          isShow = true;
        }
        var isLogin = state.isLogin;
        return Stack(
          children: [
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _header(),
                  _createContent(isLogin),
                ],
              ),
            ),
            _createIndicator(isShow),
          ],
        );
      },
    );
  }

  Widget _header() {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Container(
        color: Colors.red,
        alignment: AlignmentDirectional.center,
        child: const Text(
          'MoneyLover 4',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _createIndicator(bool isShow) {
    return isShow == true ? const LHSIndicator() : const SizedBox();
  }

  Widget _createContent(bool isLogin) {
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _userTextFormField(),
                  const SizedBox(height: 16),
                  _passwordTextFormField(isLogin),
                  const SizedBox(height: 8),
                  _createForgetPasswordButton(isLogin),
                  const SizedBox(height: 8),
                  _loginButton(isLogin),
                  const SizedBox(height: 8),
                  _changeType(isLogin),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userTextFormField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return LHSTextFormField(
          controller: _userNameController,
          focusNode: nodeOne,
          prefix: const Icon(Icons.people),
          label: "User Name",
          obsecure: false,
          onEditingCompleted: () {
            FocusScope.of(context).requestFocus(nodeTwo);
          },
          onChanged: (userName) {
            context.read<LoginBloc>().add(LoginUserNameChanged(userName));
          },
          validator: (text) {
            return null;
          },
        );
      },
    );
  }

  LHSTextFormField _passwordTextFormField(bool isLogin) {
    return LHSTextFormField(
      controller: _passwordController,
      focusNode: nodeTwo,
      prefix: const Icon(Icons.security),
      label: "Password",
      obsecure: true,
      onEditingCompleted: () {
        onPress(isLogin);
      },
      onChanged: (password) {
        context.read<LoginBloc>().add(LoginPasswordChanged(password));
      },
      validator: (text) {
        return null;
      },
    );
  }

  LHSButton _loginButton(bool isLogin) {
    final text = isLogin ? const Text('Login') : const Text('Register');
    return LHSButton(
      onPress: () {
        onPress(isLogin);
      },
      text: text,
    );
  }

  Row _changeType(bool isLogin) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            text: isLogin ? "Don't have account, " : "Already have account, ",
            style: const TextStyle(fontSize: 14, color: Colors.black),
            children: [
              TextSpan(
                text: isLogin ? 'Register' : 'Login',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.green),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.read<LoginBloc>().add(const TypeChanged());
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  GestureDetector _createForgetPasswordButton(bool isLogin) {
    return GestureDetector(
      child: Text(
        isLogin ? "Forgot password" : " ",
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
      ),
      onTap: () {
        Navigator.push(context, ForgotPasswordPage.route());
      },
    );
  }

  void onPress(bool isLogin) {
    isLogin
        ? context.read<LoginBloc>().add(const LoginSubmitted())
        : context.read<LoginBloc>().add(const RegisterSubmitted());
  }
}
