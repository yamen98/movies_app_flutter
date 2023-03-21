part of 'movies_bloc.dart';

abstract class MoviesEvent {
  const MoviesEvent();
}

/// Get movies event
class OnGettingMoviesEvent extends MoviesEvent {
  final String textToSearch;
  final int page;
  final bool isLoadingMore;

  OnGettingMoviesEvent(
    this.textToSearch,
    this.page, {
    this.isLoadingMore = false,
  });
}

/// Clear search text field
class OnClearingSearchTextFieldEvent extends MoviesEvent {}
