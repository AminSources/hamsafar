import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/constants/icons.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/profile/presentation/cubit/profile_avatar_cubit.dart';

class AvatarPickerWidget extends StatelessWidget {
  const AvatarPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.h,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: BlocBuilder<ProfileAvatarCubit, IconData>(
          builder: (context, state) {
            return Column(
              spacing: 12.h,
              children: [
                //* title
                HsAppBar(title: "انتخاب آواتار", hasBack: true),

                //* Avatar list
                Wrap(
                  runSpacing: 16.h,
                  spacing: 16.w,
                  children: List.generate(
                    avatarIcons.length,
                    (index) => HsContainer(
                      width: 50.w,
                      height: 50.w,
                      color: state == avatarIcons[index]
                          ? context.colorScheme.primary
                          : context.colorScheme.surfaceContainerHigh,
                      borderColor: context.colorScheme.outline,
                      onTap: () {
                        context.read<ProfileAvatarCubit>().changeAvatar(
                          avatarIcons[index],
                        );
                      },
                      child: Center(child: Icon(avatarIcons[index])),
                    ),
                  ),
                ),
                Spacer(),

                //* select button
                HsButton(
                  onTap: () {
                    context.pop();
                  },
                  child: txt("انتخاب"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
