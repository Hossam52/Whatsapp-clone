import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsappclone/config/colors.dart';
import 'package:whatsappclone/models/messege_model.dart';

class MessegeView extends StatelessWidget {
  const MessegeView({Key key, @required this.messege}) : super(key: key);

  final MessegeModel messege;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Bubble(
          alignment: _getMessegeAlignment(),
          nip: _getBubbleNip(),
          color: _getMessegeBackgroundColor(),
          child: _messegeContentAndTime(context),
        ));
  }

  Color _getMessegeBackgroundColor() {
    if (messege.sender)
      return messegeBackgroundColorIfSenderMe;
    else
      return messegeBackgroundColorIfSenderOthers;
  }

  BubbleNip _getBubbleNip() {
    if (messege.sender)
      return BubbleNip.rightTop;
    else
      return BubbleNip.leftTop;
  }

  Alignment _getMessegeAlignment() {
    if (messege.sender)
      return Alignment.topRight;
    else
      return Alignment.topLeft;
  }

  Widget _messegeContentAndTime(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(messege.content.getContent(),
            style: Theme.of(context).textTheme.bodyText1),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DateFormat('hh:mm a').format(messege.time),
            ),
            Icon(Icons.delivery_dining_sharp),
          ],
        )
      ],
    );
  }
}
