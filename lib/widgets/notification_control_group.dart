import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappclone/model_view_controller/chats/cubits/conversation_cubit.dart';
import 'package:whatsappclone/model_view_controller/chats/states/conversation_states.dart';
import 'package:whatsappclone/widgets/setting_option.dart';

class NotificationControllGroup extends StatelessWidget {
  const NotificationControllGroup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMuteNotificationOption(context),
          _buildCustomNotificationOption(context),
          _buildMediaVisiblity(context)
        ],
      ),
    );
  }

  Widget _buildMuteNotificationOption(BuildContext context) {
    final cubit = ConversationCubit.instance(context);
    return BlocBuilder<ConversationCubit, ConversationStates>(
      buildWhen: (_, newState) {
        if (newState is UpdateNotificationStatusState) return true;
        return false;
      },
      builder: (_, state) => ConversationSettingOption(
        onTap: () {},
        title: 'Mute notifications',
        trailing: Switch(
          value: cubit.muteNotification,
          onChanged: cubit.changeMuteNotificationOption,
        ),
      ),
    );
  }

  Widget _buildCustomNotificationOption(BuildContext context) {
    return ConversationSettingOption(
      onTap: () {},
      title: 'Custom Notification',
    );
  }

  Widget _buildMediaVisiblity(BuildContext context) {
    return ConversationSettingOption(
      onTap: () {},
      title: 'Media Visiblity',
    );
  }
}
