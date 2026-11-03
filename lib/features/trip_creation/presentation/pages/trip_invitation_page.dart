import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_note_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/hs_header.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';
import 'package:hamsafar/features/friends/presentation/bloc/friends_bloc.dart';
import 'package:hamsafar/features/trip_creation/presentation/cubit/trip_draft_cubit.dart';
import 'package:hamsafar/features/trip_creation/presentation/widgets/trip_friend_tile.dart';
import 'package:hamsafar/features/trips/domain/entities/trip_draft.dart';

class TripInvitationPage extends StatefulWidget {
  const TripInvitationPage({super.key});

  @override
  State<TripInvitationPage> createState() => _TripInvitationPageState();
}

class _TripInvitationPageState extends State<TripInvitationPage> {
  String _query = '';

  @override
  void initState() {
    super.initState();
    context.read<FriendsBloc>().add(GetFriendsEvent());
  }

  List<FriendEntity> _filter(List<FriendEntity> friends) {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return friends;
    return friends.where((friend) {
      final name = '${friend.firstName} ${friend.lastName}'.toLowerCase();
      return name.contains(query) || friend.userName.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocBuilder<TripDraftCubit, TripDraft>(
        builder: (context, draft) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) => setState(() => _query = value),
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
              HsHeader(title: 'لیست دوستان'),
              SizedBox(height: 12.h),
              BlocBuilder<FriendsBloc, FriendsState>(
                builder: (context, friendsState) {
                  if (friendsState is FriendsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (friendsState is FriendsFailure) {
                    return txt(
                      friendsState.errorMessage,
                      color: context.colorScheme.error,
                    );
                  }
                  if (friendsState is! FriendsSuccess) {
                    return const SizedBox.shrink();
                  }
                  final friends = _filter(friendsState.friends);
                  if (friends.isEmpty) {
                    return txt(
                      'دوستی برای نمایش پیدا نشد.',
                      color: context.colorScheme.onSurfaceVariant,
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: friends.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      final friend = friends[index];
                      final selected = draft.invitedUserIds.contains(friend.id);
                      final name = '${friend.firstName} ${friend.lastName}'.trim();
                      return TripFriendTile(
                        name: name.isEmpty ? friend.userName : name,
                        rate: friend.rate.toStringAsFixed(1),
                        tripCount: friend.tripCount.toString(),
                        avatarColor: AppColors.avatars[index % AppColors.avatars.length],
                        isSelected: selected,
                        onSelected: (value) => context
                            .read<TripDraftCubit>()
                            .toggleInvite(friend.id, value),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 16.h),
              const HsNote(
                note: 'دوستان انتخاب‌شده پس از ثبت سفر، دعوت‌نامهٔ عضویت دریافت می‌کنند. دعوت‌کردن اختیاری است.',
                noteMode: HsNoteType.warning,
              ),
              SizedBox(height: 24.h),
            ],
          );
        },
      ),
    );
  }
}
