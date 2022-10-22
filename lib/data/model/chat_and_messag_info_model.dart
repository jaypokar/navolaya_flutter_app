import 'chat_messages_model.dart';
import 'chat_model.dart';

/// chatInfo : {"_id":"630cda33fd1487eddb62d3f7","last_message":"hii","last_message_time":"2022-08-29T15:25:53.024Z","chat_status":1,"user":{"_id":"62e5627fe52ba8e753a0b3a8","full_name":"Max Riley","user_image":{"filepath":"dev/user-images/abc.jpg","fileurl":"https://navolaya.s3.ap-south-1.amazonaws.com/local/user-images/abc.jpg","thumbpath":"dev/user-images/thumbabc.jpg","thumburl":"https://navolaya.s3.ap-south-1.amazonaws.com/local/user-images/thumbabc.jpg"}}}
/// messageInfo : {"_id":null,"message_text":"hii","message_time":"2022-08-29T15:25:53.024Z","direction":"left"}

class ChatAndMessageInfoModel {
  ChatAndMessageInfoModel({
    Chat? chat,
    ChatMessages? chatMessages,
  }) {
    _chat = chat;
    _chatMessages = chatMessages;
  }

  ChatAndMessageInfoModel.fromJson(dynamic json) {
    _chat = json['chatInfo'] != null ? Chat.fromJson(json['chatInfo']) : null;
    _chatMessages = json['messageInfo'] != null ? ChatMessages.fromJson(json['messageInfo']) : null;
  }

  Chat? _chat;
  ChatMessages? _chatMessages;

  Chat? get chat => _chat;

  ChatMessages? get chatMessages => _chatMessages;
}
