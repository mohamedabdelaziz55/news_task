import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../models/model.dart';
import '../../services/news_service.dart';
import 'category_state.dart';


class NewsCategoryCubit extends Cubit<NewsCategoryState> {
  NewsCategoryCubit() : super(NewsCategoryLoading());

  Future<void> fetchCategoryNews(String category) async {
    emit(NewsCategoryLoading());
    try {
      NewsService newsService = NewsService(Dio());
      List<Articles> articles = await newsService.getNewsByCategory(category);
      emit(NewsCategorySuccess(articles));
    } catch (e) {
      emit(NewsCategoryError("Failed to load news: $e"));
    }
  }
}
