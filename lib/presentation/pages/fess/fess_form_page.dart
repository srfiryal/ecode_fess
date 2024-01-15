import 'package:auto_route/auto_route.dart';
import 'package:ecode_fess/application/repositories/menfess/menfess_repository.dart';
import 'package:ecode_fess/data/models/menfess/menfess_model.dart';
import 'package:ecode_fess/injection_container.dart';
import 'package:ecode_fess/l10n/l10n.dart';
import 'package:ecode_fess/presentation/core/ui_constants.dart';
import 'package:ecode_fess/presentation/widgets/custom_app_bar.dart';
import 'package:ecode_fess/presentation/widgets/custom_upload_form.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../common/constants.dart';
import '../../../common/shared_code.dart';

class FessFormPage extends StatefulWidget {
  final MenfessModel? menfessModel;

  const FessFormPage({super.key, this.menfessModel});

  @override
  State<FessFormPage> createState() => _FessFormPageState();
}

class _FessFormPageState extends State<FessFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final MenfessRepository _menfessRepository = getIt<MenfessRepository>();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.menfessModel != null) _bodyController.text = widget.menfessModel!.body!;

    super.initState();
  }

  Future<void> _sendFess() async {
    if (_formKey.currentState?.validate() ?? true) {
      context.loaderOverlay.show();
      try {
        String body = _bodyController.text;

        await _menfessRepository.addMenfess(body: body);

        SharedCode.showSnackBar(type: Constants.snackBarSuccess, context: context, message: AppLocalizations.of(context).fessSent);
      } catch (e, trace) {
        Constants.logger.e(e.toString(), stackTrace: trace);
        SharedCode.showSnackBar(type: Constants.snackBarDanger, context: context, message: e.toString());
      }
    } else {
      SharedCode.showSnackBar(type: Constants.snackBarWarning, context: context, message: AppLocalizations.of(context).fessEmpty);
    }
    context.loaderOverlay.hide();
  }

  Future<void> _updateFess() async {
    if (_formKey.currentState?.validate() ?? true) {
      context.loaderOverlay.show();
      try {
        String body = _bodyController.text;

        await _menfessRepository.updateMenfess(id: widget.menfessModel!.id, body: body);

        SharedCode.showSnackBar(type: Constants.snackBarSuccess, context: context, message: AppLocalizations.of(context).commentSent);
      } catch (e, trace) {
        Constants.logger.e(e.toString(), stackTrace: trace);
        SharedCode.showSnackBar(type: Constants.snackBarDanger, context: context, message: e.toString());
      }
    } else {
      SharedCode.showSnackBar(type: Constants.snackBarWarning, context: context, message: AppLocalizations.of(context).fessEmpty);
    }
    context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: widget.menfessModel == null ? AppLocalizations.of(context).sendFess : AppLocalizations.of(context).updateFess),
            const SizedBox(height: UiConstants.smSpacing),
            Form(
              key: _formKey,
              child: CustomUploadForm(
                onUpload: widget.menfessModel == null ? _sendFess : _updateFess,
                controller: _bodyController,
              ),
            )
          ]
        )
      ),
    );
  }
}
