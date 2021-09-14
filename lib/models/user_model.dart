import 'package:flutter/material.dart';

class UserModel {
  String name;
  DateTime lastSeen;
  String about;
  String phone;
  bool showRecievedInecator;
  UserModel({
    @required this.name,
    @required this.lastSeen,
    @required this.about,
    @required this.phone,
    @required this.showRecievedInecator,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'last_seen': DateTime.now().millisecondsSinceEpoch,
      'about': about,
      'phone': phone,
      'show_recieved_indecator': showRecievedInecator,
      'chats': {},
      'groups': {}
    };
  }
}
