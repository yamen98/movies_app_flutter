import 'package:movies_app/src/core/network/error/failures.dart';
import 'package:movies_app/src/features/movies/domain/entities/movies_response_model.dart';
import 'package:movies_app/src/features/movies/domain/usecases/movies_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class MoviesRepository {
  Future<Either<Failure, MoviesResponseModel>> movies(MoviesParams params);
}
