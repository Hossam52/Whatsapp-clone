import 'package:flutter/material.dart';

class ChatImage extends StatelessWidget {
  const ChatImage(
      {Key key,
      //  @required this.radius,
      @required this.imageLink})
      : super(key: key);
  // final double radius;
  final String imageLink;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: CircleAvatar(
        backgroundImage: AssetImage(imageLink),
      ),
    );
  }
}
