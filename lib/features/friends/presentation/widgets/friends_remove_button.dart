import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_container.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FriendsRemoveButton extends StatelessWidget {
  final VoidCallback onRemove;
  final bool isLoading;

  const FriendsRemoveButton({
    super.key,
    required this.onRemove,
    this.isLoading = false,
  });

  Future<void> _confirmRemoval(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف دوست'),
        content: const Text(
          'آیا مطمئن هستید که می‌خواهید این کاربر را از فهرست دوستان حذف کنید؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('انصراف'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (confirmed == true) onRemove();
  }

  @override
  Widget build(BuildContext context) {
    return HsContainer(
      width: 40.w,
      height: 40.w,
      onTap: isLoading ? null : () => _confirmRemoval(context),
      child: isLoading
          ? SizedBox(
              width: 18.w,
              height: 18.w,
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(
              LucideIcons.userRoundMinus,
              size: 18.sp,
              color: context.colorScheme.error,
            ),
    );
  }
}
