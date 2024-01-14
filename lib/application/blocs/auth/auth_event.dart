part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class GetUserDataEvent extends AuthEvent {
  const GetUserDataEvent();

  @override
  List<Object?> get props => [];
}