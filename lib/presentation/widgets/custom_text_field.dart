import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../l10n/l10n.dart';
import '../core/color_values.dart';
import '../core/ui_constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      this.validator,
      this.isRequired = true,
      this.isPassword = false,
      this.readOnly = false,
      this.showOptional = false,
      this.isDense = true,
      this.label,
      this.hint,
      this.helper,
      this.icon,
      this.textInputType,
      this.onChanged,
      this.verticalPadding = 15,
      this.horizontalPadding = 16,
      this.minLines = 1,
      this.maxLines = 1,
      this.hasBorder = true,
      this.suffixIcon})
      : super(key: key);
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final bool isRequired, isPassword, isDense, readOnly, showOptional, hasBorder;
  final String? label, hint, helper;
  final IconData? icon, suffixIcon;
  final TextInputType? textInputType;
  final double verticalPadding, horizontalPadding;
  final int? minLines, maxLines;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<bool> _isEmpty = ValueNotifier<bool>(true);
  bool _isShowPassword = true;

  InputBorder _getBorder({Color color = ColorValues.grey10}) {
    return widget.hasBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(UiConstants.mdRadius),
            borderSide: BorderSide(color: color, width: 1))
        : InputBorder.none;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          RichText(
              text: TextSpan(
                  text: widget.label,
                  style: Theme.of(context).textTheme.labelSmall,
                  children: [
                if (widget.isRequired)
                  TextSpan(
                    text: '*',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: ColorValues.danger30),
                  ),
                if (widget.showOptional)
                  TextSpan(
                      text: ' (${AppLocalizations.of(context).optional})',
                      style: Theme.of(context).textTheme.bodySmall),
              ])),
        if (widget.label != null) const SizedBox(height: 8),
        if (widget.readOnly) AbsorbPointer(child: _buildTextField()),
        if (!widget.readOnly) _buildTextField(),
        if (widget.helper != null) const SizedBox(height: 8),
        if (widget.helper != null)
          Row(
            children: [
              const Icon(
                Iconsax.info_circle5,
                size: 16,
                color: ColorValues.grey50,
              ),
              const SizedBox(width: 4),
              Text(
                widget.helper!,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: ColorValues.grey50),
              )
            ],
          ),
      ],
    );
  }

  Widget _buildTextField() {
    return ValueListenableBuilder(
        valueListenable: _isEmpty,
        builder: (context, _, __) {
          return TextFormField(
            onChanged: (s) {
              s.isEmpty ? _isEmpty.value = true : _isEmpty.value = false;
              if (widget.onChanged != null) {
                widget.onChanged!(s);
              }
            },
            controller: widget.controller,
            validator: widget.validator,
            readOnly: widget.readOnly,
            style: Theme.of(context).textTheme.bodySmall,
            obscureText: widget.isPassword ? _isShowPassword : false,
            keyboardType: widget.textInputType ?? TextInputType.text,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              contentPadding: widget.hasBorder
                  ? EdgeInsets.symmetric(
                      vertical: widget.verticalPadding,
                      horizontal: widget.horizontalPadding)
                  : EdgeInsets.zero,
              hintText: widget.hint,
              hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorValues.text50),
              filled: true,
              fillColor: Colors.white,
              border: _getBorder(),
              isDense: widget.isDense,
              focusedBorder: _getBorder(color: ColorValues.primary50),
              enabledBorder: _getBorder(
                  color:
                      _isEmpty.value ? ColorValues.grey10 : ColorValues.grey10),
              disabledBorder: _getBorder(),
              errorBorder: _getBorder(color: ColorValues.danger50),
              focusedErrorBorder: _getBorder(color: ColorValues.danger50),
              prefixIcon: widget.icon == null
                  ? null
                  : Icon(
                      widget.icon,
                      size: 16,
                      color: ColorValues.grey50,
                    ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 60,
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 60,
              ),
              suffixIcon: widget.suffixIcon != null
                  ? Icon(
                      widget.suffixIcon,
                      size: 16,
                      color: ColorValues.grey50,
                    )
                  : widget.isPassword
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _isShowPassword = !_isShowPassword;
                            });
                          },
                          child: Icon(
                            size: 5.5.w,
                            _isShowPassword ? Iconsax.eye4 : Iconsax.eye_slash5,
                          ),
                        )
                      : null,
            ),
          );
        });
  }
}
