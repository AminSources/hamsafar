import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_note_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/theme/app_colors.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/hs_header.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/core/params/no_params.dart';
import 'package:hamsafar/core/resources/data_state.dart';
import 'package:hamsafar/features/friends/domain/entities/friend_entity.dart';
import 'package:hamsafar/features/friends/domain/usecases/get_friends_usecase.dart';
import 'package:hamsafar/features/trip_creation/presentation/cubit/trip_draft_cubit.dart';
import 'package:hamsafar/features/trip_creation/presentation/widgets/trip_friend_tile.dart';
import 'package:hamsafar/features/trip_creation/domain/entities/trip_draft.dart';
import 'package:hamsafar/core/localization/app_translations.dart';

class TripInvitationPage extends StatefulWidget {
  final GetFriendsUsecase getFriendsUsecase;

  const TripInvitationPage({
    super.key,
    required this.getFriendsUsecase,
  });

  @override
  State<TripInvitationPage> createState() => _TripInvitationPageState();
}

class _TripInvitationPageState extends State<TripInvitationPage> {
  String _query = '';
  List<FriendEntity> _friends = const [];
  bool _loading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final result = await widget.getFriendsUsecase(const NoParams());
      if (!mounted) return;

      if (result is DataSuccess<List<FriendEntity>>) {
        setState(() {
          _friends = result.data ?? const [];
          _loading = false;
        });
      } else {
        setState(() {
          _errorMessage = result.message ?? 'دریافت فهرست دوستان ناموفق بود.';
          _loading = false;
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'دریافت فهرست دوستان ناموفق بود.';
        _loading = false;
      });
    }
  }

  List<FriendEntity> _filter(List<FriendEntity> friends) {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return friends;
    return friends.where((friend) {
      final name = '\${friend.firstName} \${friend.lastName}'.toLowerCase();
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
                  hintText: AppTranslations.translate(context, 'جستجو در دوستان...'),
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
              if (_loading)
                const Center(child: CircularProgressIndicator())
              else if (_errorMessage != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    txt(_errorMessage!, color: context.colorScheme.error),
                    TextButton(
                      onPressed: _loadFriends,
                      child: const txt('تلاش دوباره'),
                    ),
                  ],
                )
              else
                Builder(
                  builder: (context) {
                    final friends = _filter(_friends);
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
                      separatorBuilder: (_, _) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        final friend = friends[index];
                        final selected = draft.invitedUserIds.contains(friend.id);
                        final name = '\${friend.firstName} \${friend.lastName}'.trim();
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
