import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_task/views/book_marks_view.dart';

import '../../storage_helper.dart';
import 'book_marks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  final DatabaseHelper db;

  BookmarksCubit(this.db) : super(BookmarksInitial());

  Future<void> loadBookmarks() async {
    emit(BookmarksLoading());

    try {
      final articles = await db.getArticles();
      final categories = await db.getCategories();

      emit(BookmarksLoaded(
        articles: articles,
        categories: categories,
      ));
    } catch (e) {
      emit(BookmarksError("Failed to load data"));
    }
  }

  Future<void> addArticle(Map<String, dynamic> article) async {
    await db.insertArticle(article);
    await loadBookmarks();
  }

  Future<void> deleteArticle(String url) async {
    await db.deleteArticle(url);
    await loadBookmarks();
  }

  Future<void> addCategory(Map<String, dynamic> category) async {
    await db.insertCategory(category);
    await loadBookmarks();
  }

  Future<void> deleteCategory(String category) async {
    await db.deleteCategory(category);
    await loadBookmarks();
  }

  // ✅ الميثود الجديدة للتحقق من وجود المقالة
  bool isArticleBookmarked(String url) {
    if (state is BookmarksLoaded) {
      final currentState = state as BookmarksLoaded;
      return currentState.articles.any((article) => article['url'] == url);
    }
    return false;
  }
}
