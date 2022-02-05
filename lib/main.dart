import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_app/Screen/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_app/Utils/debouncer.dart';

import 'Screen/login_button.dart';

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

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  FocusNode nodeOne = FocusNode();

  FocusNode nodeTwo = FocusNode();

  bool _isLogin = true;
  LoadingState _loginState = LoadingState.finished;

  String _userName = "";

  String _password = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SafeArea(
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
            _createIndicator(context),
          ],
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

  Widget _createIndicator(BuildContext context) {
    switch (_loginState) {
      case LoadingState.loading:
        return Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
            child: CupertinoActivityIndicator(radius: 20),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _createContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _createTextField(TextFieldType.userName, context),
          const SizedBox(height: 16),
          _createTextField(TextFieldType.password, context),
          const SizedBox(height: 8),
          _createForgetPasswordButton(),
          const SizedBox(height: 8),
          LoginButton(
              onPress: () {
                print("Tap");
                onPress(context);
              },
              isLogin: _isLogin),
          const SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                child: RichText(
                  text: TextSpan(
                    text: _isLogin
                        ? "Don't have account, "
                        : "Already have account, ",
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    children: [
                      TextSpan(
                        text: _isLogin ? 'Register' : 'Login',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
              ),
            ],
          ),
        ],
      ),
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
          FocusScope.of(context).requestFocus(nodeTwo);
        }
        onPress(context);
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

  GestureDetector _createForgetPasswordButton() {
    return GestureDetector(
      child: Text(
        _isLogin ? "Forgot password" : " ",
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
      ),
      onTap: () {},
    );
  }

  void onPress(BuildContext context) async {
    if (_userName.isEmpty && _password.isEmpty) {
      Utils.showError(context, 'Warning', 'user name or password is empty');
      return;
    }
    setState(() {
      _loginState = LoadingState.loading;
    });
    try {
      if (!_isLogin) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _userName, password: _password);
      }
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _userName, password: _password);
    } on PlatformException catch (e) {
      Utils.showError(context, e.code, e.message.toString());
      setState(() {
        _loginState = LoadingState.finished;
      });
      return;
    } catch (e) {
      Utils.showError(context, "Error", e.toString());
      setState(() {
        _loginState = LoadingState.finished;
      });
      return;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        // do something
        return const HomeScreen();
      },
    ), result: (route) => false);
  }
}

enum TextFieldType { userName, password }
enum LoadingState { loading, finished }
