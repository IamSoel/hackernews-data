import 'package:flutter/material.dart';
import 'package:login_stateful/hackernews/blocs/comments_provider.dart';
import 'package:login_stateful/hackernews/models/ItemModels.dart';
import 'package:login_stateful/hackernews/widget/comments.dart';

class NewsDetails extends StatelessWidget {
  final itemId;
  final int depth = 0;

  const NewsDetails(this.itemId);

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: buildBody(context, bloc),
    );
  }

  Widget buildBody(BuildContext context, CommentsBloc bloc) {
    return StreamBuilder(
        stream: bloc.itemsWithComments,
        builder:
            (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (snapshot.hasData) {
            final itemFuture = snapshot.data[itemId];
            return FutureBuilder(
                future: itemFuture,
                builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
                  if (itemSnapshot.hasData) {
                    return buildList(itemSnapshot.data, snapshot.data);
                  }
                  return CircularProgressIndicator();
                });
          }
          return Text('Loading title');
        });
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      alignment: Alignment.topCenter,
      height: 50.0,
      margin: EdgeInsets.all(10.0),
      child: Text(
        '${item.title}',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));
    final commentList = item.kids.map((kidId) {
      return Comments(
        itemId: kidId,
        itemMap: itemMap,
        depth: depth + 1,
      );
    }).toList();

    children.addAll(commentList);
    return ListView(
      scrollDirection: Axis.vertical,
      children: children,
    );
  }
}
