import 'package:auto_route/auto_route.dart';
import 'package:ecode_fess/application/blocs/auth/auth_bloc.dart';
import 'package:ecode_fess/application/blocs/menfess/menfess_bloc.dart';
import 'package:ecode_fess/common/constants.dart';
import 'package:ecode_fess/data/models/menfess/menfess_model.dart';
import 'package:ecode_fess/l10n/l10n.dart';
import 'package:ecode_fess/presentation/core/color_values.dart';
import 'package:ecode_fess/presentation/core/shared_data.dart';
import 'package:ecode_fess/presentation/widgets/custom_app_bar.dart';
import 'package:ecode_fess/presentation/widgets/custom_menfess.dart';
import 'package:ecode_fess/presentation/widgets/custom_upload_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../application/repositories/menfess/menfess_repository.dart';
import '../../../common/shared_code.dart';
import '../../../injection_container.dart';
import '../../core/ui_constants.dart';
import '../../routes/router.gr.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _uploadController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final AuthBloc _authBloc = AuthBloc();
  final MenfessBloc _menfessBloc = MenfessBloc();
  final MenfessRepository _menfessRepository = getIt<MenfessRepository>();
  List<MenfessModel>? _list;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshPage();
    });

    _authBloc.add(const GetUserDataEvent());

    super.initState();
  }

  Future<void> _sendFess() async {
    if (_formKey.currentState?.validate() ?? true) {
      context.loaderOverlay.show();
      try {
        String body = _uploadController.text;

        await _menfessRepository.addMenfess(body: body);

        SharedCode.showSnackBar(type: Constants.snackBarSuccess, context: context, message: AppLocalizations.of(context).fessSent);
      } catch (e, trace) {
        Constants.logger.e(e.toString(), stackTrace: trace);
        SharedCode.showSnackBar(type: Constants.snackBarDanger, context: context, message: e.toString());
      }
      context.loaderOverlay.hide();
    } else {
      SharedCode.showSnackBar(type: Constants.snackBarWarning, context: context, message: AppLocalizations.of(context).fessEmpty);
    }
  }

  Future<void> _refreshPage() async {
    _list = null;
    _menfessBloc.skip = 0;
    _menfessBloc.needsFetching = false;
    _menfessBloc.isFetching = false;
    _menfessBloc.add(const GetMenfessesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AutoRouter.of(context).push(FessFormRoute());
        },
        backgroundColor: ColorValues.primary30,
        elevation: 1,
        child: const Icon(Iconsax.message_edit5, color: ColorValues.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder(
              bloc: _authBloc,
              builder: (context, state) {
                if (state is AuthError) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    SharedCode.showSnackBar(type: Constants.snackBarDanger, context: context, message: state.error);
                  });
                }

                return Skeletonizer(
                  enabled: SharedData.userData.value == null,
                  child: CustomAppBar(
                    title: AppLocalizations.of(context).eCodeFess,
                    isHome: true,
                    onSearchTap: () {},
                  ),
                );
              },
            ),
            Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshPage,
                  child: Stack(
                    children: [
                      ListView(physics: const AlwaysScrollableScrollPhysics()),
                      SingleChildScrollView(
                        controller: _scrollController
                          ..addListener(() async {
                            if (_scrollController.offset ==
                                _scrollController.position.maxScrollExtent &&
                                !_menfessBloc.isFetching &&
                                _menfessBloc.needsFetching) {
                              _menfessBloc.skip += 10;
                              _menfessBloc.add(GetMenfessesEvent(skip: _menfessBloc.skip += 10));
                            }
                          }),
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: UiConstants.smPadding),
                        child: Column(
                            children: [
                              Form(
                                key: _formKey,
                                child: CustomUploadForm(
                                  controller: _uploadController,
                                  onUpload: _sendFess,
                                ),
                              ),
                              const SizedBox(height: UiConstants.smSpacing),
                              _buildMenfessList(),
                            ]
                        ),
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMenfessList() {
    return BlocBuilder<MenfessBloc, MenfessState>(
      bloc: _menfessBloc,
      builder: (context, state) {
        if (state is GetMenfessesLoaded) {
          if (_menfessBloc.skip == 0) {
            _list = state.list;
          } else {
            _list?.addAll(state.list);
          }
        }
        if (state is MenfessError) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            SharedCode.showSnackBar(type: Constants.snackBarDanger, context: context, message: state.error);
          });
        }

        return Column(
          children: [
            Skeletonizer(
              enabled: _list == null,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _list?.length ?? 0,
                itemBuilder: (context, index) {
                  return CustomMenfess(
                    menfess: _list![index],
                  );
                },
              ),
            ),
            if (_menfessBloc.isFetching) const SizedBox(height: 10, child: LinearProgressIndicator(color: ColorValues.primary30)),
          ],
        );
      },
    );
  }
}