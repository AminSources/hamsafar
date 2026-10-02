import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_button_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_error.dart';
import 'package:hamsafar/core/widgets/hs_header.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hamsafar/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:hamsafar/features/profile/presentation/widgets/profile_card.dart';
import 'package:hamsafar/features/profile/presentation/widgets/profile_menu_tile.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* appbar
              HsAppBar(title: 'پروفایل من'),
              SizedBox(height: 24.h),

              //* profile section
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: ((context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ProfileFailed) {
                    return HsError(
                      illustrationPath: "lib/assets/images/error.svg",
                      title: state.message,
                    );
                  }
                  if (state is ProfileSuccess) {
                    //* cast
                    final profileEntity = state.profile;

                    return Column(
                      children: [
                        //* profile header card
                        ProfileCard(profileInfo: profileEntity!),
                        SizedBox(height: 16.h),

                        //* available days item
                        ProfileMenuTile(
                          title: 'روزهای آزاد من',
                          subtitle: profileEntity.freeDays.join(', '),
                          icon: LucideIcons.calendarCheck,
                          onTap: () {
                            context.push('/available-days');
                          },
                        ),
                        SizedBox(height: 12.h),

                        ProfileMenuTile(
                          title: 'وسایل من',
                          subtitle: '${profileEntity.toolCount} مورد',
                          icon: LucideIcons.toolCase,
                          onTap: () {
                            context.push('/my-items');
                          },
                        ),
                        SizedBox(height: 24.h),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                }),
              ),

              //* settings section title
              HsHeader(title: "تنظیمات"),
              SizedBox(height: 12.h),

              //* app settings item
              ProfileMenuTile(
                title: "تنظیمات برنامه",
                icon: LucideIcons.settings,
                onTap: () {
                  context.push('/settings');
                },
              ),
              SizedBox(height: 12.h),

              //* account settings item
              ProfileMenuTile(
                title: "تنظیمات حساب کاربری",
                icon: LucideIcons.userRoundCog,
                onTap: () {},
              ),
              SizedBox(height: 16.h),

              //* logout button
              HsButton(
                hsButtonType: HsButtonType.outline,
                borderColor: context.colorScheme.error,
                onTap: () {
                  //? sign out
                  context.read<AuthBloc>().add(LogoutEvent());
                },
                child: Row(
                  mainAxisAlignment: .center,
                  spacing: 10.w,
                  children: [
                    //* icon
                    Icon(
                      LucideIcons.logOut,
                      size: 20.sp,
                      color: context.colorScheme.error,
                    ),

                    //* txt
                    txt(
                      "خروج از حساب کاربری",
                      color: context.colorScheme.error,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 65.h),
            ],
          ),
        ),
      ),
    );
  }
}
