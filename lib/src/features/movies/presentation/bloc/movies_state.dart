part of 'movies_bloc.dart';

abstract class MoviesState {
  const MoviesState();
}

class MoviesInitial extends MoviesState {}

/// --------------------Start Get Movies-------------------- ///

/// Loading get movies state
class LoadingGetMoviesState extends MoviesState {}

/// Error get movies state
class ErrorGetMoviesState extends MoviesState {
  final String errorMsg;

  ErrorGetMoviesState(this.errorMsg);
}

/// Success get movies state
class SuccessGetMoviesState extends MoviesState {
  final MoviesResponseModel moviesResult;
  final bool isLoadingMore;

  SuccessGetMoviesState(
    this.moviesResult, {
    this.isLoadingMore = false,
  });
}

/// --------------------End Get Movies-------------------- ///

/// --------------------Start Get Movie Details By Id-------------------- ///

/// Loading get movie details by id state
class LoadingGetMovieDetailsByIdState extends MoviesState {}

/// Error get movie details by id state
class ErrorGetMovieDetailsByIdState extends MoviesState {
  final String errorMsg;

  ErrorGetMovieDetailsByIdState(this.errorMsg);
}

/// Success get movie details by id state
class SuccessGetMovieDetailsByIdState extends MoviesState {
  final MovieDetailsModel? movieDetailsModel;

  SuccessGetMovieDetailsByIdState(this.movieDetailsModel);
}

/// --------------------End Get Movie Details By Id-------------------- ///
