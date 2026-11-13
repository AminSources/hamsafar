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
import 'package:hamsafar/features/profile/presentation/bloc/profile_avatar_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hamsafar/core/localization/app_translations.dart';

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
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _bioFocusNode = FocusNode();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _userNameController;
  late final TextEditingController _bioController;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController(text: widget.profile.userName);
    _firstNameController = TextEditingController(
      text: widget.profile.firstName,
    );
    _lastNameController = TextEditingController(text: widget.profile.lastName);
    _bioController = TextEditingController(text: widget.profile.bio);
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _userNameFocusNode.dispose();
    _bioFocusNode.dispose();
    super.dispose();
  }

  String? _requiredFieldValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return AppTranslations.translate(context, '$fieldName الزامی است');
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    _submitted = true;

    final currentProfile = widget.profile;
    final selectedAvatar = context.read<ProfileAvatarBloc>().state;

    context.read<ProfileBloc>().add(
      EditProfileEvent(
        EditProfileParams(
          userName: _userNameController.text.trim(),
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          bio: _bioController.text.trim(),
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
        }
        if (state is ProfileUpdateFailed) {
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
                      tooltip: AppTranslations.translate(context, 'بستن'),
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
                      BlocBuilder<ProfileAvatarBloc, IconData>(
                        builder: (context, selectedAvatar) {
                          return HsAvatar(
                            size: 76.w,
                            type: HsAvatarType.profile,
                            color: getAvatarColor(
                              '${widget.profile.firstName} ${widget.profile.lastName}',
                            ),
                            label: Icon(selectedAvatar, size: 34.sp),
                          );
                        },
                      ),
                      SizedBox(height: 8.h),
                      txt('انتخاب آواتار', style: context.textTheme.titleSmall),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),

                BlocBuilder<ProfileAvatarBloc, IconData>(
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
                              : () => context.read<ProfileAvatarBloc>().add(
                                  ProfileAvatarChanged(avatarIcon),
                                ),
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
                  controller: _userNameController,
                  focusNode: _userNameFocusNode,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: AppTranslations.translate(context, 'نام کاربری'),
                    prefixIcon: Icon(LucideIcons.atSign),
                  ),
                  validator: (value) {
                    final requiredError = _requiredFieldValidator(
                      value,
                      'نام کاربری',
                    );
                    if (requiredError != null) return requiredError;

                    if (value!.trim().contains(RegExp(r'\s'))) {
                      return AppTranslations.translate(
                        context,
                        'نام کاربری نباید فاصله داشته باشد',
                      );
                    }
                    return null;
                  },
                ),
                SizedBox(height: 14.h),

                //* first name
                TextFormField(
                  controller: _firstNameController,
                  focusNode: _firstNameFocusNode,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: AppTranslations.translate(context, 'نام'),
                    prefixIcon: Icon(LucideIcons.userRound),
                  ),
                  validator: (value) => _requiredFieldValidator(value, 'نام'),
                ),
                SizedBox(height: 14.h),

                //* last name
                TextFormField(
                  controller: _lastNameController,
                  focusNode: _lastNameFocusNode,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: AppTranslations.translate(
                      context,
                      'نام خانوادگی',
                    ),
                    prefixIcon: Icon(LucideIcons.userRound),
                  ),
                  validator: (value) =>
                      _requiredFieldValidator(value, 'نام خانوادگی'),
                  onFieldSubmitted: (_) {
                    if (!isSaving) _submit();
                  },
                ),
                SizedBox(height: 14.h),

                TextFormField(
                  controller: _bioController,
                  focusNode: _bioFocusNode,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: AppTranslations.translate(
                      context,
                      'چند خط درباره خودت و سبک سفر کردنت بنویس...',
                    ),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value!.length > 50) {
                      return AppTranslations.translate(
                        context,
                        "کارکتر های بیش از حد مجاز",
                      );
                    }
                    return null;
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
