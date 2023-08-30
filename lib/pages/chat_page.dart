import 'package:chat_app/components/constants.dart';
import 'package:chat_app/components/custom_messag_bubble.dart';
import 'package:chat_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/message_model.dart';

class ChatPage extends StatelessWidget {
  static String id = 'chat page';
  List<Message> messagesList = [];
  final _controller = ScrollController();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    // stream: messages.orderBy(kMessageCreatedAt, descending: true).snapshots(),
    // builder: (context, snapshot) {
    //   if (snapshot.hasData) {
    //     List<Message> messagesList = [];
    //     for (int i = 0; i < snapshot.data!.docs.length; i++) {
    //       messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
    //     }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(klogo, height: 50),
            const Text(' chat'),
          ],
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccessState) {
                  messagesList = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].idAsEmail == email
                        ? CustomMessageBubble(message: messagesList[index])
                        : CustomMessageBubbleFromOthers(
                            message: messagesList[index]);
                  },
                );
              },
            ),
          ),
          MessageBar(
            onSend: (data) {
              BlocProvider.of<ChatCubit>(context)
                  .sendMessage(massage: data, email: email);
              // messages.add({
              //   kMessageInDocs: data,
              //   kMessageCreatedAt: DateTime.now(),
              //   'id': email,
              // });
              _controller.animateTo(0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.bounceOut);
            },
            sendButtonColor: kPrimaryColor,
          ),
        ],
      ),
    );
    // } else {
    //   // return const Text(
    //   //   'Loading....',
    //   //   style: TextStyle(
    //   //     fontWeight: FontWeight.bold,
    //   //     color: kPrimaryColor,
    //   //     fontSize: 50,
    //   //   ),
    //   // );
    //   return const Scaffold(
    //       body: Center(child: CircularProgressIndicator()));
    // }
  }
}
