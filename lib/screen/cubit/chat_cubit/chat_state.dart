part of 'chat_cubit.dart';

class ChatState {}

class ChatCubitInitial extends ChatState {}

class ChatSuccess extends ChatState {
  final List<MessageModel> messages;

  ChatSuccess({required this.messages});
}
