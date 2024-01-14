import 'package:auto_route/auto_route.dart';
import 'package:ecode_fess/l10n/l10n.dart';
import 'package:ecode_fess/presentation/core/ui_constants.dart';
import 'package:ecode_fess/presentation/routes/router.gr.dart';
import 'package:ecode_fess/presentation/widgets/custom_button.dart';
import 'package:ecode_fess/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../application/repositories/auth/auth_repository.dart';
import '../../../common/constants.dart';
import '../../../common/shared_code.dart';
import '../../../injection_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthRepository _repository = getIt<AuthRepository>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? true) {
      context.loaderOverlay.show();
      try {
        String username = _usernameController.text;
        String password = _passwordController.text;

        await _repository.login(username, password);

        AutoRouter.of(context).replace(const HomeRoute());
      } catch (e, trace) {
        Constants.logger.e(e.toString(), stackTrace: trace);
        SharedCode.showSnackBar(type: Constants.snackBarDanger, context: context, message: e.toString());
      }
      context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(UiConstants.lgPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeading(),
              const SizedBox(height: UiConstants.xlSpacing),
              _buildForm(),
            ],
          )
        )
      )
    );
  }

  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/ic_app.png',
          width: 72,
          height: 72,
        ),
        const SizedBox(height: UiConstants.lgSpacing),
        Text(
          AppLocalizations.of(context).loginTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: UiConstants.xsSpacing),
        Text(
          AppLocalizations.of(context).loginDesc,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _usernameController,
            label: AppLocalizations.of(context).email,
            hint: AppLocalizations.of(context).emailHint,
            validator: SharedCode(context).emptyValidators,
            icon: Iconsax.sms5,
          ),
          const SizedBox(height: UiConstants.mdSpacing),
          CustomTextField(
            controller: _passwordController,
            label: AppLocalizations.of(context).password,
            hint: AppLocalizations.of(context).passwordHint,
            validator: SharedCode(context).passwordValidators,
            icon: Iconsax.key5,
            isPassword: true,
          ),
          const SizedBox(height: UiConstants.xlSpacing),
          CustomButton(
            buttonText: AppLocalizations.of(context).login,
            onPressed: _login,
          )
        ],
      ),
    );
  }
}
