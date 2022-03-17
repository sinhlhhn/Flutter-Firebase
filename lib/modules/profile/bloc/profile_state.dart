part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final String imageUrl;
  final String error;

  const ProfileState({this.imageUrl = "", this.error = ""});

  const ProfileState.withImageUrl(String imageUrl) : this(imageUrl: imageUrl);
  const ProfileState.withError(String error) : this(error: error);

  @override
  List<Object> get props => [imageUrl, error];
}
