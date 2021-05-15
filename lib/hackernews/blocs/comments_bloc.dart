import 'dart:async';
import 'package:login_stateful/hackernews/resources/repository.dart';
import 'package:login_stateful/hackernews/models/ItemModels.dart';
import 'package:rxdart/rxdart.dart';

class CommentsBloc {
  final _repository = Repository();

  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  //streams
  Stream<Map<int, Future<ItemModel>>> get itemsWithComments =>
      _commentsOutput.stream;

  //sink
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }

  ScanStreamTransformer<int, Map<int, Future<ItemModel>>>
      _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int id, int index) {
        cache[id] = _repository.fetchTopItems(id);
        cache[id].then((ItemModel item) {
          item.kids.forEach(
            (kidId) => fetchItemWithComments(kidId),
          );
        });
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }
}
