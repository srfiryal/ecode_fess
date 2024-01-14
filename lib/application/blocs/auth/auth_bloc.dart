import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/constants.dart';
import '../../../injection_container.dart';
import '../../repositories/repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository = getIt<AuthRepository>();

  AuthBloc() : super(AuthInitial()) {
    on<GetUserDataEvent>(_getUserData);
  }

  Future<void> _getUserData(GetUserDataEvent data, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await _repository.getUserData();

      emit(GetUserDataLoaded());
    } catch (e, stacktrace) {
      Constants.logger.e(e.toString(), stackTrace: stacktrace);
      emit(AuthError(e.toString()));
    }
  }
}