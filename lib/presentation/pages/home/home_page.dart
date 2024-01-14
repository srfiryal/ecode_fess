import 'package:ecode_fess/application/blocs/menfess/menfess_bloc.dart';
import 'package:ecode_fess/common/constants.dart';
import 'package:ecode_fess/data/models/menfess/menfess_model.dart';
import 'package:ecode_fess/l10n/l10n.dart';
import 'package:ecode_fess/presentation/core/color_values.dart';
import 'package:ecode_fess/presentation/widgets/custom_app_bar.dart';
import 'package:ecode_fess/presentation/widgets/custom_menfess.dart';
import 'package:ecode_fess/presentation/widgets/custom_upload_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../common/shared_code.dart';
import '../../core/ui_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _uploadController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _bloc = MenfessBloc();
  List<MenfessModel>? _list;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshPage();
    });
    super.initState();
  }

  Future<void> _refreshPage() async {
    _list = null;
    _bloc.skip = 0;
    _bloc.needsFetching = false;
    _bloc.isFetching = false;
    _bloc.add(const GetMenfessesEvent());
  }

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
                              !_bloc.isFetching &&
                              _bloc.needsFetching) {
                            _bloc.skip += 10;
                            _bloc.add(GetMenfessesEvent(skip: _bloc.skip += 10));
                          }
                        }),
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: UiConstants.smPadding),
                      child: Column(
                        children: [
                          CustomUploadForm(
                            controller: _uploadController,
                            onUpload: () {},
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
      bloc: _bloc,
      builder: (context, state) {
        if (state is GetMenfessesLoaded) {
          if (_bloc.skip == 0) {
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
            if (_bloc.isFetching) const SizedBox(height: 10, child: LinearProgressIndicator(color: ColorValues.primary30)),
          ],
        );
      },
    );
  }
}
