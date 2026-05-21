import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screen/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/screen/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/screen/login_screen.dart';
import 'package:chat_app/simple_bloc_observe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = SimpleBlocObserve();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ChatCubit()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
