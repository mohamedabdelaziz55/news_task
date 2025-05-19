part of 'home_cubit.dart';
abstract class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Articles> articles;

  HomeSuccess(this.articles);
}

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}