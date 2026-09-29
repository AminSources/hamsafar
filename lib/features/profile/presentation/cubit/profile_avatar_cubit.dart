import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProfileAvatarCubit extends Cubit<IconData> {
  ProfileAvatarCubit() : super(LucideIcons.tent);

  void changeAvatar(IconData icon) {
    if (state != icon) {
      emit(icon);
    }
  }
}
