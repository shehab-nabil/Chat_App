import '../components/constants.dart';

class Message{
  final String messageContent;
  final String idAsEmail;
  Message(this.messageContent, this.idAsEmail);
  factory Message.fromJson(jsonData){
    return Message(jsonData[kMessageInDocs],jsonData['id']);
  }
}