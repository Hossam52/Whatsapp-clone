import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappclone/model_view_controller/chats/states/conversation_states.dart';
import 'package:whatsappclone/models/chat_model.dart';
import 'package:whatsappclone/models/messege_content.dart';
import 'package:whatsappclone/models/messege_model.dart';
import 'package:whatsappclone/shared/firebase_database.dart';
import 'package:whatsappclone/utils/enums.dart';

class ConversationCubit extends Cubit<ConversationStates> {
  ConversationCubit(
    this._chatData,
  ) : super(IntialConversationState()) {
    print(_chatData.friendId);
    _listenToMesseges();
  }
  static ConversationCubit instance(BuildContext context) =>
      BlocProvider.of<ConversationCubit>(context);

  final ChatModel _chatData;
  bool _muteNotification = false;
  StreamSubscription<Event> _chatMessegesStream;
  List<MessegeModel> _messeges;

  List<MessegeModel> get getMesseges =>
      _messeges == null ? _messeges : List.from(_messeges);

  String get getImageLink => _chatData.chatImageLink;

  String get getChatName => _chatData.friendId;

  bool get muteNotification => _muteNotification;

  void _listenToMesseges() {
    final chatMessegesStream =
        FirebaseRealTime.instance.getAllChatMessages(_chatData.id);

    _chatMessegesStream = chatMessegesStream.listen((event) async {
      final allMesseges = Map<String, dynamic>.from(event.snapshot.value);
      _messeges = allMesseges.values
          .map((messege) =>
              MessegeModel.fromMap(Map<String, dynamic>.from(messege)))
          .toList();

      emit(MessegesChangedState());
    });
  }

  void sendMessege(bool isForwarded, MessegeContent content) {
    FirebaseRealTime.instance.sendMessege(
        _chatData.id,
        MessegeModel(
            time: DateTime.now(),
            sender: true,
            messegeType: MessegeType.text,
            content: content));
  }

  void changeMuteNotificationOption(bool isMuted) {
    _muteNotification = isMuted;
    emit(UpdateNotificationStatusState());
  }

  @override
  Future<void> close() {
    _chatMessegesStream.cancel();
    return super.close();
  }
}
