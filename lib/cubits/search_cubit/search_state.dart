
import '../../models/model.dart';

abstract class SearchState  {
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Articles> articles;

  SearchLoaded(this.articles);

  @override
  List<Object?> get props => [articles];
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object?> get props => [message];
}