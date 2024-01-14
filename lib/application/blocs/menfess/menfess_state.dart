part of 'menfess_bloc.dart';

abstract class MenfessState extends Equatable {
  const MenfessState();
}

class MenfessInitial extends MenfessState {
  @override
  List<Object> get props => [];
}

class MenfessLoading extends MenfessState {
  @override
  List<Object> get props => [];
}

class MenfessError extends MenfessState {
  final String error;

  const MenfessError(this.error);
  @override
  List<Object> get props => [error];
}

class GetMenfessesLoaded extends MenfessState {
  final List<MenfessModel> list;

  const GetMenfessesLoaded(this.list);

  @override
  List<Object> get props => [list];
}
