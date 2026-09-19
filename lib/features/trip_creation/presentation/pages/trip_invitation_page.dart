import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_note_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/hs_header.dart';
import 'package:hamsafar/features/trip_creation/presentation/widgets/trip_friend_tile.dart';

class TripInvitationPage extends StatelessWidget {
  const TripInvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* search field
          TextField(
            decoration: InputDecoration(
              hintText: 'جستجو در دوستان...',
              prefixIcon: Icon(
                Icons.search,
                size: 20.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(height: 20.h),

          //* friends header
          HsHeader(title: "لیست دوستان"),
          SizedBox(height: 12.h),

          //* friends list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: ((context, index) {
              final List<bool> selectedList = [true, true, true, false, false];

              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0 : 10.h),
                child: TripFriendTile(
                  name: [
                    "مهدی رضایی",
                    "سارا محمدی",
                    "نگار احمدی",
                    "علی کریمی",
                    "محمدامین فرشباف",
                  ][index],
                  rate: ["۴.۸", "۴.۳", "۳.۹", "۴.۸", "۴.۹"][index],
                  tripCount: ["۴", "۳", "۴", "۸", "۹"][index],
                  isSelected: selectedList[index],
                  avatarColor: AppColors.avatars[index],
                  onSelected: (value) {},
                ),
              );
            }),
          ),
          SizedBox(height: 16.h),

          //* info note
          HsNote(
            note: 'دعوت‌شدگان می‌توانند عضویت را بپذیرند یا رد کنند',
            noteMode: HsNoteType.warning,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
