import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/screen/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widget/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.email});
  final String email;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<MessageModel> messagesList = [];

  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).getMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff696FDD),
        centerTitle: true,
        title: const Text('Chat', style: TextStyle(color: Colors.white)),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatSuccess) {
                    messagesList = state.messages;
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: messagesList.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      String id = messagesList[index].id;
                      return ChatBubble(
                        text: messagesList[index].message,
                        isMe: id == widget.email,
                      );
                    },
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (controller.text.trim().isNotEmpty) {
                        BlocProvider.of<ChatCubit>(context).sendMessage(
                          message: controller.text,
                          email: widget.email,
                        );
                      }
                      controller.clear();
                    },
                    icon: const Icon(Icons.send),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'sent a message',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
