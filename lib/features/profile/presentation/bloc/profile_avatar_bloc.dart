import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

sealed class ProfileAvatarEvent extends Equatable {
  const ProfileAvatarEvent();

  @override
  List<Object?> get props => [];
}

final class ProfileAvatarChanged extends ProfileAvatarEvent {
  final IconData icon;

  const ProfileAvatarChanged(this.icon);

  @override
  List<Object?> get props => [icon];
}

class ProfileAvatarBloc extends Bloc<ProfileAvatarEvent, IconData> {
  ProfileAvatarBloc() : super(LucideIcons.tent) {
    on<ProfileAvatarChanged>((event, emit) {
      if (event.icon != state) emit(event.icon);
    });
  }
}
