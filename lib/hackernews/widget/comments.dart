import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:login_stateful/hackernews/models/ItemModels.dart';

class Comments extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final depth;

  const Comments({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: itemMap[itemId],
        builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
          if (!snapshot.hasData) {
            return Text('Still loading comments');
          }

          final item = snapshot.data;
          final children = <Widget>[
            ListTile(
              title: buildText(item),
              subtitle: item.by == ' ' ? Text('[DELETED]') : Text(item.by),
              contentPadding: EdgeInsets.only(
                right: 16.0,
                left: depth * 16.0,
              ),
            )
          ];

          snapshot.data.kids.forEach((kidId) {
            children.add(
              Comments(
                itemId: kidId,
                itemMap: itemMap,
              ),
            );
          });

          return Column(
            children: children,
          );
        });
  }

  Widget buildText(ItemModel item) {
    final text = item.text
        .replaceAll('&#x27', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '')
        .replaceAll('<i>', '');
    return Html(data: text);
  }
}
