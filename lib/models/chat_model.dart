import 'package:flutter/material.dart';
import 'package:whatsappclone/models/messege_model.dart';
import 'package:whatsappclone/utils/helpers/essential_chat_data_model.dart';

class ChatModel extends EssentialChatData {
  ChatModel(
      {@required this.id,
      @required this.lastMessege,
      @required this.unReedMesseges,
      @required chatImageLink,
      @required String chatName,
      @required this.friendId})
      : super(id, chatName, chatImageLink);

  factory ChatModel.fromMap(Map<String, dynamic> chatData) {
    return ChatModel(
        id: chatData['id'],
        lastMessege: MessegeModel.fromMap(Map.from(chatData['last_messege'])),
        unReedMesseges: chatData['un_read_messeges'],
        chatImageLink: chatData['chat_image'],
        chatName: chatData['chat_name'],
        friendId: chatData['friend_id']);
  }
  int unReedMesseges;
  MessegeModel lastMessege;
  String id;
  String friendId;

  MessegeModel getLastMessege() {
    // if (messeges.isNotEmpty) return messeges.last;
    // return null;
    return lastMessege;
  }
}
