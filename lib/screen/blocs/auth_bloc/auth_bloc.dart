import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoadingLoginState());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(SuccessLoginState(email: event.email));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'invalid-credential') {
            emit(FailureLoginState(errorMessage: 'Email or password is wrong'));
          } else {
            emit(FailureLoginState(errorMessage: e.message ?? 'Login failed'));
          }
        } catch (e) {
          emit(FailureLoginState(errorMessage: 'some thing went wrong'));
        }
      } else if (event is RegisterEvent) {
        emit(LoadingRegisterState());
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
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
    });
  }
}
