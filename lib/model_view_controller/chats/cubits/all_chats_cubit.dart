import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappclone/model_view_controller/chats/states/all_chats_states.dart';
import 'package:whatsappclone/models/chat_model.dart';
import 'package:whatsappclone/shared/firebase_database.dart';

class AllChatsCubit extends Cubit<AllChatsStates> {
  AllChatsCubit() : super(IntialAllChatsState()) {
    _listenAllChats();
  }
  static AllChatsCubit instance(BuildContext context) =>
      BlocProvider.of<AllChatsCubit>(context);

  List<ChatModel> _allChats = [];
  StreamSubscription<Event> _chatsStream;

  List<ChatModel> get getAllChats => List.from(_allChats);

  void _listenAllChats() {
    final allChatsStream = FirebaseRealTime.instance.getAllChats('uid1');

    _chatsStream = allChatsStream.listen((event) {
      final allChatsMap = Map<String, dynamic>.from(event.snapshot.value);
      _allChats = allChatsMap.values
          .map<ChatModel>(
              (chat) => ChatModel.fromMap(Map<String, dynamic>.from(chat)))
          .toList();
      emit(UpdateAllChatsState());
    });
  }

  void updateAllChatsView() {
    emit(UpdateLastConversationMessegeState());
  }

  @override
  Future<void> close() {
    _chatsStream.cancel();
    return super.close();
  }
}
