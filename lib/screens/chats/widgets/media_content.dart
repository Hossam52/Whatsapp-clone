import 'package:flutter/material.dart';

class MediaContent extends StatelessWidget {
  const MediaContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height * 0.25,
        child: Column(
          children: [
            _buildMediaDataHeader(context),
            Expanded(child: _buildMediaContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaDataHeader(BuildContext context) {
    final style =
        TextStyle(fontSize: 24, color: Theme.of(context).primaryColor);
    return Row(children: [
      Expanded(child: Text('Media,links,and docs', style: style)),
      FittedBox(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextButton.icon(
              style: ButtonStyle(textStyle: MaterialStateProperty.all(style)),
              onPressed: () {},
              icon: Icon(Icons.keyboard_arrow_right_outlined),
              label: Text('2', style: style)),
        ),
      )
    ]);
  }

  Widget _buildMediaContent() {
    int length = 13;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: length,
      itemBuilder: (_, index) {
        if (index == length - 1) return _buildMoreMedia();
        return _MediaContentItem();
      },
    );
  }

  Widget _buildMoreMedia() {
    return FittedBox(
      child: IconButton(
        icon: Icon(Icons.keyboard_arrow_right),
        onPressed: () {},
      ),
    );
  }
}

class _MediaContentItem extends StatelessWidget {
  const _MediaContentItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(right: 2),
      height: double.infinity,
      width: width * 0.25,
      child: Image.asset('assets/images/person_image.jpg', fit: BoxFit.fill),
    );
  }
}
