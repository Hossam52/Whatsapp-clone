import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsappclone/screens/calls/calls_screen.dart';
import 'package:whatsappclone/widgets/chat_image.dart';

class StatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            _buildMyStatus(),
            _buildRecentStatus(),
            _buildViewedUpdates()
          ],
        )),
        floatingActionButton: _buildFABS(context));
  }

  Widget _buildFABS(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.edit, color: Theme.of(context).primaryColor),
          backgroundColor: Colors.white,
        ),
        SizedBox(height: 20),
        FloatingActionButton(
          backgroundColor: Colors.lightGreen,
          foregroundColor: Colors.white,
          child: Icon(Icons.camera_alt),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildMyStatus() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          ChatImage(imageLink: 'assets/images/person_image.jpg'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My status',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                Text('Tap to add status update',
                    style: TextStyle(fontSize: 16, color: Colors.grey))
              ],
            ),
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
        ],
      ),
    );
  }

  Widget _buildRecentStatus() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Recent Updates', style: TextStyle(fontSize: 18)),
          ),
        ),
        _StatusItem(
            personName: names[Random.secure().nextInt(names.length)],
            publishDateString: '44 minute',
            imageLink: 'assets/images/person_image.jpg'),
        _StatusItem(
            personName: names[Random.secure().nextInt(names.length)],
            publishDateString: '12 hours',
            imageLink: 'assets/images/person_image.jpg'),
      ],
    );
  }
}

Widget _buildViewedUpdates() {
  return Column(
    children: [
      Container(
        width: double.infinity,
        color: Colors.grey.shade300,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Viewed Updates', style: TextStyle(fontSize: 18)),
        ),
      ),
      _StatusItem(
          personName: names[Random.secure().nextInt(names.length)],
          publishDateString: 'Today, 08:44',
          imageLink: 'assets/images/person_image.jpg'),
      _StatusItem(
          personName: names[Random.secure().nextInt(names.length)],
          publishDateString: 'Today, 9:00 am',
          imageLink: 'assets/images/person_image.jpg'),
      _StatusItem(
          personName: names[Random.secure().nextInt(names.length)],
          publishDateString: '9 hours',
          imageLink: 'assets/images/person_image.jpg'),
    ],
  );
}

class _StatusItem extends StatelessWidget {
  const _StatusItem(
      {Key key,
      @required this.personName,
      @required this.publishDateString,
      @required this.imageLink})
      : super(key: key);

  final String personName;
  final String publishDateString;
  final String imageLink;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ChatImage(imageLink: imageLink),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(personName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Text(publishDateString,
                      style: TextStyle(fontSize: 19, color: Colors.grey))
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
