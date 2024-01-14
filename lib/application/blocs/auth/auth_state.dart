part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthError extends AuthState {
  final String error;

  const AuthError(this.error);
  @override
  List<Object> get props => [error];
}

class GetUserDataLoaded extends AuthState {
  @override
  List<Object> get props => [];
}
