import 'package:dio/dio.dart';
import '../models/model.dart';

class NewsService {
  final Dio dio;

  NewsService(this.dio);

  Future<List<Articles>> getNewsByCategory(String category) async {
    const String apiKey = '29177e105e9d44a19a588ed801905b46';
    const String baseUrl = 'https://newsapi.org/v2/top-headlines';
    const String country = 'us';

    try {
      final Response response = await dio.get(
        '$baseUrl',
        queryParameters: {
          'country': country,
          'category': category,
          'apiKey': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final ModelNews news = ModelNews.fromJson(response.data);
        return news.articles ?? [];
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching news: $e");
      return [];
    }
  }

}
