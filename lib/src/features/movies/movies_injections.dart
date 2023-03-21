import 'package:movies_app/src/core/util/injections.dart';
import 'package:movies_app/src/features/movies/data/data_sources/movies_api.dart';
import 'data/data_sources/movies_shared_prefs.dart';
import 'data/repositories/movies_repo_empl.dart';
import 'domain/repositories/movies_repository.dart';
import 'domain/usecases/movies_usecase.dart';

initMoviesInjections() {
  sl.registerFactory<MoviesApi>(() => MoviesApi());
  sl.registerFactory<MoviesSharedPrefs>(() => MoviesSharedPrefs(sl()));
  sl.registerFactory<MoviesUseCase>(() => MoviesUseCase(sl()));
  sl.registerFactory<MoviesRepository>(() => MoviesRepositoryImpl(sl(), sl()));
}
