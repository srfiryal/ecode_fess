import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../l10n/l10n.dart';
import '../presentation/core/color_values.dart';
import '../presentation/core/ui_constants.dart';
import 'constants.dart';

class SharedCode {
  late BuildContext _context;

  SharedCode(BuildContext context) {
    _context = context;
  }

  String? emptyValidators(String? value) {
    return value.toString().trim().isEmpty ? AppLocalizations.of(_context).emptyValidator : null;
  }

  String? passwordValidators(String? value) {
    String? result = emptyValidators(value);
    if (result != null) return result;
    if (value.toString().length < 6) return AppLocalizations.of(_context).passwordValidator;
    return null;
  }

  String? emailValidators(String? value) {
    String? result = emptyValidators(value);
    if (result != null) return result;
    bool isValid = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value ?? '');
    return isValid ? null : AppLocalizations.of(_context).emailValidator;
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
    required String type,
    bool isTop = false
  }) {
    Color contentColor = ColorValues.warning50;
    Color borderColor = ColorValues.warning30;
    Color backgroundColor = ColorValues.warning10;

    switch (type) {
      case Constants.snackBarSuccess:
        contentColor = ColorValues.success50;
        borderColor = ColorValues.success30;
        backgroundColor = ColorValues.success10;
        break;
      case Constants.snackBarWarning:
        contentColor = ColorValues.warning50;
        borderColor = ColorValues.warning30;
        backgroundColor = ColorValues.warning10;
        break;
      case Constants.snackBarDanger:
        contentColor = ColorValues.danger50;
        borderColor = ColorValues.danger30;
        backgroundColor = ColorValues.danger10;
        break;
    }

    Flushbar flushBar = Flushbar();
    flushBar = Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: isTop ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(UiConstants.lgPadding),
      padding: const EdgeInsets.all(UiConstants.xsPadding),
      borderRadius: BorderRadius.circular(UiConstants.smRadius),
      backgroundColor: backgroundColor,
      borderWidth: 1,
      borderColor: borderColor,
      messageText: Row(children: [
        Container(
          padding: const EdgeInsets.all(UiConstants.xsPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UiConstants.smRadius),
            color: contentColor,
          ),
          child: Center(
            child: Icon(
              type == Constants.snackBarSuccess ? Iconsax.check : Iconsax.info_circle,
              color: ColorValues.white,
              size: 16)
          ),
        ),
        Expanded(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: UiConstants.mdSpacing),
              child: Text(message, style: Theme.of(context).textTheme.bodySmall),
            )),
        GestureDetector(
            onTap: () => flushBar.dismiss(),
            child: Icon(Iconsax.close_circle, size: 16, color: contentColor))
      ]),
    );

    flushBar.show(context);
  }

  static void showAlertDialog(
      {required BuildContext context,
        required String title,
        String? description,
        Widget? descriptionWidget,
        String? proceedText,
        Function()? proceedAction}) {

    Widget proceedButton = ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
        proceedAction?.call();
      },
      child: Text(proceedText ?? AppLocalizations.of(context).yes,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.white)),
    );

    Widget cancelButton = OutlinedButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(
        AppLocalizations.of(context).cancel,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );

    AlertDialog alert = AlertDialog(
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          descriptionWidget ??
              Text(description ?? '',
                  style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(
            height: UiConstants.mdSpacing,
          ),
          Row(
            children: [
              if (proceedText != null) Expanded(child: cancelButton),
              if (proceedText != null) const SizedBox(
                width: UiConstants.mdSpacing,
              ),
              Expanded(child: proceedButton),
            ],
          )
        ],
      ),
    );

    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (_) {
          return alert;
        },
      );
    });
  }
}