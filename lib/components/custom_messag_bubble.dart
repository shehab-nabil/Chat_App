import 'package:chat_app/models/message_model.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class CustomMessageBubble extends StatelessWidget {
  const CustomMessageBubble({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return BubbleNormal(
      text: message.messageContent,
      color: kPrimaryColor,
      tail: true,
      textStyle: const TextStyle(color: Colors.white, fontSize: 19),
    );
  }
}

class CustomMessageBubbleFromOthers extends StatelessWidget {
  const CustomMessageBubbleFromOthers({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return BubbleNormal(
      text: message.messageContent,
      color: kSecondaryColor,
      tail: true,
      textStyle: const TextStyle(color: Colors.white, fontSize: 19),
      isSender: false,
    );
  }
}
