import 'package:flutter/material.dart';
import 'package:simple_app/Screen/Home.dart';

void main() {
  showLayoutGuidelines();
  runApp(MaterialApp(
    title: "App",
    home: MyApp(),
  ));
}

void showLayoutGuidelines() {
  // debugPaintSizeEnabled = true;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  bool _isLogin = false;
  String _userName = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: double.infinity,
                height: 100,
                child: _header,
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: _createContent(context),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  final AppBar _appBar = AppBar(
    title: const Text('App bar'),
  );

  final Container _header = Container(
    color: Colors.red,
    alignment: AlignmentDirectional.center,
    child: const Text(
      'MoneyLover 4',
      style: TextStyle(color: Colors.white),
    ),
  );

  Column _createContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(48, 0, 48, 16),
          child: _createTextField(TextFieldType.userName, context),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
          child: _createTextField(TextFieldType.password, context),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 48, 0),
          child: _createForgetPasswordButton(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 48, right: 48),
          child: _createLoginButton(context),
        ),
      ],
    );
  }

  TextField _createTextField(TextFieldType type, BuildContext context) {
    return TextField(
      focusNode: type == TextFieldType.userName ? nodeOne : nodeTwo,
      decoration: InputDecoration(
        prefixIcon: Icon(
          type == TextFieldType.userName ? Icons.people : Icons.security,
        ),
        labelText: TextFieldType.userName == type ? 'User name' : 'Password',
        // labelStyle: const TextStyle(color: Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        contentPadding: const EdgeInsets.only(left: 16),
      ),
      style: const TextStyle(color: Colors.blue),
      onSubmitted: (value) {
        if (type == TextFieldType.userName) {
          if (value.isNotEmpty) {
            _isLogin = true;
          } else {
            _isLogin = false;
          }
          FocusScope.of(context).requestFocus(nodeTwo);
        }
        if (type == TextFieldType.password && _isLogin && value.isNotEmpty) {
          onPress(context);
        }
      },
      obscureText: type == TextFieldType.password ? true : false,
      onChanged: (value) {
        if (type == TextFieldType.userName) {
          _userName = value;
        } else {
          _password = value;
        }
      },
    );
  }

  ElevatedButton _createLoginButton(BuildContext context) {
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
      child: const Text('Login'),
      onPressed: () {
        onPress(context);
      },
    );
  }

  TextButton _createForgetPasswordButton() {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 14),
      ),
      onPressed: () {},
      child: const Text(
        'Forgot password',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Container _shadowButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 10), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        child: const Text('some'),
        onPressed: () => onPress(context),
      ),
    );
  }

// CupertinoAlertDialog(
//           title: const Text('Warning'),
//           content: const Text('user name or password is empty'),
//           actions: [
//             CupertinoDialogAction(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         ),

  void onPress(BuildContext context) {
    if (_userName.isEmpty && _password.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Warning'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Approve'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
      return;
    }
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        // do something
        return const HomeScreen();
      },
    ), (route) => false);
  }
}

enum TextFieldType { userName, password }

class LoginButton extends StatefulWidget {
  final VoidCallback onPress;

  const LoginButton({Key? key, required this.onPress}) : super(key: key);
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
      child: const Text('Login'),
      onPressed: () => widget.onPress,
    );
  }
}
