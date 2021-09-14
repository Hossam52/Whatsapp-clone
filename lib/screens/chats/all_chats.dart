import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappclone/model_view_controller/chats/cubits/all_chats_cubit.dart';
import 'package:whatsappclone/model_view_controller/chats/states/all_chats_states.dart';
import 'package:whatsappclone/models/messege_content.dart';
import 'package:whatsappclone/models/messege_model.dart';
import 'package:whatsappclone/models/user_model.dart';
import 'package:whatsappclone/shared/firebase_database.dart';
import 'package:whatsappclone/utils/enums.dart';

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
      floatingActionButton: _buildAddNewChat(context),
    );
  }

  Widget _buildAddNewChat(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      child: Icon(Icons.chat),
      onPressed: () {
        // FirebaseRealTime.instance.startChat(
        //     '01115425566',
        //     MessegeModel(
        //         time: DateTime.now(),
        //         sender: true,
        //         messegeType: MessegeType.text,
        //         content: TextContent('From new  chat')));
        // // FirebaseRealTime.instance.addNewUser(UserModel(
        // //     name: 'Fady Adoy',
        // //     lastSeen: DateTime.now(),
        // //     about: 'Thihs is about',
        // //     phone: '01115425564',
        // //     showRecievedInecator: true));
      },
    );
  }
}
