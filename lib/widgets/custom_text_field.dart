import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {Key key, @required this.hintText, this.validator, this.onSaved})
      : super(key: key);
  final String hintText;
  final String Function(String) validator;
  final void Function(String) onSaved;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      validator: widget.validator,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
          hintText: widget.hintText, border: OutlineInputBorder()),
    );
  }
}
