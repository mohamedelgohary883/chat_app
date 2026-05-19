import 'package:chat_app/screen/chat_screen.dart';
import 'package:chat_app/screen/cubit/login_cubit/login_cubit.dart';
import 'package:chat_app/screen/cubit/login_cubit/login_state.dart';
import 'package:chat_app/screen/register_screen.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/screen_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? emailAddress, password;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoadingState) {
          Center(child: CircularProgressIndicator());
        } else if (state is SuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(email: state.email),
            ),
          );
        } else if (state is FailureState) {
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
                text: 'Login',
                onEmailChanged: (value) {
                  emailAddress = value;
                },
                onPasswordChanged: (value) {
                  password = value;
                },
                screenText: 'Login',
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Login',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<LoginCubit>(context).loginUser(
                      emailAddress: emailAddress!,
                      password: password!,
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
                    'don\'t have an account?',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Register',
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
