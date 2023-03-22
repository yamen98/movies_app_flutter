import 'package:json_annotation/json_annotation.dart';
import 'package:movies_app/src/core/network/error/failures.dart';
import 'package:movies_app/src/core/util/usecases/usecase.dart';
import 'package:movies_app/src/features/movies/domain/entities/movie_details_model.dart';
import 'package:movies_app/src/features/movies/domain/entities/movies_response_model.dart';
import 'package:movies_app/src/features/movies/domain/repositories/movies_repository.dart';
import 'package:dartz/dartz.dart';

class GetMovieDetailsUseCase extends UseCase<MovieDetailsModel?, MovieDetailsParams> {
  final MoviesRepository repository;

  GetMovieDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, MovieDetailsModel?>> call(MovieDetailsParams params) async {
    final result = await repository.getMovieDetailsById(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

class MovieDetailsParams {
  final String movieId;

  MovieDetailsParams({
    required this.movieId,
  });
}
