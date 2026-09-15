import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_appbar.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class BugReportPage extends StatefulWidget {
  const BugReportPage({super.key});

  @override
  State<BugReportPage> createState() => _BugReportPageState();
}

class _BugReportPageState extends State<BugReportPage> {
  //* controllers
  final TextEditingController _subjectController = TextEditingController(
    text: 'مشکل در ثبت تأیید پرداخت',
  );
  final TextEditingController _descriptionController = TextEditingController(
    text:
        'هنگام تأیید پرداخت عضو، برنامه پیام خطا نمایش می‌دهد و وضعیت پرداخت به‌روز نمی‌شود...',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'sara.mohammadi@gmail.com',
  );

  //* issue types
  final List<String> _issueTypes = ['مالی', 'فنی', 'رابط کاربری', 'سایر'];
  String? _selectedType = 'فنی';

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
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
              //* appbar
              HsAppbar(title: 'گزارش باگ و تماس', hasBack: true),
              SizedBox(height: 24.h),

              //* subject label
              txt('موضوع *', style: context.textTheme.labelMedium),
              SizedBox(height: 8.h),

              //* subject input
              TextField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  hintText: 'مثال: مشکل در ثبت تأیید پرداخت',
                ),
              ),
              SizedBox(height: 20.h),

              //* description label
              txt('توضیحات *', style: context.textTheme.labelMedium),
              SizedBox(height: 8.h),

              //* description input
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'توضیحات مشکل را با جزئیات بنویسید...',
                ),
              ),
              SizedBox(height: 20.h),

              //* email label
              txt('ایمیل (اختیاری)', style: context.textTheme.labelMedium),
              SizedBox(height: 8.h),

              //* email input
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'example@email.com',
                ),
              ),
              SizedBox(height: 20.h),

              //* issue type label
              txt('نوع مشکل', style: context.textTheme.labelMedium),
              SizedBox(height: 12.h),

              //* issue type chips
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: _issueTypes.map((type) {
                  final isSelected = _selectedType == type;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedType = type;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? context.colorScheme.primary
                            : context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(999.r),
                        border: Border.all(
                          color: isSelected
                              ? context.colorScheme.primary
                              : context.colorScheme.outline,
                        ),
                      ),
                      child: txt(
                        type,
                        style: context.textTheme.labelMedium,
                        color: isSelected
                            ? context.colorScheme.onPrimary
                            : context.colorScheme.onSurface,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 28.h),

              //* appreciation note box
              HsContainer(
                padding: EdgeInsets.all(16.w),
                radius: 12.r,
                color: context.colorScheme.primaryContainer,
                borderColor: Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.favorite_outline_rounded,
                      color: context.colorScheme.primary,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),

                    //* note text
                    Expanded(
                      child: txt(
                        'بازخورد شما به بهتر شدن همسفر کمک می‌کند 💚',
                        style: context.textTheme.bodySmall,
                        color: context.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              //* submit button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: FilledButton(
                  onPressed: () {},
                  child: txt(
                    'ارسال گزارش',
                    style: context.textTheme.labelLarge,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
