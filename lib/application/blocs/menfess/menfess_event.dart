part of 'menfess_bloc.dart';

abstract class MenfessEvent extends Equatable {
  const MenfessEvent();
}

class GetMenfessesEvent extends MenfessEvent {
  final int? skip;

  const GetMenfessesEvent({this.skip});

  @override
  List<Object?> get props => [skip];
}

class GetCommentsEvent extends MenfessEvent {
  final int postId;
  final int? skip;

  const GetCommentsEvent({required this.postId, this.skip});

  @override
  List<Object?> get props => [skip];
}