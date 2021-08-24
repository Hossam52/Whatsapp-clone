import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:whatsappclone/models/messege_content.dart';
import 'package:whatsappclone/utils/enums.dart';

class MessegeModel {
  MessegeModel({
    @required this.time,
    @required this.sendByMe,
    @required this.isForwarded,
    @required this.messegeType,
    @required this.content,
  });
  DateTime time;
  bool sendByMe;
  bool isForwarded;
  MessegeType messegeType;
  MessegeContent content;

  Map<String, dynamic> toMap() {
    return {
      'time': time.millisecondsSinceEpoch,
      'sendByMe': sendByMe,
      'isForwarded': isForwarded,
      'messegeType': messegeType.toString(),
      'content': content.getContent(),
    };
  }

  MessegeModel.fromMap(Map<String, dynamic> map) {
    time = DateTime.fromMillisecondsSinceEpoch(map['time']);
    sendByMe = map['sendByMe'];
    isForwarded = map['isForwarded'];
    messegeType = _getMessegeType(map['messegeType']);
    content = MessegeContent.fromMap(map['content']);
  }

  factory MessegeModel.sendMessege({
    @required bool isForwarded,
    @required MessegeType messegeType,
    @required MessegeContent content,
  }) {
    return MessegeModel(
        time: DateTime.now(),
        sendByMe: true,
        isForwarded: isForwarded,
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
}
