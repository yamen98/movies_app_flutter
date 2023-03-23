import 'package:json_annotation/json_annotation.dart';
import 'package:movies_app/src/core/common_feature/domain/entities/movie_filter_model.dart';
import 'package:movies_app/src/core/network/error/failures.dart';
import 'package:movies_app/src/core/util/usecases/usecase.dart';
import 'package:movies_app/src/features/movies/domain/entities/movies_response_model.dart';
import 'package:movies_app/src/features/movies/domain/repositories/movies_repository.dart';
import 'package:dartz/dartz.dart';

class MoviesUseCase extends UseCase<MoviesResponseModel, MoviesParams> {
  final MoviesRepository repository;

  MoviesUseCase(this.repository);

  @override
  Future<Either<Failure, MoviesResponseModel>> call(MoviesParams params) async {
    final result = await repository.movies(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

class MoviesParams {
  final String textToSearch;
  final int page;
  final MovieFilterModel filter;

  MoviesParams({
    required this.textToSearch,
    required this.page,
    required this.filter,
  });
}
