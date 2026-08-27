import 'package:flutter/material.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class AuthFooterWidget extends StatelessWidget {
  const AuthFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      textDirection: TextDirection.rtl,
      children: [
        txt("،با ادامه", style: context.textTheme.bodySmall),
        TextButton(
          onPressed: () {},
          child: txt(
            "شرایط استفاده",
            size: context.textTheme.bodyMedium!.fontSize,
          ),
        ),
        txt("و", style: context.textTheme.bodySmall),
        TextButton(
          onPressed: () {},
          child: txt(
            "حریم خصوصی",
            size: context.textTheme.bodyMedium!.fontSize,
          ),
        ),
        txt(".همسفر را می پذیرید", style: context.textTheme.bodySmall),
      ],
    );
  }
}
