import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsappclone/model_view_controller/chats/cubits/conversation_cubit.dart';
import 'package:whatsappclone/widgets/media_content.dart';
import 'package:whatsappclone/widgets/notification_control_group.dart';
import 'package:whatsappclone/widgets/setting_option.dart';

class ConversationSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildProfilePictureAndName(context),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildMediaContent(),
                _buildNotificationOptions(),
                _buildPrivacySettings(),
                _buildAboutInformation(context),
                _buildConversationActions()
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildProfilePictureAndName(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final chatName = ConversationCubit.instance(context).getChatName;
    final imageLink = ConversationCubit.instance(context).getImageLink;
    return SliverAppBar(
      expandedHeight: height * 0.5,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(chatName),
        background: Image.asset(imageLink, fit: BoxFit.fill),
      ),
      pinned: true,
      actions: [_buildMoreActionsVertical()],
    );
  }

  Widget _buildMoreActionsVertical() {
    return IconButton(onPressed: () {}, icon: Icon(Icons.more_vert));
  }

  Widget _buildMediaContent() {
    return MediaContent();
  }

  Widget _buildNotificationOptions() {
    return NotificationControllGroup();
  }

  Widget _buildPrivacySettings() {
    return Column(
      children: [
        ConversationSettingOption(
          title: 'Disappearing messeges',
          onTap: () {},
          subTitle: 'Off',
          trailing: Icon(Icons.timer),
        ),
        ConversationSettingOption(
          title: 'Encryption',
          subTitle:
              'Messeges and calls are end-to-end encrypted. Tp to verify.',
          onTap: () {},
          trailing: Icon(Icons.lock),
        )
      ],
    );
  }

  Widget _buildAboutInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About and phone number',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Theme.of(context).primaryColor)),
        ConversationSettingOption(
          title: 'Available',
          onTap: () {},
          subTitle: 'June 1',
        ),
        ConversationSettingOption(
          title: '+201115425561',
          onTap: () {},
          subTitle: 'Mobile',
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.chat),
              Icon(Icons.call),
              Icon(Icons.video_camera_back)
            ],
          ),
        )
      ],
    );
  }

  Widget _buildConversationActions() {
    final style = TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
    return Column(children: [
      Card(
          child: ListTile(
        leading: Icon(Icons.no_accounts, color: Colors.red),
        title: Text('Block', style: style),
        onTap: () {},
      )),
      Card(
          child: ListTile(
        leading: Icon(Icons.not_accessible, color: Colors.red),
        title: Text('Report contact', style: style),
        onTap: () {},
      ))
    ]);
  }
}
