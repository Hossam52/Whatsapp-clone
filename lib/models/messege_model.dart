import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:whatsappclone/models/messege_content.dart';
import 'package:whatsappclone/utils/enums.dart';

class MessegeModel {
  MessegeModel({
    @required this.time,
    @required this.sender,
    this.forwarded = false,
    @required this.messegeType,
    @required this.content,
  });
  DateTime time;
  bool sender;
  bool forwarded;
  MessegeType messegeType;
  MessegeContent content;

  Map<String, dynamic> toMap() {
    return {
      'time': time.millisecondsSinceEpoch,
      'sender': 'uid1',
      'forwarded': forwarded,
      'messegeType': messegeType.toString(),
      'content': content.getContent(),
    };
  }

  MessegeModel.fromMap(Map<String, dynamic> map) {
    time = DateTime.fromMillisecondsSinceEpoch(map['time']);
    sender = _senderIsMe(map['sender']);
    forwarded = map['forwarded'];
    messegeType = _getMessegeType(map['messegeType']);
    content = MessegeContent.fromMap(map['content']);
  }

  factory MessegeModel.sendMessege({
    @required bool forwarded,
    @required MessegeType messegeType,
    @required MessegeContent content,
  }) {
    return MessegeModel(
        time: DateTime.now(),
        sender: true,
        forwarded: forwarded,
        messegeType: messegeType,
        content: content);
  }
  MessegeType _getMessegeType(String messegeTypeString) {
    if (messegeTypeString == MessegeType.text.toString())
      return MessegeType.text;
    if (messegeTypeString == MessegeType.image.toString())
      return MessegeType.image;
    if (messegeTypeString == MessegeType.document.toString())
      return MessegeType.document;
    if (messegeTypeString == MessegeType.video.toString())
      return MessegeType.video;
    if (messegeTypeString == MessegeType.voice.toString())
      return MessegeType.voice;
    else
      return MessegeType.text;
  }

  bool _senderIsMe(String senderId) {
    final String myId = 'uid1';
    if (senderId == myId)
      return true;
    else
      return false;
  }
}
