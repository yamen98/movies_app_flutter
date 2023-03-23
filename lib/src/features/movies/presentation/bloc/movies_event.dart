part of 'movies_bloc.dart';

abstract class MoviesEvent {
  const MoviesEvent();
}

/// Get movies event
class OnGettingMoviesEvent extends MoviesEvent {
  final String textToSearch;
  final MovieFilterModel filterModel;
  final int page;
  final bool isLoadingMore;

  OnGettingMoviesEvent(
    this.textToSearch,
    this.page,
    this.filterModel, {
    this.isLoadingMore = false,
  });
}

/// Clear search text field
class OnClearingSearchTextFieldEvent extends MoviesEvent {}

/// Get movie details by id event
class OnGettingMovieDetailsByIdEvent extends MoviesEvent {
  final String id;

  OnGettingMovieDetailsByIdEvent(
    this.id,
  );
}
