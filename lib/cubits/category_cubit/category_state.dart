


import '../../models/model.dart';

abstract class NewsCategoryState {}

final class NewsCategoryLoading extends NewsCategoryState {}

class NewsCategorySuccess extends NewsCategoryState {
  final List<Articles> articles;
  NewsCategorySuccess(this.articles);
}

class NewsCategoryError extends NewsCategoryState {
  final String message;
  NewsCategoryError(this.message);
}
