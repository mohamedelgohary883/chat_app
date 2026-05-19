import 'package:chat_app/screen/cubit/login_cubit/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());
  Future<void> loginUser({
    required String emailAddress,
    required String password,
  }) async {
    emit(LoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      emit(SuccessState(email: emailAddress));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(FailureState(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(
          FailureState(errorMessage: 'Wrong password provided for that user.'),
        );
      }
    } catch (e) {
      emit(FailureState(errorMessage: 'some thing went wrong'));
    }
  }
}
