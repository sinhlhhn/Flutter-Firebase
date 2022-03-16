import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/modules/profile/bloc/profile_bloc.dart';

import 'profile_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: const ProfileView(),
    );
  }
}
