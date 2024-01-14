import 'package:flutter/material.dart';

import '../core/color_values.dart';
import '../core/ui_constants.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {Key? key,
      this.onPressed,
      required this.buttonText,
      this.backgroundColor = ColorValues.primary50,
      this.borderRadius = UiConstants.mdRadius,
      this.isSmall = false})
      : super(key: key);
  final Function()? onPressed;
  final String buttonText;
  final double borderRadius;
  final Color backgroundColor;
  final bool isSmall;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            elevation: 0,
            backgroundColor: widget.backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                side: BorderSide(
                    color: widget.onPressed == null ? Colors.transparent : widget.backgroundColor,
                    width: 1))),
        child: Text(
          widget.buttonText,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorValues.white),
        )
    );
  }
}
