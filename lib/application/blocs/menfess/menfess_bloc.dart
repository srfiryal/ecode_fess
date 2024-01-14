import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/constants.dart';
import '../../../data/models/menfess/menfess_model.dart';
import '../../../data/models/pagination/pagination_model.dart';
import '../../../injection_container.dart';
import '../../repositories/repositories.dart';

part 'menfess_event.dart';
part 'menfess_state.dart';

class MenfessBloc extends Bloc<MenfessEvent, MenfessState> {
  final MenfessRepository _repository = getIt<MenfessRepository>();
  int skip = 0;
  bool isFetching = false;
  bool needsFetching = false;

  MenfessBloc() : super(MenfessInitial()) {
    on<GetMenfessesEvent>(_getMenfesses);
  }

  Future<void> _getMenfesses(GetMenfessesEvent data, Emitter<MenfessState> emit) async {
    if (skip > 0) {
      isFetching = true;
    }

    emit(MenfessLoading());

    try {
      if (data.skip != null) {
        skip = data.skip!;
      }

      var res = await _repository.getMenfesses(skip: data.skip);

      PaginationModel paginationModel = PaginationModel.fromJson(res);
      needsFetching = paginationModel.total > paginationModel.skip;

      List<MenfessModel> list = [];
      for (var element in paginationModel.posts) {
        MenfessModel data = MenfessModel.fromJson(element);
        list.add(data);
      }

      emit(GetMenfessesLoaded(list));
    } catch (e, stacktrace) {
      Constants.logger.e(e.toString(), stackTrace: stacktrace);
      emit(MenfessError(e.toString()));
    }

    if (skip > 0) {
      isFetching = false;
    }
  }
}