import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:news_app_task/cubits/search_cubit/search_state.dart';

import '../../models/model.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  void searchNews(String query) async {
    if (query.trim().isEmpty) return;

    emit(SearchLoading());

    final dio = Dio();
    const apiKey = '29177e105e9d44a19a588ed801905b46';
    const url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    try {
      final response = await dio.get(url);
      final ModelNews news = ModelNews.fromJson(response.data);
      final allArticles = news.articles ?? [];
      print('عدد المقالات: ${allArticles.length}');

      final results = allArticles.where((article) {
        final title = article.title?.toLowerCase() ?? '';
        final author = article.author?.toLowerCase() ?? '';
        final content = article.content?.toLowerCase() ?? '';
        final description = article.description?.toLowerCase() ?? '';

        return title.contains(query.toLowerCase()) ||
            author.contains(query.toLowerCase()) ||
            content.contains(query.toLowerCase()) ||
            description.contains(query.toLowerCase());
      }).toList();

      print('عدد النتائج بعد البحث: ${results.length}');
      emit(SearchLoaded(results));
    } catch (e) {
      emit(SearchError("Search Error: $e"));
    }
  }
}