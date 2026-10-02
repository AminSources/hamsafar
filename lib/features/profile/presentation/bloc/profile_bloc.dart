import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/profile/domain/entities/profile_entity.dart';
import 'package:hamsafar/features/profile/domain/params/edit_profile_params.dart';
import 'package:hamsafar/features/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:hamsafar/features/profile/domain/usecases/get_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final EditProfileUsecase editProfileUsecase;
  final GetProfileUsecase getProfileUsecase;

  ProfileBloc({
    required this.editProfileUsecase,
    required this.getProfileUsecase,
  }) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<EditProfileEvent>(onEditProfile);
    on<GetProfileEvent>(onGetProfile);
  }

  Future<void> onEditProfile(EditProfileEvent event, emit) async {
    emit(ProfileLoading());
    final result = await editProfileUsecase(event.editProfileParams);

    if (result is DataSuccess) {
      emit(ProfileSuccess(null));
    } else {
      emit(ProfileFailed(result.message ?? "Edit profile failed"));
    }
  }

  Future<void> onGetProfile(GetProfileEvent event, emit) async {
    emit(ProfileLoading());

    final result = await getProfileUsecase(NoParams());

    if (result is DataSuccess<ProfileEntity>) {
      emit(ProfileSuccess(result.data));
    } else {
      emit(ProfileFailed(result.message ?? "Get profile failed"));
    }
  }
}
