import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_app/modules/authentication/bloc/bloc/authentication_bloc.dart';
import 'package:simple_app/modules/profile/bloc/profile_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state.error.isNotEmpty) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                }
              },
              builder: (context, state) {
                final imagePath = state.imagePath;
                return CircleAvatar(
                  radius: 50,
                  backgroundImage: _getBackgroundImage(imagePath),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Image picker'),
              onPressed: () => showActionSheet(context),
            ),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getUser(BuildContext context) {
    final userId = context.select(
      (AuthenticationBloc bloc) => bloc.state.user.id,
    );
    final bloc = context.read<AuthenticationBloc>();
    final user = bloc.state.user;
    final email = user.email;
    return Text('$userId - $email');
  }

  ImageProvider<Object>? _getBackgroundImage(String imagePath) {
    if (imagePath.isNotEmpty) {
      print(imagePath);
      return FileImage(File(imagePath));
    } else {
      return null;
    }
  }

  void showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  context
                      .read<ProfileBloc>()
                      .add(const ChangeAvatar(ImageSource.gallery));
                },
                child: const Text("Galary"),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  context
                      .read<ProfileBloc>()
                      .add(const ChangeAvatar(ImageSource.camera));
                },
                child: const Text("Camera"),
              ),
            ],
          );
        });
  }

 
}
