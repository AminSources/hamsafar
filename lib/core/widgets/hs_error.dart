import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/extensions/theme_extension.dart';
import 'package:hamsafar/core/widgets/hs_svg_picture.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class HsError extends StatelessWidget {
  final String illustrationPath;
  final String title;
  final String? subtitle;

  const HsError({
    super.key,
    required this.illustrationPath,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          //* icon
          HsSvgPicture(
            assetPath: illustrationPath,
            targetColor: context.colorScheme.primary,
            width: 200.w,
          ),
          SizedBox(height: 16.h),

          //* title
          txt(title, style: context.textTheme.headlineLarge),
          SizedBox(height: 6.h),

          //* subtitle
          if (subtitle != null) ...[
            txt(subtitle ?? "", style: context.textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}
