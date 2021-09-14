import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key key, @required this.content, @required this.onPressed})
      : super(key: key);
  final String content;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(content),
      style: ButtonStyle(
          backgroundColor: getProperty(Theme.of(context).primaryColor),
          textStyle: getProperty(Theme.of(context).primaryTextTheme.headline5)),
    );
  }

  MaterialStateProperty<T> getProperty<T>(T property) {
    return MaterialStateProperty.all(property);
  }
}
