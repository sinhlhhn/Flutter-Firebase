import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _imagePicker = ImagePicker();

  ProfileBloc() : super(const ProfileState()) {
    on<ChangeAvatar>(_onChangeAvatar);
  }

  void _onChangeAvatar(ChangeAvatar event, Emitter<ProfileState> emit) async {
    try {
      final file = await _imagePicker.pickImage(
        source: event.source,
        imageQuality: 1,
      );
      if (file == null) {
        return;
      }
      emit(ProfileState.withImagePath(file.path));
    } catch (_) {
      emit(const ProfileState.withError("Permission is deny"));
    }
  }
}
