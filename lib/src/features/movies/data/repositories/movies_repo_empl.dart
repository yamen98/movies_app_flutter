import 'package:movies_app/src/core/network/error/exceptions.dart';
import 'package:movies_app/src/core/network/error/failures.dart';
import 'package:movies_app/src/features/movies/data/data_sources/movies_api.dart';
import 'package:movies_app/src/features/movies/data/data_sources/movies_shared_prefs.dart';
import 'package:movies_app/src/features/movies/domain/entities/movies_response_model.dart';
import 'package:movies_app/src/features/movies/domain/repositories/movies_repository.dart';
import 'package:movies_app/src/features/movies/domain/usecases/movies_usecase.dart';
import 'package:dartz/dartz.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesApi moviesApi;
  final MoviesSharedPrefs moviesPrefs;

  MoviesRepositoryImpl(this.moviesApi, this.moviesPrefs);

  /// Movies method
  @override
  Future<Either<Failure, MoviesResponseModel>> movies(
      MoviesParams params) async {
    try {
      final result = await moviesApi.movies(params);
      return result.fold((l) {
        return Left(ServerFailure(l.errorMessage, null));
      }, (r) {
        return Right(r);
      });
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}
