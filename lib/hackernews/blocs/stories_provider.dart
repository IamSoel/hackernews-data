import 'package:flutter/material.dart';
import 'package:login_stateful/hackernews/blocs/stories_bloc.dart';
export 'stories_bloc.dart';

class StoryProvider extends InheritedWidget {
  final storyBloc;

  StoryProvider({Key key, Widget child})
      : storyBloc = StoriesBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static StoriesBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<StoryProvider>())
        .storyBloc;
  }
}
