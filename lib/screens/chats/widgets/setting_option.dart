import 'package:flutter/material.dart';

class ConversationSettingOption extends StatelessWidget {
  const ConversationSettingOption({
    Key key,
    @required this.title,
    @required this.onTap,
    this.trailing,
    this.subTitle,
  }) : super(key: key);
  final String title;
  final VoidCallback onTap;
  final Widget trailing;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText1;
    return Column(
      children: [
        ListTile(
          title: Text(title, style: style),
          trailing: trailing,
          onTap: onTap,
          subtitle: subTitle == null ? null : Text(subTitle),
        ),
        Divider()
      ],
    );
  }
}
