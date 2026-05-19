import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatCubitInitial());
  final CollectionReference messages = FirebaseFirestore.instance.collection(
    kCollectionMessage,
  );
  void sendMessage({required String message, required String email}) {
    messages.add({
      'messages': message,
      'createdAt': DateTime.now(),
      'id': email,
    });
  }

  void getMessage() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      List<MessageModel> messageList = [];
      for (var docs in event.docs) {
        messageList.add(MessageModel.fromJson(docs));
      }
      emit(ChatSuccess(messages: messageList));
    });
  }
}
