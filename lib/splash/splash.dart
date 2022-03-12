import 'package:flutter/material.dart';
import 'package:simple_app/commom/widgets/stateless/lhs_indicator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LHSIndicator(),
    );
  }
}
