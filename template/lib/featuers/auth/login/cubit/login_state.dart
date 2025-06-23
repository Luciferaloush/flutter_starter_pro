part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String name;
  LoginSuccess({required this.name});
}

class LoginError extends LoginState {
  final String error;

  LoginError({required this.error});

}
