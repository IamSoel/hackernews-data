import 'package:flutter/material.dart';
import 'package:login_stateful/hackernews/blocs/stories_provider.dart';
import 'package:login_stateful/hackernews/models/ItemModels.dart';
import 'package:login_stateful/hackernews/widget/loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoryProvider.of(context);

    return StreamBuilder(
        stream: bloc.items,
        builder: (BuildContext context,
            AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingContainer();
          }
          return FutureBuilder(
            future: snapshot.data[itemId],
            builder:
                (BuildContext context, AsyncSnapshot<ItemModel> itemSnapShot) {
              if (!itemSnapShot.hasData) {
                return LoadingContainer();
              }
              return buildTile(context, itemSnapShot.data);
            },
          );
        });
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    return Column(
      children: [
        ListTile(
          title: Text('${item.title}'),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: [
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          },
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}
