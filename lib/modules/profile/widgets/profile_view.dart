import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_app/commom/widgets/stateless/lhs_indicator.dart';
import 'package:simple_app/modules/authentication/bloc/bloc/authentication_bloc.dart';
import 'package:simple_app/modules/profile/bloc/profile_bloc.dart';
import 'package:simple_app/utils/dart.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(const GetCurrentAvatar());
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              addVerticalSpace(50),
              _avatar(),
              _changeAvatarButton(context),
              _email(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      actions: [
        IconButton(
          onPressed: () {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested());
          },
          icon: const Icon(Icons.logout),
        )
      ],
    );
  }

  Widget _avatar() {
    return BlocConsumer<ProfileBloc, ProfileState>(
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
        final imagePath = state.imageUrl;
        if (imagePath.isEmpty) {
          return CircleAvatar(
            radius: 75,
            backgroundColor: Colors.grey[200],
          );
        }
        return SizedBox(
          width: 150,
          height: 150,
          child: CachedNetworkImage(
            imageUrl: imagePath,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const LHSIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
      },
    );
  }

  Widget _changeAvatarButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        child: const Text('Change Avatar'),
        onPressed: () => showActionSheet(context),
      ),
    );
  }

  Widget _email(BuildContext context) {
    final bloc = context.read<AuthenticationBloc>();
    final user = bloc.state.user;
    final email = user.email;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      tileColor: isDark ? null : Colors.white,
      title: Text(email ?? ""),
      leading: const Icon(Icons.email),
    );
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
