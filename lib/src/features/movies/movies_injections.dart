import 'package:movies_app/src/core/util/injections.dart';
import 'package:movies_app/src/features/movies/data/data_sources/movies_api.dart';
import 'package:movies_app/src/features/movies/domain/usecases/movie_details_usecase.dart';
import 'data/data_sources/movies_shared_prefs.dart';
import 'data/repositories/movies_repo_empl.dart';
import 'domain/repositories/movies_repository.dart';
import 'domain/usecases/movies_usecase.dart';

initMoviesInjections() {
  sl.registerSingleton<MoviesApi>(MoviesApi());
  sl.registerSingleton<MoviesSharedPrefs>(MoviesSharedPrefs(sl()));
  sl.registerSingleton<MoviesRepository>(MoviesRepositoryImpl(sl(), sl()));
  sl.registerSingleton<MoviesUseCase>(MoviesUseCase(sl()));
  sl.registerSingleton<GetMovieDetailsUseCase>(GetMovieDetailsUseCase(sl()));
}
