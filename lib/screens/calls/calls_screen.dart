import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsappclone/widgets/chat_image.dart';

class CallsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final random = Random.secure();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < 10; i++)
              _CallItem(
                imagePath: 'assets/images/person_image.jpg',
                time: DateFormat('yy/MM/dd').format(DateTime.now()
                    .subtract(Duration(days: random.nextInt(200)))),
                callStatus: random.nextInt(2) == 0
                    ? Icons.call_made
                    : Icons.call_received,
                callType: random.nextInt(2) == 0 ? Icons.call : Icons.videocam,
                name: names[random.nextInt(names.length)],
                callColor: random.nextBool() ? Colors.green : Colors.red,
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.greenAccent.shade400,
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.add_call),
        ),
      ),
    );
  }
}

class _CallItem extends StatelessWidget {
  const _CallItem(
      {Key key,
      @required this.imagePath,
      @required this.time,
      @required this.callStatus,
      @required this.callType,
      @required this.name,
      @required this.callColor})
      : super(key: key);
  final String name;
  final String imagePath;
  final String time;
  final IconData callStatus;
  final IconData callType;
  final Color callColor;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ChatImage(
        imageLink: imagePath,
      ),
      title: Text(name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21)),
      subtitle: Row(children: [
        Icon(callStatus, color: callColor),
        Text(time),
      ]),
      trailing: IconButton(
        icon: Icon(callType),
        color: Theme.of(context).primaryColor,
        onPressed: () {},
      ),
    );
  }
}

final List<String> names = [
  'Hossam Hassan',
  'Ahmed Sayed',
  'Shabrawy',
  'Sayed',
  'Sika',
  'My Love',
  'Heart',
  'Love',
  'Doaa'
];
