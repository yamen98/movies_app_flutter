import 'package:movies_app/src/core/network/dio_network.dart';
import 'package:movies_app/src/core/network/error/dio_error_handler.dart';
import 'package:movies_app/src/core/network/error/exceptions.dart';
import 'package:movies_app/src/core/network/error/failures.dart';
import 'package:movies_app/src/features/movies/domain/entities/movies_response_model.dart';
import 'package:movies_app/src/features/movies/domain/usecases/movies_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class MoviesApi {
  CancelToken cancelToken = CancelToken();

  /// Movies method
  Future<Either<Failure, MoviesResponseModel>> movies(
      MoviesParams params) async {
    try {
      cancelToken = CancelToken();

      final result = (await DioNetwork.appAPI.get(
        "s=${params.textToSearch}&page=${params.page}",
        cancelToken: cancelToken,
      ))
          .data;
      if (result['Response'].toString().toLowerCase() == "false") {
        if (result['Error'].toString().toLowerCase() ==
            "Movie not found!".toLowerCase()) {
          return Right(
            MoviesResponseModel(
              search: [],
              totalResults: "0",
              response: result['Response'],
            ),
          );
        } else {
          return Left(
            ServerFailure(result['Error'], null),
          );
        }
      } else {
        return Right(
          MoviesResponseModel.fromJson(result),
        );
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
