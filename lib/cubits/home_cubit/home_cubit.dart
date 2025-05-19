import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../models/model.dart';
import '../../services/news_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final NewsService newsService = NewsService(Dio());

  void fetchNews(String category) async {
    emit(HomeLoading());
    try {
      List<Articles> articles = await newsService.getNewsByCategory(category);
      emit(HomeSuccess(articles));
    } catch (e) {
      emit(HomeError("Failed to fetch news: $e"));
    }
  }
}