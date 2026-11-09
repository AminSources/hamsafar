import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/constants/icons.dart';
import 'package:hamsafar/core/enums/hs_avatar_type.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/utils/avatar_color_util.dart';
import 'package:hamsafar/core/utils/avatar_converter.dart';
import 'package:hamsafar/core/widgets/hs_avatar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/profile/domain/entities/profile_entity.dart';
import 'package:hamsafar/features/profile/domain/params/edit_profile_params.dart';
import 'package:hamsafar/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:hamsafar/features/profile/presentation/cubit/profile_avatar_cubit.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class EditProfileBottomSheet extends StatefulWidget {
  final ProfileEntity profile;
  final VoidCallback onSaved;

  const EditProfileBottomSheet({
    super.key,
    required this.profile,
    required this.onSaved,
  });

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(
      text: widget.profile.userName,
    );
    _firstNameController = TextEditingController(
      text: widget.profile.firstName,
    );
    _lastNameController = TextEditingController(
      text: widget.profile.lastName,
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  String? _requiredFieldValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName الزامی است';
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    _submitted = true;

    final currentProfile = widget.profile;
    final selectedAvatar = context.read<ProfileAvatarCubit>().state;

    context.read<ProfileBloc>().add(
      EditProfileEvent(
        EditProfileParams(
          userName: _usernameController.text.trim(),
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          bio: currentProfile.bio,
          rate: currentProfile.rate,
          tripCount: currentProfile.tripCount,
          avatarIcon: AvatarConverter.iconDataToString(
            iconData: selectedAvatar,
          ),
          onboardingCompleted: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (!_submitted) return;

        if (state is ProfileSuccess) {
          _submitted = false;
          widget.onSaved();
        } else if (state is ProfileUpdateFailed) {
          _submitted = false;
          context.showHsSnackBar(
            text: state.message,
            hsSnackBarType: HsSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        final isSaving = state is ProfileUpdating;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            20.w,
            18.h,
            20.w,
            MediaQuery.viewInsetsOf(context).bottom + 24.h,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 42.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: context.colorScheme.outline,
                      borderRadius: BorderRadius.circular(99.r),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),

                //* title
                Row(
                  children: [
                    Expanded(
                      child: txt(
                        'ویرایش پروفایل',
                        style: context.textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      tooltip: 'بستن',
                      onPressed: isSaving
                          ? null
                          : () => Navigator.of(context).pop(),
                      icon: const Icon(LucideIcons.x),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                //* avatar preview and picker
                Center(
                  child: Column(
                    children: [
                      BlocBuilder<ProfileAvatarCubit, IconData>(
                        builder: (context, selectedAvatar) {
                          return HsAvatar(
                            size: 76.w,
                            type: HsAvatarType.profile,
                            color: getAvatarColor(
                              widget.profile.firstName +
                                  widget.profile.lastName,
                            ),
                            label: Icon(selectedAvatar, size: 34.sp),
                          );
                        },
                      ),
                      SizedBox(height: 8.h),
                      txt(
                        'انتخاب آواتار',
                        style: context.textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),

                BlocBuilder<ProfileAvatarCubit, IconData>(
                  builder: (context, selectedAvatar) {
                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: avatarIcons.map((avatarIcon) {
                        final isSelected = selectedAvatar == avatarIcon;

                        return HsContainer(
                          width: 48.w,
                          height: 48.w,
                          radius: 12.r,
                          color: isSelected
                              ? context.colorScheme.primary
                              : context.colorScheme.surfaceContainerHigh,
                          borderColor: isSelected
                              ? context.colorScheme.primary
                              : context.colorScheme.outline,
                          onTap: isSaving
                              ? null
                              : () => context
                                    .read<ProfileAvatarCubit>()
                                    .changeAvatar(avatarIcon),
                          child: Icon(
                            avatarIcon,
                            color: isSelected
                                ? context.colorScheme.onPrimary
                                : context.colorScheme.onSurface,
                            size: 22.sp,
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                SizedBox(height: 22.h),

                //* username
                TextFormField(
                  controller: _usernameController,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'نام کاربری',
                    prefixIcon: Icon(LucideIcons.atSign),
                  ),
                  validator: (value) {
                    final requiredError = _requiredFieldValidator(
                      value,
                      'نام کاربری',
                    );
                    if (requiredError != null) return requiredError;

                    if (value!.trim().contains(RegExp(r'\s'))) {
                      return 'نام کاربری نباید فاصله داشته باشد';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 14.h),

                //* first name
                TextFormField(
                  controller: _firstNameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'نام',
                    prefixIcon: Icon(LucideIcons.userRound),
                  ),
                  validator: (value) =>
                      _requiredFieldValidator(value, 'نام'),
                ),
                SizedBox(height: 14.h),

                //* last name
                TextFormField(
                  controller: _lastNameController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: 'نام خانوادگی',
                    prefixIcon: Icon(LucideIcons.userRound),
                  ),
                  validator: (value) =>
                      _requiredFieldValidator(value, 'نام خانوادگی'),
                  onFieldSubmitted: (_) {
                    if (!isSaving) _submit();
                  },
                ),
                SizedBox(height: 22.h),

                //* save button
                HsButton(
                  onTap: isSaving ? null : _submit,
                  child: isSaving
                      ? SizedBox(
                          width: 22.w,
                          height: 22.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: context.colorScheme.onPrimary,
                          ),
                        )
                      : txt('ذخیره تغییرات'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
