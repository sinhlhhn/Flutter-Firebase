part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ChangeAvatar extends ProfileEvent {
  final ImageSource source;
  const ChangeAvatar(this.source);

  @override
  List<Object> get props => [source];
}
