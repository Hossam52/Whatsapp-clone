import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsappclone/models/messege_content.dart';
import 'package:whatsappclone/models/messege_model.dart';
import 'package:whatsappclone/utils/enums.dart';
import 'package:whatsappclone/utils/helpers/essential_chat_data_model.dart';

class ChatModel extends EssentialChatData {
  List<MessegeModel> messeges;
  int unReedMesseges;
  ChatModel(
      {@required this.messeges,
      @required this.unReedMesseges,
      @required chatImageLink,
      @required chatName})
      : super(chatName, chatImageLink);

  MessegeModel getLastMessege() {
    if (messeges.isNotEmpty) return messeges.last;
    return null;
  }
}

List<ChatModel> allChatsDummyData = [
  for (int i = 0; i < 10; i++)
    ChatModel(
      messeges: [
        for (int j = 0; j <= Random.secure().nextInt(100); j++)
          MessegeModel(
              time: DateTime.now(),
              sendByMe: Random.secure().nextInt(2) == 0,
              isForwarded: Random.secure().nextInt(2) == 0,
              messegeType: MessegeType.text,
              content: TextContent(
                  _chatStrings[Random.secure().nextInt(_chatStrings.length)])),
        // MessegeModel(
        //     time: DateTime.now()
        //         .add(Duration(hours: Random.secure().nextInt(100))),
        //     sendByMe: true,
        //     isForwarded: false,
        //     messegeType: MessegeType.text,
        //     content: TextContent(
        //         _chatStrings[Random.secure().nextInt(_chatStrings.length)])),
        // MessegeModel(
        //     time: DateTime.now()
        //         .add(Duration(hours: Random.secure().nextInt(100))),
        //     sendByMe: false,
        //     isForwarded: false,
        //     messegeType: MessegeType.text,
        //     content: TextContent(
        //         _chatStrings[Random.secure().nextInt(_chatStrings.length)])),
        //   MessegeModel(
        //       time: DateTime.now()
        //           .add(Duration(hours: Random.secure().nextInt(100))),
        //       sendByMe: false,
        //       isForwarded: false,
        //       messegeType: MessegeType.text,
        //       content: TextContent(
        //           _chatStrings[Random.secure().nextInt(_chatStrings.length)])),
        //   MessegeModel(
        //       time: DateTime.now()
        //           .add(Duration(hours: Random.secure().nextInt(100))),
        //       sendByMe: true,
        //       isForwarded: true,
        //       messegeType: MessegeType.text,
        //       content: TextContent(
        //           _chatStrings[Random.secure().nextInt(_chatStrings.length)])),
        //   MessegeModel(
        //       time: DateTime.now()
        //           .add(Duration(hours: Random.secure().nextInt(100))),
        //       sendByMe: true,
        //       isForwarded: false,
        //       messegeType: MessegeType.text,
        //       content: TextContent(
        //           _chatStrings[Random.secure().nextInt(_chatStrings.length)])),
        //   MessegeModel(
        //       time: DateTime.now()
        //           .add(Duration(hours: Random.secure().nextInt(100))),
        //       sendByMe: false,
        //       isForwarded: false,
        //       messegeType: MessegeType.text,
        //       content: TextContent(
        //           _chatStrings[Random.secure().nextInt(_chatStrings.length)])),
        //   MessegeModel(
        //       time: DateTime.now()
        //           .add(Duration(hours: Random.secure().nextInt(100))),
        //       sendByMe: false,
        //       isForwarded: false,
        //       messegeType: MessegeType.text,
        //       content: TextContent(
        //           _chatStrings[Random.secure().nextInt(_chatStrings.length)])),
        //   MessegeModel(
        //       time: DateTime.now()
        //           .add(Duration(hours: Random.secure().nextInt(100))),
        //       sendByMe: false,
        //       isForwarded: false,
        //       messegeType: MessegeType.text,
        //       content: TextContent(
        //           _chatStrings[Random.secure().nextInt(_chatStrings.length)])),
        //   MessegeModel(
        //       time: DateTime.now()
        //           .add(Duration(hours: Random.secure().nextInt(100))),
        //       sendByMe: false,
        //       isForwarded: false,
        //       messegeType: MessegeType.text,
        //       content: TextContent(
        //           _chatStrings[Random.secure().nextInt(_chatStrings.length)])),
        //   MessegeModel(
        //       time: DateTime.now()
        //           .subtract(Duration(hours: Random.secure().nextInt(100))),
        //       sendByMe: false,
        //       isForwarded: false,
        //       messegeType: MessegeType.text,
        //       content: TextContent(
        //           _chatStrings[Random.secure().nextInt(_chatStrings.length)])),
        // ],
      ],
      unReedMesseges: Random.secure().nextInt(10),
      chatImageLink: 'assets/images/person_image.jpg',
      chatName: _names[Random.secure().nextInt(_names.length)],
    ),
];

List<String> _chatStrings = [
  'This is first messege from me',
  'How are you today babe',
  'I watch the match today and it is very exceited',
  'I love my firnds',
  'This is by mistake',
  'What a problem to solve',
  'My cat named za8lol',
  'Hossam',
  'Ahmed Ashraf',
  'Samy Fathy',
  'Google cloud functions',
  'What a wonderfull life',
  'I wish to be a doctor',
  'Good to hear about that',
  'My brother slept on the sofa',
  'My widding party is tommorow'
];

List<String> _names = [
  'Hossam Hassan',
  'Ahmed Ashraf',
  'Khaled ayman',
  'Fady El sayed',
  'Yousry',
  'El khamry',
  'Shobokshy',
  'Doksh',
  'FCIS',
  'Good Father',
  'Good Mother',
  'Whatsapp',
  'Eslam hassan',
  'Zaghlol'
];
