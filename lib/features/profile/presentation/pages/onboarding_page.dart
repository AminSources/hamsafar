import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/utils/avatar_converter.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/profile/domain/params/edit_profile_params.dart';
import 'package:hamsafar/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:hamsafar/features/profile/presentation/cubit/profile_avatar_cubit.dart';
import 'package:hamsafar/features/profile/presentation/widgets/onboarding_header.dart';
import 'package:hamsafar/features/profile/presentation/widgets/onboarding_avatar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _bioFocusNode = FocusNode();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _userNameFocusNode.dispose();
    _bioFocusNode.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            //? unfocus text field when tap anywhere of page
            _firstNameFocusNode.unfocus();
            _lastNameFocusNode.unfocus();
            _userNameFocusNode.unfocus();
            _bioFocusNode.unfocus();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileFailed) {
                  context.showHsSnackBar(text: state.message);
                }
                if (state is ProfileSuccess) {
                  context.go("/main-wrapper");
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //* header
                      OnboardingHeader(),
                      SizedBox(height: 32.h),

                      //* profile avatar
                      OnboardingAvatar(),
                      SizedBox(height: 32.h),

                      //* frist name field
                      TextFormField(
                        controller: _firstNameController,
                        focusNode: _firstNameFocusNode,
                        decoration: const InputDecoration(
                          hintText: 'نام',
                          prefixIcon: Icon(LucideIcons.userRound),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "نام الزامی است";
                          }
                          if (value.length >= 10) {
                            return "نام طولانی است";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16.h),

                      //* last name field
                      TextFormField(
                        controller: _lastNameController,
                        focusNode: _lastNameFocusNode,
                        decoration: const InputDecoration(
                          hintText: 'نام خانوادگی',
                          prefixIcon: Icon(LucideIcons.userRound),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "نام خانوادگی الزامی است";
                          }
                          if (value.length >= 10) {
                            return "نام خانوادگی طولانی است";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16.h),

                      //* user name field
                      TextFormField(
                        controller: _userNameController,
                        focusNode: _userNameFocusNode,
                        decoration: const InputDecoration(
                          hintText: 'نام کاربری',
                          prefixIcon: Icon(LucideIcons.atSign),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "نام کاربری الزامی است";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      //* bio field
                      TextFormField(
                        controller: _bioController,
                        focusNode: _bioFocusNode,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText:
                              'چند خط درباره خودت و سبک سفر کردنت بنویس...',
                          alignLabelWithHint: true,
                        ),
                        validator: (value) {
                          if (value!.length > 50) {
                            return "کارکتر های بیش از حد مجاز";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40.h),

                      //* continue button
                      HsButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ProfileBloc>().add(
                              EditProfileEvent(
                                EditProfileParams(
                                  userName: _userNameController.text,
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  bio: _bioController.text,
                                  avatarIcon: AvatarConverter.iconDataToString(
                                    iconData: context
                                        .read<ProfileAvatarCubit>()
                                        .state,
                                  ),
                                  onboardingCompleted: true,
                                ),
                              ),
                            );
                          }
                        },
                        child: state is ProfileLoading
                            ? CircularProgressIndicator()
                            : const txt('ادامه'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
