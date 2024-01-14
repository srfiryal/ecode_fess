import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/models/menfess/menfess_model.dart';
import '../../l10n/l10n.dart';
import '../core/color_values.dart';
import '../core/ui_constants.dart';

class CustomMenfess extends StatefulWidget {
  final MenfessModel menfess;
  final bool isDetail;

  const CustomMenfess({super.key, required this.menfess, this.isDetail = false});

  @override
  State<CustomMenfess> createState() => _CustomMenfessState();
}

class _CustomMenfessState extends State<CustomMenfess> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isDetail) {
          // AutoRouter.of(context).push(MenfessDetailRoute(menfess: widget.menfess));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: UiConstants.smPadding, horizontal: UiConstants.lgPadding),
        decoration: BoxDecoration(
          color: ColorValues.white,
          border: Border.all(color: ColorValues.grey10, width: 0.5)
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
              Expanded(
                child: Text(
                  AppLocalizations.of(context).anonymous,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              const SizedBox(width: UiConstants.smPadding),
              Text(
                '2 Jan',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorValues.grey50),
              ),
              const SizedBox(width: UiConstants.smSpacing),
              const Icon(
                Iconsax.more_square5,
                size: 24,
                color: ColorValues.grey50,
              ),
            ]),
            const SizedBox(height: UiConstants.smSpacing),
            Text(
              widget.menfess.body ?? '-',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: UiConstants.smSpacing),
            Row(
              children: [
                const Icon(
                  Iconsax.heart5,
                  size: 20,
                  color: ColorValues.grey30,
                ),
                const SizedBox(width: UiConstants.xxsSpacing),
                Text(
                  '${widget.menfess.reactions ?? 0} ${AppLocalizations.of(context).likes}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorValues.grey30),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }}