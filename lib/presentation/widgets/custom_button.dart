import 'package:flutter/material.dart';

import '../core/color_values.dart';
import '../core/ui_constants.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {Key? key,
      this.onPressed,
      required this.buttonText,
      this.backgroundColor = ColorValues.primary50,
      this.textColor = ColorValues.white,
      this.isSmall = false})
      : super(key: key);
  final Function()? onPressed;
  final String buttonText;
  final Color backgroundColor, textColor;
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
            minimumSize: widget.isSmall ? const Size(0, 32) :  const Size(double.infinity, 48),
            elevation: 0,
            padding: widget.isSmall ? const EdgeInsets.symmetric(vertical: 7, horizontal: 12) : null,
            backgroundColor: widget.backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.isSmall ? UiConstants.smRadius : UiConstants.mdRadius),
                side: BorderSide(
                    color: widget.onPressed == null ? Colors.transparent : widget.backgroundColor,
                    width: 1))),
        child: Text(
          widget.buttonText,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: widget.textColor),
        )
    );
  }
}
