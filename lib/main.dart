import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_app/Screen/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_app/commom/widgets/stateless/lhs_button.dart';
import 'package:simple_app/commom/widgets/stateless/lhs_text_form_field.dart';
import 'Utils/debouncer.dart';

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

  // Form
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLogin = true;
  LoadingState _loginState = LoadingState.finished;

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
                  _header(),
                  _createContent(),
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

  Widget _createIndicator(BuildContext context) {
    switch (_loginState) {
      case LoadingState.loading:
        return Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
            child: const CupertinoActivityIndicator(radius: 20),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _createContent() {
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
                  _passwordTextFormField(),
                  const SizedBox(height: 8),
                  _createForgetPasswordButton(),
                  const SizedBox(height: 8),
                  _loginButton(),
                  const SizedBox(height: 8),
                  _register(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  LHSTextFormField _userTextFormField() {
    return LHSTextFormField(
      controller: _userNameController,
      focusNode: nodeOne,
      prefix: const Icon(Icons.people),
      label: "User Name",
      obsecure: false,
      onEditingCompleted: () {
        FocusScope.of(context).requestFocus(nodeTwo);
      },
      validator: (text) {
        return null;
      },
    );
  }

  LHSTextFormField _passwordTextFormField() {
    return LHSTextFormField(
      controller: _passwordController,
      focusNode: nodeTwo,
      prefix: const Icon(Icons.security),
      label: "Password",
      obsecure: false,
      // onChanged: (text) => _password = text,
      onEditingCompleted: () {
        onPress(context);
      },
      validator: (text) {
        return null;
      },
    );
  }

  LHSButton _loginButton() {
    return LHSButton(
        onPress: () {
          onPress(context);
        },
        isLogin: _isLogin);
  }

  Row _register() {
    return Row(
      children: [
        GestureDetector(
          child: RichText(
            text: TextSpan(
              text:
                  _isLogin ? "Don't have account, " : "Already have account, ",
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
    if (!_formKey.currentState!.validate()) {
      Utils.showError(context, 'Warning', 'user name or password is invalid');
      return;
    }
    setState(() {
      _loginState = LoadingState.loading;
    });
    final userName = _userNameController.text;
    final password = _passwordController.text;
    try {
      if (!_isLogin) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: userName, password: password);
      }
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userName, password: password);
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

enum LoadingState { loading, finished }
