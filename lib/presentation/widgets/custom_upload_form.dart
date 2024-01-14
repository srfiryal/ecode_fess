import 'package:ecode_fess/presentation/core/color_values.dart';
import 'package:ecode_fess/presentation/core/ui_constants.dart';
import 'package:ecode_fess/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:ecode_fess/l10n/l10n.dart';
import 'package:iconsax/iconsax.dart';

import 'custom_text_field.dart';

class CustomUploadForm extends StatefulWidget {
  final TextEditingController controller;
  final bool isComment;
  final VoidCallback onUpload;

  const CustomUploadForm({super.key, this.isComment = false, required this.onUpload, required this.controller});

  @override
  State<CustomUploadForm> createState() => _CustomUploadFormState();
}

class _CustomUploadFormState extends State<CustomUploadForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, UiConstants.smPadding, UiConstants.lgPadding, UiConstants.smPadding),
      decoration: const BoxDecoration(
        color: ColorValues.white,
        border: Border(
          left: BorderSide(color: ColorValues.primary30, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: ColorValues.warning10,
                borderRadius: BorderRadius.circular(UiConstants.xsRadius),
              ),
              child: const Icon(
                Iconsax.profile_tick5,
                size: 14,
                color: ColorValues.warning50,
              ),
            ),
            const SizedBox(width: UiConstants.xsSpacing),
            Text(
              AppLocalizations.of(context).anonymous,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ]),
          const SizedBox(height: UiConstants.smSpacing),
          CustomTextField(
            controller: widget.controller,
            hint: widget.isComment ? AppLocalizations.of(context).replyHint : AppLocalizations.of(context).menfessHint,
            hasBorder: false,
            textInputType: TextInputType.multiline,
            maxLines: 3,
          ),
          const SizedBox(height: UiConstants.smSpacing),
          Align(
            alignment: Alignment.centerRight,
            child: CustomButton(
              buttonText: AppLocalizations.of(context).send,
              isSmall: true,
              onPressed: widget.onUpload,
            )
          )
        ],
      ),
    );
  }
}
