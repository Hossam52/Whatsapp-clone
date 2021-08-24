import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappclone/model_view_controller/chats/cubits/all_chats_cubit.dart';
import 'package:whatsappclone/model_view_controller/chats/states/all_chats_states.dart';

import 'package:whatsappclone/widgets/header_chat.dart';

class AllChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AllChatsCubit, AllChatsStates>(
          builder: (_, state) {
            final allChats = AllChatsCubit.instance(context).getAllChats;
            return ListView.builder(
              itemCount: allChats.length,
              itemBuilder: (_, index) => HeaderChat(
                chatModel: allChats[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
