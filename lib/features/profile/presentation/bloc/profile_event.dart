part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfileEvent extends ProfileEvent {
  final EditProfileParams editProfileParams;

  const EditProfileEvent(this.editProfileParams);

  @override
  List<Object> get props => [editProfileParams];
}
