import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappclone/model_view_controller/chats/cubits/all_chats_cubit.dart';
import 'package:whatsappclone/model_view_controller/chats/states/all_chats_states.dart';
import 'package:whatsappclone/widgets/custom_text_field.dart';

import 'package:whatsappclone/screens/chats/widgets/header_chat.dart';
import 'package:whatsappclone/widgets/default_button.dart';

class AllChatsScreen extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  String enteredUserId = '';
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
        showModalBottomSheet(
            context: context, builder: (_) => _buildModalSheetContent(context));
      },
    );
  }

  Widget _buildModalSheetContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              validator: _validateInput,
              hintText: 'UserName',
              onSaved: _onSaved,
            ),
            DefaultButton(
                content: 'Start chatting',
                onPressed: () async {
                  _key.currentState.save();
                  if (_key.currentState.validate()) {
                    await AllChatsCubit.instance(context)
                        .chatWithNewPerson(context, enteredUserId);
                  } else
                    print('False');
                })
          ],
        ),
      ),
    );
  }

  String _validateInput(String text) {
    if (text == null || text.isEmpty) return 'This field can\'t be empty';
    return null;
  }

  void _onSaved(String enteredInput) {
    print(enteredInput);
    enteredUserId = enteredInput;
  }
}
