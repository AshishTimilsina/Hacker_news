import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/news.dart';

List newsid = [];
List<News> news = [];

final storyprovider = FutureProvider((ref) => StoryService().getnews());

class StoryService {
  Future<List<News>> getnews() async {
    final dio = Dio();
    try {
      final response = await dio.get(
          'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty');
      newsid = response.data;
      for (int i = 0; i < 20; i++) {
        int id = newsid[i];
        final response2 = await dio.get(
            'https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty');
        Map<String, dynamic> map = response2.data;
        final dataa = News.fromJson(map);
        news.add(dataa);
      }
      return news;
    } on DioError catch (err) {
      throw err.toString();
    }
  }
}
