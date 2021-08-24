import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappclone/model_view_controller/chats/states/conversation_states.dart';
import 'package:whatsappclone/models/chat_model.dart';
import 'package:whatsappclone/models/messege_content.dart';
import 'package:whatsappclone/models/messege_model.dart';
import 'package:whatsappclone/utils/enums.dart';

class ConversationCubit extends Cubit<ConversationStates> {
  ConversationCubit(this._chatData) : super(IntialConversationState());
  static ConversationCubit instance(BuildContext context) =>
      BlocProvider.of<ConversationCubit>(context);
  final ChatModel _chatData;
  bool _muteNotification = false;

  List<MessegeModel> get getMesseges => List.from(_chatData.messeges);

  String get getImageLink => _chatData.chatImageLink;

  String get getChatName => _chatData.chatName;

  void sendMessege(bool isForwarded, MessegeContent content) {
    _chatData.messeges.add(MessegeModel.sendMessege(
        isForwarded: true, messegeType: MessegeType.text, content: content));
    emit(IntialConversationState());
  }

  void changeMuteNotificationOption(bool isMuted) {
    _muteNotification = isMuted;
    emit(UpdateNotificationStatusState());
  }

  bool get muteNotification => _muteNotification;
}
