import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappclone/model_view_controller/chats/cubits/conversation_cubit.dart';
import 'package:whatsappclone/model_view_controller/chats/states/all_chats_states.dart';
import 'package:whatsappclone/models/chat_model.dart';
import 'package:whatsappclone/screens/chats/chat_conversation.dart';
import 'package:whatsappclone/shared/firebase_database.dart';

const String currentUserId = '01115425564';

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
    final allChatsStream = FirebaseRealTime.instance.getAllChats(currentUserId);

    _chatsStream = allChatsStream.listen((event) {
      if (event.snapshot.exists) {
        final allChatsMap = Map<String, dynamic>.from(event.snapshot.value);
        _allChats = allChatsMap.values
            .map<ChatModel>(
                (chat) => ChatModel.fromMap(Map<String, dynamic>.from(chat)))
            .toList();
        _allChats = _allChats.reversed.toList();
      }
      emit(UpdateAllChatsState());
    });
  }

  void updateAllChatsView() {
    emit(UpdateLastConversationMessegeState());
  }

  Future<void> chatWithNewPerson(BuildContext context, String friendId) async {
    final chat = await FirebaseRealTime.instance.getChatContent(friendId);
    if (chat == null) {
      print('Can\'t find user');
      return;
    }
    if (chat.exists) {
      _chatExist(context, chat.value[friendId]);
    } else {
      _chatNotExist(context, friendId);
    }
  }

  void _chatExist(BuildContext context, data) {
    ChatModel chat = ChatModel.fromMap(Map<String, dynamic>.from(data));
    navigateToChatScreen(context, chat);
  }

  void _chatNotExist(BuildContext context, String friendId) {
    final chatId = FirebaseRealTime.instance.createChatKey();
    final chat = ChatModel(
        id: chatId,
        unReedMesseges: 0,
        chatImageLink: 'assets/images/person_image.jpg',
        chatName: friendId,
        friendId: friendId);
    navigateToChatScreen(context, chat);
  }

  void navigateToChatScreen(BuildContext context, ChatModel chatModel) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider<ConversationCubit>(
            create: (_) => ConversationCubit(chatModel),
            child: ChatConversationScreen(),
          ),
        ));
  }

  @override
  Future<void> close() {
    _chatsStream.cancel();
    return super.close();
  }
}
