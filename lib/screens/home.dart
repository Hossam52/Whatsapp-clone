import 'package:flutter/material.dart';
import 'package:whatsappclone/screens/calls/calls_screen.dart';
import 'package:whatsappclone/screens/chats/all_chats.dart';
import 'package:whatsappclone/screens/statuses/status_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen() {
    pages.add(_TabBarItem(header: Icon(Icons.camera_alt), page: Container()));
    pages.add(_TabBarItem(header: Text('CHATS'), page: AllChatsScreen()));
    pages.add(_TabBarItem(header: Text('STATUS'), page: StatusScreen()));
    pages.add(_TabBarItem(header: Text('CALLS'), page: CallsScreen()));
  }
  final List<_TabBarItem> pages = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: pages.length,
      child: Scaffold(
          appBar: AppBar(
            title: Text('WhatsApp'),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
            ],
            bottom: TabBar(
              labelPadding: const EdgeInsets.all(8),
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: pages.map((e) => e.header).toList(),
            ),
          ),
          body: TabBarView(
            children: pages.map((e) => e.page).toList(),
          )),
    );
  }
}

class _TabBarItem {
  final Widget header;
  final Widget page;

  _TabBarItem({@required this.header, @required this.page});
}
