import 'package:ecode_fess/injection_container.dart';
import 'package:ecode_fess/l10n/l10n.dart';
import 'package:ecode_fess/presentation/core/app_theme_data.dart';
import 'package:ecode_fess/presentation/core/color_values.dart';
import 'package:ecode_fess/presentation/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'application/repositories/repositories.dart';
import 'common/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'id';
  init();
  await SharedPreferencesService.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (_, __, ___) {
          return GlobalLoaderOverlay(
            useDefaultLoading: false,
            overlayColor: Colors.black.withOpacity(0.2),
            overlayWidgetBuilder: (_) {
              return const Center(
                  child: SpinKitChasingDots(
                    color: ColorValues.primary50,
                    size: 64,
                  ));
            },
            child: MultiRepositoryProvider(
              providers: [
                RepositoryProvider(
                  create: (context) => getIt<AuthRepository>(),
                ),
                RepositoryProvider(
                  create: (context) => getIt<MenfessRepository>(),
                ),
              ],
              child: MaterialApp.router(
                title: 'E-Code Fess',
                routerDelegate: _appRouter.delegate(),
                routeInformationParser: _appRouter.defaultRouteParser(),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                theme: AppThemeData.getTheme(context),
                debugShowCheckedModeBanner: false,
              ),
            ),
          );
        }
    );
  }
}
