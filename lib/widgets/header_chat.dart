import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whatsappclone/model_view_controller/chats/cubits/all_chats_cubit.dart';
import 'package:whatsappclone/model_view_controller/chats/cubits/conversation_cubit.dart';
import 'package:whatsappclone/models/chat_model.dart';
import 'package:whatsappclone/screens/chats/chat_conversation.dart';
import 'package:whatsappclone/widgets/chat_image.dart';

class HeaderChat extends StatelessWidget {
  const HeaderChat({Key key, @required this.chatModel}) : super(key: key);
  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider<ConversationCubit>(
              create: (_) => ConversationCubit(chatModel),
              child: ChatConversationScreen(),
            ),
          ),
        );
      },
      child: Row(
        children: [
          Expanded(child: ChatImage(imageLink: chatModel.chatImageLink)),
          Expanded(flex: 6, child: _buildMainHeaderContent(context)),
        ],
      ),
    );
  }

  Widget _buildMainHeaderContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildChatNameAndTime(context),
          _buildMessegeAndUnRead(context)
        ],
      ),
    );
  }

  Widget _buildChatNameAndTime(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 4, child: _buildChatName(context)),
        Expanded(child: FittedBox(child: _buildTime()))
      ],
    );
  }

  Widget _buildChatName(BuildContext context) {
    return Text(
      chatModel.chatName,
      style: Theme.of(context)
          .textTheme
          .headline5
          .copyWith(fontWeight: FontWeight.bold),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildTime() {
    String timeToDisplay = '';
    DateTime lastMessegeTime = chatModel.getLastMessege().time;
    // if (lastMessegeTime.isBefore(DateTime.now() .subtract(Duration(days: 1))))
    //   timeToDisplay = DateFormat('dd/MM').format(lastMessegeTime);
    // else if (lastMessegeTime.isBefore(DateTime.now()))
    //   timeToDisplay = 'Yasterday';
    // else
    timeToDisplay = DateFormat('hh:mm a').format(lastMessegeTime);
    final bool hasUnread = chatModel.unReedMesseges != 0;
    return Text(timeToDisplay,
        style: TextStyle(color: hasUnread ? Colors.green : null));
  }

  Widget _buildMessegeAndUnRead(BuildContext context) {
    if (chatModel.unReedMesseges == 0) return _buildMessegeContent(context);
    return Row(
      children: [
        Expanded(flex: 13, child: _buildMessegeContent(context)),
        Expanded(child: _buildUnReedIndecator())
      ],
    );
  }

  Widget _buildUnReedIndecator() {
    return CircleAvatar(
        child: Text('${chatModel.unReedMesseges}',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green);
  }

  Widget _buildMessegeContent(BuildContext context) {
    return Text(chatModel.getLastMessege().content.getContent(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style:
            Theme.of(context).textTheme.headline6.copyWith(color: Colors.grey));
  }
}
