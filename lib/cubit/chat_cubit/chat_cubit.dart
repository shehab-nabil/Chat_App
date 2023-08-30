import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../components/constants.dart';
import '../../models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  void sendMessage({required String massage, required var email}) {
    try {
      messages.add({
        kMessageInDocs: massage,
        kMessageCreatedAt: DateTime.now(),
        'id': email,
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  void receiveMessage() {
    messages
        .orderBy(kMessageCreatedAt, descending: true)
        .snapshots()
        .listen((event) {
      List<Message> messagesList = [];
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }

      emit(ChatSuccessState(messages: messagesList));
    });
  }
}
