part of 'register_cubit.dart';

sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

class LoadingState extends RegisterState {}

class SuccessState extends RegisterState {}

class FailureState extends RegisterState {
  final String errorMessage;

  FailureState({required this.errorMessage});
}
