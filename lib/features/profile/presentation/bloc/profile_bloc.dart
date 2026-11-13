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
    ProfileEntity? currentProfile;

    if (state is ProfileSuccess) {
      currentProfile = (state as ProfileSuccess).profile;
    } else if (state is ProfileUpdating) {
      currentProfile = (state as ProfileUpdating).profile;
    } else if (state is ProfileUpdateFailed) {
      currentProfile = (state as ProfileUpdateFailed).profile;
    }

    if (currentProfile != null) {
      emit(ProfileUpdating(currentProfile));
    } else {
      emit(ProfileLoading());
    }

    final params = event.editProfileParams;
    final result = await editProfileUsecase(params);

    if (result is! DataSuccess) {
      final message = result.message ?? 'ویرایش پروفایل ناموفق بود';

      if (currentProfile != null) {
        emit(ProfileUpdateFailed(currentProfile, message));
      } else {
        emit(ProfileFailed(message));
      }
      return;
    }

    // During onboarding there is no profile in memory yet, so load the
    // newly created profile from Supabase. Existing profiles can be updated
    // locally while preserving statistics and availability data.
    if (currentProfile == null) {
      final profileResult = await getProfileUsecase(NoParams());

      if (profileResult is DataSuccess<ProfileEntity> &&
          profileResult.data != null) {
        emit(ProfileSuccess(profileResult.data!));
      } else {
        emit(
          ProfileFailed(
            profileResult.message ??
                'پروفایل ذخیره شد اما دریافت آن ناموفق بود',
          ),
        );
      }
      return;
    }

    emit(
      ProfileSuccess(
        currentProfile.copyWith(
          userName: params.userName,
          firstName: params.firstName,
          lastName: params.lastName,
          avatarIcon: params.avatarIcon,
          bio: params.bio,
          rate: params.rate,
          tripCount: params.tripCount,
        ),
      ),
    );
  }

  Future<void> onGetProfile(GetProfileEvent event, emit) async {
    emit(ProfileLoading());

    final result = await getProfileUsecase(NoParams());

    if (result is DataSuccess<ProfileEntity> && result.data != null) {
      emit(ProfileSuccess(result.data!));
    } else {
      emit(ProfileFailed(result.message ?? 'دریافت پروفایل ناموفق بود'));
    }
  }
}
