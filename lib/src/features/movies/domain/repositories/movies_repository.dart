import 'package:movies_app/src/core/network/error/failures.dart';
import 'package:movies_app/src/features/movies/domain/entities/movie_details_model.dart';
import 'package:movies_app/src/features/movies/domain/entities/movies_response_model.dart';
import 'package:movies_app/src/features/movies/domain/usecases/movie_details_usecase.dart';
import 'package:movies_app/src/features/movies/domain/usecases/movies_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class MoviesRepository {
  // Get all movies by filter
  Future<Either<Failure, MoviesResponseModel>> movies(MoviesParams params);

  // Get movie details by id
  Future<Either<Failure, MovieDetailsModel?>> getMovieDetailsById(MovieDetailsParams params);
}
