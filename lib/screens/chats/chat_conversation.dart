import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappclone/model_view_controller/chats/cubits/all_chats_cubit.dart';
import 'package:whatsappclone/model_view_controller/chats/cubits/conversation_cubit.dart';
import 'package:whatsappclone/model_view_controller/chats/states/conversation_states.dart';
import 'package:whatsappclone/models/messege_content.dart';
import 'package:whatsappclone/models/messege_model.dart';
import 'package:whatsappclone/screens/chats/conversation_settings.dart';
import 'package:whatsappclone/widgets/chat_image.dart';
import 'package:whatsappclone/widgets/loading_indecator.dart';
import 'package:whatsappclone/widgets/messege_view.dart';

class ChatConversationScreen extends StatefulWidget {
  ChatConversationScreen({Key key}) : super(key: key);

  @override
  _ChatConversationScreenState createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _firstAutoScrollExecuted = false;
  bool _shouldAutoScroll = false;

  String _previousSavedText = '';
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void _scrollListener() {
    _firstAutoScrollExecuted = true;
    if (_scrollController.hasClients &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent)
      _shouldAutoScroll = true;
    else
      _shouldAutoScroll = false;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: _buildUserPhotoAndName(),
          actions: _coversationActions(),
        ),
        body: Column(
          children: [
            Expanded(child: _displayChatMesseges(context)),
            _buildInputField(context),
          ],
        ));
  }

  Widget _buildUserPhotoAndName() {
    final chatName = ConversationCubit.instance(context).getChatName;
    final imageLink = ConversationCubit.instance(context).getImageLink;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BlocProvider<ConversationCubit>.value(
                    value: ConversationCubit.instance(context),
                    child: ConversationSettings())));
      },
      child: Row(
        children: [
          ChatImage(imageLink: imageLink),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text(chatName, style: TextStyle(fontWeight: FontWeight.bold)),
          ))
        ],
      ),
    );
  }

  List<Widget> _coversationActions() {
    return [
      IconButton(onPressed: () {}, icon: Icon(Icons.video_call_sharp)),
      IconButton(onPressed: () {}, icon: Icon(Icons.call)),
      IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
    ];
  }

  Widget _displayChatMesseges(context) {
    return BlocBuilder<ConversationCubit, ConversationStates>(
        builder: (_, state) {
      final messeges = ConversationCubit.instance(context).getMesseges;
      if (messeges == null) return LoadingIndecator();
      return Align(
        alignment: Alignment.bottomCenter,
        child: ListView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: messeges.length,
            itemBuilder: (_, index) {
              return MessegeView(messege: messeges[index]);
            }),
      );
    });
  }

  Widget _buildInputField(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 6, child: _buildTextField()),
        Expanded(
          child: _buildVoiceOrSendButton(context),
        )
      ],
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          TextFormField(
            onChanged: (text) {
              if (text.isEmpty && _previousSavedText.isNotEmpty)
                setState(() {
                  _previousSavedText = '';
                });
              else if (text.isNotEmpty && _previousSavedText.isEmpty)
                setState(() {
                  _previousSavedText = text;
                });
            },
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Type a messege ...',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.white,
              // suffixIcon: _buildCameraAndDocumentSelection(),
              // prefixIcon: IconButton(
              //   onPressed: () {},
              //   icon: Icon(Icons.emoji_emotions),
              // ),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: _buildCameraAndDocumentSelection())
        ],
      ),
    );
  }

  Widget _buildVoiceOrSendButton(BuildContext context) {
    final bool showSendButton = _textEditingController.text.isNotEmpty;
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      child: showSendButton ? _buildSendButton() : _buildVoiceButton(),
    );
  }

  Widget _buildSendButton() {
    return IconButton(
      onPressed: () {
        ConversationCubit.instance(context)
            .sendMessege(false, TextContent(_textEditingController.text));
        setState(() {
          _scrollToBottom();
          _textEditingController.clear();
        });
      },
      icon: Icon(Icons.send, color: Colors.white),
    );
  }

  Widget _buildVoiceButton() {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.mic, color: Colors.white),
    );
  }

  Widget _buildCameraAndDocumentSelection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _attachFiles(),
          _cameraWidget(),
        ],
      ),
    );
  }

  Widget _cameraWidget() {
    return IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt));
  }

  Widget _attachFiles() {
    return IconButton(onPressed: () {}, icon: Icon(Icons.attach_file));
  }
}
