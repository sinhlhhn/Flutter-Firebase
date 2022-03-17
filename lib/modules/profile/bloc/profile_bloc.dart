import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_app/network/api_service/app_exception.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _imagePicker = ImagePicker();

  ProfileBloc() : super(const ProfileState()) {
    on<ChangeAvatar>(_onChangeAvatar);
    on<GetCurrentAvatar>(_onGetCurrentAvatar);
  }

  void _onChangeAvatar(ChangeAvatar event, Emitter<ProfileState> emit) async {
    try {
      final file = await _getImage(event.source);
      if (file == null) {
        return;
      }
      final currentUser = _getCurrentUser();
      final email = currentUser.email ?? "";
      await _pushImage(email: email, imagePath: file.path);
      final imageUrl = await _getImageUrl(email);
      emit(ProfileState.withImageUrl(imageUrl));
    } catch (e) {
      emit(ProfileState.withError(e.toString()));
    }
  }

  void _onGetCurrentAvatar(
      GetCurrentAvatar event, Emitter<ProfileState> emit) async {
    final currentUser = _getCurrentUser();
    final email = currentUser.email ?? "";
    final imageUrl = await _getImageUrl(email);
    emit(ProfileState.withImageUrl(imageUrl));
  }

  Future<XFile?> _getImage(ImageSource source) async {
    try {
      final file = await _imagePicker.pickImage(
        source: source,
        imageQuality: 1,
      );
      return file;
    } catch (_) {
      throw InvalidInputException("File not found");
    }
  }

  Future<void> _pushImage(
      {required String email, required String imagePath}) async {
    final file = File(imagePath);
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child(email)
          .child("profile")
          .child("avatar");
      await ref.putFile(file);
    } catch (_) {
      throw BadRequestException("Push image failed");
    }
  }

  Future<String> _getImageUrl(String email) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child(email)
          .child("profile")
          .child("avatar");
      final imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (_) {
      throw FetchDataException("Get avatar image failed");
    }
  }

  User _getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw "User not found";
    }
    return user;
  }
}
