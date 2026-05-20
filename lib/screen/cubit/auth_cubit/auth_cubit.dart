import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> loginUser({
    required String emailAddress,
    required String password,
  }) async {
    emit(LoadingLoginState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      emit(SuccessLoginState(email: emailAddress));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(FailureLoginState(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(
          FailureLoginState(
            errorMessage: 'Wrong password provided for that user.',
          ),
        );
      }
    } catch (e) {
      emit(FailureLoginState(errorMessage: 'some thing went wrong'));
    }
  }

  Future<void> registerUser({
    required String emailAddress,
    required String password,
  }) async {
    emit(LoadingRegisterState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      emit(SuccessRegisterState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
          FailureRegisterState(
            errorMessage: 'The password provided is too weak.',
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        emit(
          FailureRegisterState(
            errorMessage: 'The account already exists for that email.',
          ),
        );
      }
    } catch (e) {
      emit(FailureRegisterState(errorMessage: 'something went wrong '));
    }
  }
}
