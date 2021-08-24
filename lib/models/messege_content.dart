import 'package:flutter/cupertino.dart';

class MessegeContent {
  String messegeContent;
  MessegeContent(this.messegeContent);
  dynamic getContent() => this.messegeContent;
  MessegeContent.fromMap(String content) {
    messegeContent = content;
  }
  // static fromMap(String content) => messegeContent;
}

class TextContent extends MessegeContent {
  TextContent(String messegeContent) : super(messegeContent);
  @override
  String getContent() {
    return super.messegeContent;
  }
}

class ImageContent extends MessegeContent {
  ImageContent(String messegeContent) : super(messegeContent);

  @override
  Image getContent() {
    throw UnimplementedError();
  }
}

class VoiceContent extends MessegeContent {
  VoiceContent(String messegeContent) : super(messegeContent);

  /// @return voice
  @override
  getContent() {
    // TODO: implement getContent
    throw UnimplementedError();
  }
}

class DocumentContent extends MessegeContent {
  DocumentContent(String messegeContent) : super(messegeContent);

  /// @return document

  @override
  getContent() {
    // TODO: implement getContent
    throw UnimplementedError();
  }
}

class VideoContent extends MessegeContent {
  VideoContent(String messegeContent) : super(messegeContent);

  /// @return video

  @override
  getContent() {
    // TODO: implement getContent
    throw UnimplementedError();
  }
}
