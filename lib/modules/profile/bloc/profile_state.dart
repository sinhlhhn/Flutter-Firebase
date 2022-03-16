part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final String imagePath;
  final String error;

  const ProfileState({this.imagePath = "", this.error = ""});

  const ProfileState.withImagePath(String imagePath)
      : this(imagePath: imagePath);
  const ProfileState.withError(String error) : this(error: error);

  @override
  List<Object> get props => [imagePath, error];
}
