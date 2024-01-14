import 'package:auto_route/auto_route.dart';
import 'package:ecode_fess/l10n/l10n.dart';
import 'package:ecode_fess/presentation/core/ui_constants.dart';
import 'package:ecode_fess/presentation/routes/router.gr.dart';
import 'package:ecode_fess/presentation/widgets/custom_button.dart';
import 'package:ecode_fess/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            controller: _emailController,
            label: AppLocalizations.of(context).email,
            hint: AppLocalizations.of(context).emailHint,
            icon: Iconsax.sms5,
          ),
          const SizedBox(height: UiConstants.mdSpacing),
          CustomTextField(
            controller: _passwordController,
            label: AppLocalizations.of(context).password,
            hint: AppLocalizations.of(context).passwordHint,
            icon: Iconsax.key5,
            isPassword: true,
          ),
          const SizedBox(height: UiConstants.xlSpacing),
          CustomButton(
            buttonText: AppLocalizations.of(context).login,
            onPressed: () {
              AutoRouter.of(context).replace(const HomeRoute());
            },
          )
        ],
      ),
    );
  }
}
