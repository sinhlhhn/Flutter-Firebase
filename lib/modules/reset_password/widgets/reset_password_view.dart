import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/commom/widgets/stateful/lhs_button.dart';
import 'package:simple_app/commom/widgets/stateless/lhs_indicator.dart';
import 'package:simple_app/commom/widgets/stateless/lhs_text_form_field.dart';
import 'package:simple_app/modules/reset_password/bloc/reset_password_bloc.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordFinished) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var isShow = false;
        if (state is ResetPasswordProcessing) {
          isShow = true;
        }
        return Padding(
          padding: const EdgeInsets.all(32),
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    LHSTextFormField(
                        controller: _emailController, label: "Email"),
                    const SizedBox(
                      height: 16,
                    ),
                    LHSButton(
                      onPress: () {
                        print(_emailController.text);
                        context
                            .read<ResetPasswordBloc>()
                            .add(SendTapped(_emailController.text));
                      },
                      text: const Text("Send"),
                    )
                  ],
                ),
                _createIndicator(isShow),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _createIndicator(bool isShow) {
    return isShow == true ? const LHSIndicator() : const SizedBox();
  }
}
