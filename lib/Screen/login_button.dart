import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final VoidCallback onPress;
  final bool isLogin;

  const LoginButton({Key? key, required this.onPress, required this.isLogin})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _LoginButtonState();
  }
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // button radius
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.green,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 5,
        shadowColor: Colors.red,
        primary: Colors.green, // background color
        onPrimary: Colors.white, // text color
        // thêm minimumSize để kích hoạt padding bên ngoài
        minimumSize: const Size.fromHeight(48),
      ),
      child: widget.isLogin ? const Text('Login') : const Text('Register'),
      onPressed: () => {widget.onPress()},
    );
  }
}
