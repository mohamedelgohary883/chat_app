import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.text, required this.isMe});

  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,

      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

          decoration: BoxDecoration(
            color: isMe ? const Color(0xff696FDD) : Colors.indigo,

            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),

              bottomLeft: isMe
                  ? const Radius.circular(20)
                  : const Radius.circular(5),

              bottomRight: isMe
                  ? const Radius.circular(5)
                  : const Radius.circular(20),
            ),
          ),

          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
