import 'package:flutter/material.dart';

class ChatImage extends StatelessWidget {
  const ChatImage({Key key, @required this.imageLink, this.radius = 25})
      : super(key: key);
  final String imageLink;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: CircleAvatar(
        radius: radius,
        backgroundImage: AssetImage(imageLink),
      ),
    );
  }
}
