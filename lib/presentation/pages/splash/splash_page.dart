import 'package:auto_route/auto_route.dart';
import 'package:ecode_fess/l10n/l10n.dart';
import 'package:ecode_fess/presentation/core/ui_constants.dart';
import 'package:ecode_fess/presentation/routes/router.gr.dart';
import 'package:ecode_fess/presentation/widgets/custom_title.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      AutoRouter.of(context).replace(const LoginRoute());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/ic_app.png',
                width: 48,
                height: 48,
              ),
              const SizedBox(width: UiConstants.xsSpacing),
              CustomTitle(
                title: AppLocalizations.of(context).eCodeFess,
                isLarge: true,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      )
    );
  }
}
