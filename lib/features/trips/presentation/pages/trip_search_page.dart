import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_note_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:hamsafar/features/trips/presentation/widgets/trip_tile.dart';

class TripSearchPage extends StatefulWidget {
  const TripSearchPage({super.key});

  @override
  State<TripSearchPage> createState() => _TripSearchPageState();
}

class _TripSearchPageState extends State<TripSearchPage> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<TripsCubit>().searchTrips('');
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (mounted) context.read<TripsCubit>().searchTrips(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
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
              const HsAppBar(title: 'جستجوی سفر', hasBack: true),
              SizedBox(height: 20.h),
              TextField(
                controller: _controller,
                onChanged: _onChanged,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'نام سفر یا مقصد را وارد کنید...',
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20.sp,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  suffixIcon: IconButton(
                    tooltip: 'پاک کردن جستجو',
                    onPressed: () {
                      _controller.clear();
                      _onChanged('');
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              BlocBuilder<TripsCubit, TripsState>(
                builder: (context, state) {
                  if (state.isSearching) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state.errorMessage != null &&
                      state.searchResults.isEmpty) {
                    return Center(
                      child: txt(
                        state.errorMessage!,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  if (state.searchResults.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: txt(
                        _controller.text.trim().isEmpty
                            ? 'در حال حاضر سفری برای نمایش وجود ندارد.'
                            : 'سفری با این نام یا مقصد پیدا نشد.',
                        textAlign: TextAlign.center,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.searchResults.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) =>
                        TripTile(trip: state.searchResults[index]),
                  );
                },
              ),
              SizedBox(height: 16.h),
              const HsNote(
                note: 'برای مشاهده جزئیات و ارسال درخواست عضویت، روی هر سفر بزنید.',
                noteMode: HsNoteType.info,
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
