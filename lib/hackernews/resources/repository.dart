import 'package:login_stateful/hackernews/models/ItemModels.dart';
import 'package:login_stateful/hackernews/resources/news_api_provider.dart';
import 'package:login_stateful/hackernews/resources/news_db_provider.dart';

class Repository {
  List<Source> sources = <Source>[
    NewsApiProvider(),
    newsDbProvider,
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() async {
    List<int> ids;
    for (var source in sources) {
      ids = await source.fetchTopIds();
      if (ids != null) {
        break;
      }
    }

    return ids;
  }

  Future<ItemModel> fetchTopItems(int id) async {
    ItemModel item;
    var source;
    for (source in sources) {
      item = await source.fetchTopItems(id);
      if (item != null) {
        break;
      }
    }
    for (var cache in caches) {
      if (cache != source) {
        cache.addItem(item);
        // print('database store ${item.title}');
      }
    }
    return item;
  }

  Future<int> clearCache() async {
    return await caches[0].clear();
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchTopItems(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}
