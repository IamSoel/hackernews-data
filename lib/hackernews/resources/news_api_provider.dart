import 'dart:convert';

import 'package:http/http.dart';
import 'package:login_stateful/hackernews/models/ItemModels.dart';
import 'package:login_stateful/hackernews/resources/repository.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get(
      Uri.parse('$_root/topstories.json'),
    );
    final ids = json.decode(response.body);
    print('Ids from api $ids');
    return ids.cast<int>();
  }

  Future<ItemModel> fetchTopItems(int id) async {
    final response = await client.get(
      Uri.parse('$_root/item/$id.json'),
    );
    final parsedJson = json.decode(response.body);
    print('This is the item data  $_root/item/$id.json');
    return ItemModel.fromJson(parsedJson);
  }
}
