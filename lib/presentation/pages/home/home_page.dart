import 'package:ecode_fess/data/models/menfess/menfess_model.dart';
import 'package:ecode_fess/l10n/l10n.dart';
import 'package:ecode_fess/presentation/core/color_values.dart';
import 'package:ecode_fess/presentation/widgets/custom_app_bar.dart';
import 'package:ecode_fess/presentation/widgets/custom_menfess.dart';
import 'package:ecode_fess/presentation/widgets/custom_upload_form.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../core/ui_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _uploadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: ColorValues.primary30,
        elevation: 1,
        child: const Icon(Iconsax.message_edit5, color: ColorValues.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: AppLocalizations.of(context).eCodeFess,
              isHome: true,
              onSearchTap: () {},
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: UiConstants.smPadding),
                child: Column(
                  children: [
                    CustomUploadForm(
                      controller: _uploadController,
                      onUpload: () {},
                    ),
                    const SizedBox(height: UiConstants.smSpacing),
                    CustomMenfess(menfess: MenfessModel(id: 1, userId: 1, body: 'But you didnt have to cut me offfff make out like it never happened jasdjajsjdj', reactions: 3))
                  ]
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
