class LoginState {}

class InitialState extends LoginState {}

class LoadingState extends LoginState {}

class SuccessState extends LoginState {
  final String email;

  SuccessState({required this.email});
}

class FailureState extends LoginState {
  final String errorMessage;

  FailureState({required this.errorMessage});
}
