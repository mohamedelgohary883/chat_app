import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> registerUser({
    required String emailAddress,
    required String password,
  }) async {
    emit(LoadingState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      emit(SuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(FailureState(errorMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(
          FailureState(
            errorMessage: 'The account already exists for that email.',
          ),
        );
      }
    } catch (e) {
      emit(FailureState(errorMessage: 'something went wrong '));
    }
  }
}
