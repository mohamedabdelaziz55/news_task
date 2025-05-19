
import 'package:flutter/cupertino.dart';

@immutable
abstract class BookmarksState {}

class BookmarksInitial extends BookmarksState {}

class BookmarksLoading extends BookmarksState {}

class BookmarksLoaded extends BookmarksState {
  final List<Map<String, dynamic>> articles;
  final List<Map<String, dynamic>> categories;

  BookmarksLoaded({required this.articles, required this.categories});
}

class BookmarksError extends BookmarksState {
  final String message;

  BookmarksError(this.message);
}
