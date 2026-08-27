import 'package:flutter/material.dart';
import 'package:hamsafar/core/extensions/theme_extenstion.dart';
import 'package:hamsafar/core/widgets/txt.dart';

class TextFieldWidget extends StatelessWidget {
  final String? title;
  final String? hintText;
  final int? maxLines;
  final TextEditingController? controller;

  const TextFieldWidget({
    super.key,
    this.title,
    this.hintText,
    this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .end,
      children: [
        //* title
        title != null
            ? txt(title!, style: context.textTheme.bodyMedium)
            : SizedBox(),

        //* field
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
