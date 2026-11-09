import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamsafar/core/enums/hs_note_type.dart';
import 'package:hamsafar/core/enums/hs_snack_bar_type.dart';
import 'package:hamsafar/core/extensions/hs_snack_bar_extension.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/core/widgets/txt.dart';
import 'package:hamsafar/features/profile/domain/entities/profile_preferences_entity.dart';
import 'package:hamsafar/features/profile/presentation/cubit/profile_preferences_cubit.dart';
import 'package:hamsafar/features/profile/presentation/widgets/tool_tile.dart';

import 'package:hamsafar/core/localization/app_translations.dart';
class MyToolsPage extends StatefulWidget {
  const MyToolsPage({super.key});

  @override
  State<MyToolsPage> createState() => _MyToolsPageState();
}

class _MyToolsPageState extends State<MyToolsPage> {
  final List<ProfileToolEntity> _tools = [];
  bool _initialized = false;

  void _initializeTools(ProfilePreferencesState state) {
    if (_initialized) return;

    setState(() {
      _tools
        ..clear()
        ..addAll(state.tools);
      _initialized = true;
    });
  }

  Future<String?> _showAddToolSheet() {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: context.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => const _AddToolBottomSheet(),
    );
  }

  Future<void> _addTool() async {
    final name = await _showAddToolSheet();
    if (!mounted || name == null) return;

    final normalizedName = name.trim();
    final alreadyExists = _tools.any(
      (tool) => tool.name.toLowerCase() == normalizedName.toLowerCase(),
    );

    if (alreadyExists) {
      context.showHsSnackBar(
        text: 'این وسیله در فهرست شما وجود دارد',
        hsSnackBarType: HsSnackBarType.warning,
      );
      return;
    }

    setState(() {
      _tools.add(ProfileToolEntity(name: normalizedName, isAvailable: true));
    });
  }

  Future<void> _save() async {
    final cubit = context.read<ProfilePreferencesCubit>();
    final saved = await cubit.saveTools(List.unmodifiable(_tools));
    if (!mounted) return;

    if (saved) {
      context.showHsSnackBar(
        text: 'فهرست وسایل با موفقیت ذخیره شد',
        hsSnackBarType: HsSnackBarType.success,
      );
      context.pop(true);
    } else {
      context.showHsSnackBar(
        text: cubit.state.message ?? 'ذخیره تغییرات ناموفق بود',
        hsSnackBarType: HsSnackBarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProfilePreferencesCubit, ProfilePreferencesState>(
          listener: (context, state) {
            if (state.isLoaded && !_initialized) {
              _initializeTools(state);
            }
          },
          builder: (context, state) {
            if (state.isLoading || (!state.isLoaded && state.message == null)) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!state.isLoaded) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      txt(
                        state.message ?? 'دریافت اطلاعات ناموفق بود',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),
                      TextButton(
                        onPressed: () {
                          context.read<ProfilePreferencesCubit>().load();
                        },
                        child: const txt('تلاش دوباره'),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HsAppBar(title: 'وسایل من', hasBack: true),
                  SizedBox(height: 16.h),
                  HsNote(
                    note:
                        'وسایلی که می‌توانید در سفرها همراه بیاورید؛ لیدر بر اساس این لیست وظایف را تقسیم می‌کند.',
                    noteMode: HsNoteType.success,
                  ),
                  SizedBox(height: 24.h),
                  if (_tools.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Center(
                        child: txt(
                          'هنوز وسیله‌ای اضافه نکرده‌اید',
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _tools.length,
                      itemBuilder: (context, index) {
                        final tool = _tools[index];

                        return Padding(
                          padding: EdgeInsets.only(
                            top: index == 0 ? 0 : 12.h,
                          ),
                          child: ToolTile(
                            toolName: tool.name,
                            toolStatus: tool.isAvailable,
                            onChanged: state.isSaving
                                ? null
                                : (value) {
                                    setState(() {
                                      _tools[index] =
                                          tool.copyWith(isAvailable: value);
                                    });
                                  },
                          ),
                        );
                      },
                    ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: OutlinedButton.icon(
                      onPressed: state.isSaving ? null : _addTool,
                      icon: Icon(Icons.add_rounded, size: 20.sp),
                      label: txt(
                        'افزودن وسیله جدید',
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  HsButton(
                    onTap: state.isSaving ? null : _save,
                    child: state.isSaving
                        ? SizedBox(
                            width: 22.w,
                            height: 22.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : txt('ذخیره تغییرات'),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AddToolBottomSheet extends StatefulWidget {
  const _AddToolBottomSheet();

  @override
  State<_AddToolBottomSheet> createState() => _AddToolBottomSheetState();
}

class _AddToolBottomSheetState extends State<_AddToolBottomSheet> {
  late final TextEditingController _nameController;
  String? _validationMessage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _addTool() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      setState(() {
        _validationMessage = 'عنوان وسیله را وارد کنید';
      });
      return;
    }

    Navigator.of(context).pop(name);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.85,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  txt(
                    'افزودن وسیله جدید',
                    style: context.textTheme.titleLarge,
                  ),
                  SizedBox(height: 18.h),
                  TextField(
                    controller: _nameController,
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    onChanged: (_) {
                      if (_validationMessage != null) {
                        setState(() {
                          _validationMessage = null;
                        });
                      }
                    },
                    onSubmitted: (_) => _addTool(),
                    decoration: InputDecoration(
                      labelText: AppTranslations.translate(context, 'عنوان وسیله'),
                      hintText: AppTranslations.translate(context, 'مثلاً چراغ قوه'),
                      errorText: _validationMessage,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 18.h),
                  HsButton(
                    onTap: _addTool,
                    child: txt('افزودن'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
