import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/enums/hs_badge_type.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_badge.dart';
import 'package:hamsafar/core/widgets/hs_button.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
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
              HsAppBar(title: 'گزارش باگ و تماس', hasBack: true),
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
                    child: HsBadge(
                      label: type,
                      type: isSelected ? HsBadgeType.success : HsBadgeType.none,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 28.h),

              //* appreciation note box
              HsNote(note: 'بازخورد شما به بهتر شدن همسفر کمک می‌کند 💚'),
              SizedBox(height: 24.h),

              //* submit button
              HsButton(child: txt("ارسال گزارش")),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
