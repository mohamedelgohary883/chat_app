part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoadingLoginState extends AuthState {}

class SuccessLoginState extends AuthState {
  final String email;

  SuccessLoginState({required this.email});
}

class FailureLoginState extends AuthState {
  final String errorMessage;

  FailureLoginState({required this.errorMessage});
}

final class RegisterInitial extends AuthState {}

class LoadingRegisterState extends AuthState {}

class SuccessRegisterState extends AuthState {}

class FailureRegisterState extends AuthState {
  final String errorMessage;

  FailureRegisterState({required this.errorMessage});
}
