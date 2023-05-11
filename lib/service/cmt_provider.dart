import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/comment.dart';

final commentprov = StateNotifierProvider<Commentprovider, List<Comment>>(
    (ref) => Commentprovider());

List<Comment> comments = [];

class Commentprovider extends StateNotifier<List<Comment>> {
  Commentprovider() : super([]);

  Future<void> getcomments({List? kids}) async {
    final dio = Dio();
    try {
      if (kids != null) {
        for (int i = 0; i < kids.length; i++) {
          int id = await kids[i];

          final response = await dio.get(
              "https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty");
          Map<String, dynamic> json = await response.data;
          final data = Comment.fromJson(json);
          comments.add(data);
        }
        state = comments;
      }
    } on DioError catch (err) {
      throw err.toString();
    }
  }
}
