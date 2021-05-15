import 'package:flutter/material.dart';
import 'package:login_stateful/hackernews/blocs/stories_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  Refresh({this.child});

  @override
  Widget build(BuildContext context) {
    final bloc = StoryProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}
