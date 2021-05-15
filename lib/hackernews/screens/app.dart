import 'package:flutter/material.dart';
import 'package:login_stateful/hackernews/blocs/comments_provider.dart';
import 'package:login_stateful/hackernews/screens/news_details.dart';

import '../blocs/stories_provider.dart';
import 'news_list.dart';

class AppNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoryProvider(
        child: MaterialApp(
          onGenerateRoute: routes,
        ),
      ),
    );
  }
}

Route routes(RouteSettings settings) {
  if (settings.name == '/') {
    return MaterialPageRoute(
      builder: (context) {
        final storiesBloc = StoryProvider.of(context);
        storiesBloc.fetchTopIds();
        return NewsList();
      },
    );
  } else {
    return MaterialPageRoute(
      builder: (context) {
        final commentsBloc = CommentsProvider.of(context);
        final itemId = int.parse(settings.name.replaceFirst('/', ''));
        commentsBloc.fetchItemWithComments(itemId);
        return NewsDetails(itemId);
      },
    );
  }
}
