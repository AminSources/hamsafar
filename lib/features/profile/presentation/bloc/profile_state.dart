part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final ProfileEntity profile;

  const ProfileSuccess(this.profile);

  @override
  List<Object> get props => [profile];
}

final class ProfileUpdating extends ProfileState {
  final ProfileEntity profile;

  const ProfileUpdating(this.profile);

  @override
  List<Object> get props => [profile];
}

final class ProfileUpdateFailed extends ProfileState {
  final ProfileEntity profile;
  final String message;

  const ProfileUpdateFailed(this.profile, this.message);

  @override
  List<Object> get props => [profile, message];
}

final class ProfileFailed extends ProfileState {
  final String message;

  const ProfileFailed(this.message);

  @override
  List<Object> get props => [message];
}
