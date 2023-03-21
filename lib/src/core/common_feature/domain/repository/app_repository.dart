import 'package:movies_app/src/core/network/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AppRepository {
  Future<Either<Failure, String>> getData();
}
