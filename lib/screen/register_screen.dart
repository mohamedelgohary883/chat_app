import 'package:chat_app/screen/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/screen_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? emailAddress, password;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingRegisterState) {
          CircularProgressIndicator();
        } else if (state is SuccessRegisterState) {
          Navigator.pop(context);
        } else if (state is FailureRegisterState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: Scaffold(
        body: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              ScreenItem(
                screenText: 'Register',
                text: 'sign up',
                onEmailChanged: (value) {
                  emailAddress = value;
                },
                onPasswordChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Sign Up',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<AuthBloc>(context).add(
                      RegisterEvent(email: emailAddress!, password: password!),
                    );
                  }
                  setState(() {
                    autovalidateMode = AutovalidateMode.always;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'already have an account?',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'login',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff696FDD),
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                        decorationColor: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
