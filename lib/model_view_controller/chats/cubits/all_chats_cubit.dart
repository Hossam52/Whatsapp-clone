import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappclone/model_view_controller/chats/states/all_chats_states.dart';
import 'package:whatsappclone/models/chat_model.dart';

class AllChatsCubit extends Cubit<AllChatsStates> {
  AllChatsCubit() : super(IntialAllChatsState()) {
    _loadAllChats();
  }
  static AllChatsCubit instance(BuildContext context) =>
      BlocProvider.of<AllChatsCubit>(context);

  List<ChatModel> _allChats = [];

  void _loadAllChats() {
    _allChats = List.from(allChatsDummyData);
  }

  void updateAllChatsView() {
    emit(UpdateLastConversationMessegeState());
  }

  List<ChatModel> get getAllChats => List.from(_allChats);
}
