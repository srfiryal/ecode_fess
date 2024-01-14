import 'package:flutter/material.dart';

import '../core/color_values.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final bool isLarge;
  final TextAlign textAlign;

  const CustomTitle({super.key, required this.title, this.isLarge = false, this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        text: '// ',
        style: isLarge
            ? Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorValues.text30)
            : Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorValues.text30),
        children: [
          TextSpan(
            text: title,
            style: isLarge
              ? Theme.of(context).textTheme.titleLarge
              : Theme.of(context).textTheme.titleSmall,
          ),
        ],
      )
    );
  }
}
