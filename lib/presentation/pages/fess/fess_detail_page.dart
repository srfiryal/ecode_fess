import 'package:ecode_fess/data/models/menfess/menfess_model.dart';
import 'package:ecode_fess/presentation/core/color_values.dart';
import 'package:ecode_fess/presentation/widgets/custom_menfess.dart';
import 'package:ecode_fess/presentation/widgets/custom_upload_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../application/blocs/menfess/menfess_bloc.dart';
import '../../../common/constants.dart';
import '../../../common/shared_code.dart';
import '../../../l10n/l10n.dart';
import '../../core/ui_constants.dart';
import '../../widgets/custom_app_bar.dart';

class FessDetailPage extends StatefulWidget {
  final MenfessModel menfessModel;

  const FessDetailPage({super.key, required this.menfessModel});

  @override
  State<FessDetailPage> createState() => _FessDetailPageState();
}

class _FessDetailPageState extends State<FessDetailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final MenfessBloc _menfessBloc = MenfessBloc();
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
    _menfessBloc.skip = 0;
    _menfessBloc.needsFetching = false;
    _menfessBloc.isFetching = false;
    _menfessBloc.add(GetCommentsEvent(postId: widget.menfessModel.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            children: [
              CustomAppBar(title: AppLocalizations.of(context).replies),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshPage,
                  child: Stack(
                    children: [
                      ListView(physics: const AlwaysScrollableScrollPhysics()),
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: UiConstants.smPadding),
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
                          child: Column(
                          children: [
                            CustomMenfess(
                              menfess: widget.menfessModel,
                              isClickable: false,
                            ),
                            Form(
                              key: _formKey,
                              child: CustomUploadForm(
                                onUpload: () {},
                                controller: _commentController,
                                isComment: true,
                              ),
                            ),
                            Container(
                              width: 100.w,
                              padding: const EdgeInsets.symmetric(vertical: UiConstants.mdPadding, horizontal: UiConstants.lgPadding),
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorValues.grey10, width: 0.5),
                              ),
                              child: Text(
                                AppLocalizations.of(context).repliesList,
                                style: Theme.of(context).textTheme.labelLarge,
                              )
                            ),
                            _buildCommentList(),
                          ]
                        )
                      ),
                    ],
                  ),
                ),
              )
            ]
        )
      ),
    );
  }

  Widget _buildCommentList() {
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
                    isClickable: false,
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
