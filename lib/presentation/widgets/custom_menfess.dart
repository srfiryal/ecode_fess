import 'package:auto_route/auto_route.dart';
import 'package:ecode_fess/common/shared_code.dart';
import 'package:ecode_fess/presentation/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../application/repositories/menfess/menfess_repository.dart';
import '../../common/constants.dart';
import '../../data/models/menfess/menfess_model.dart';
import '../../injection_container.dart';
import '../../l10n/l10n.dart';
import '../core/color_values.dart';
import '../core/ui_constants.dart';

class CustomMenfess extends StatefulWidget {
  final MenfessModel menfess;
  final bool isClickable;

  const CustomMenfess({super.key, required this.menfess, this.isClickable = true});

  @override
  State<CustomMenfess> createState() => _CustomMenfessState();
}

class _CustomMenfessState extends State<CustomMenfess> {
  final MenfessRepository _menfessRepository = getIt<MenfessRepository>();

  Future<void> _deleteFess() async {
    context.loaderOverlay.show();
    try {
      await _menfessRepository.deleteMenfess(id: widget.menfess.id);

      SharedCode.showSnackBar(type: Constants.snackBarSuccess, context: context, message: AppLocalizations.of(context).fessDeleted);
    } catch (e, trace) {
      Constants.logger.e(e.toString(), stackTrace: trace);
      SharedCode.showSnackBar(type: Constants.snackBarDanger, context: context, message: e.toString());
    }
    context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isClickable) {
          AutoRouter.of(context).push(FessDetailRoute(menfessModel: widget.menfess));
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
              PopupMenuButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  Iconsax.more_square5,
                  size: 24,
                  color: ColorValues.grey50,
                ),
                itemBuilder: (context) {
                  PopupMenuItem edit = PopupMenuItem(
                    height: 32,
                    onTap: () {
                      AutoRouter.of(context).navigate(FessFormRoute(menfessModel: widget.menfess));
                    },
                    child: Text(AppLocalizations.of(context).edit, style: Theme.of(context).textTheme.bodySmall),
                  );

                  PopupMenuItem delete = PopupMenuItem(
                    height: 32,
                    onTap: () {
                      SharedCode.showAlertDialog(
                        context: context,
                        title: AppLocalizations.of(context).delete,
                        description: AppLocalizations.of(context).deleteDesc,
                        proceedAction: _deleteFess,
                      );
                    },
                    child: Text(AppLocalizations.of(context).delete, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorValues.danger50)),
                  );

                  return [edit, delete];
                },
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
