import 'package:bloc/bloc.dart';
import 'package:movies_app/src/core/common_feature/domain/entities/movie_filter_model.dart';
import 'package:movies_app/src/core/network/error/failures.dart';
import 'package:movies_app/src/core/util/injections.dart';
import 'package:movies_app/src/features/movies/domain/entities/movie_details_model.dart';
import 'package:movies_app/src/features/movies/domain/entities/movies_model.dart';
import 'package:movies_app/src/features/movies/domain/entities/movies_response_model.dart';
import 'package:movies_app/src/features/movies/domain/usecases/movie_details_usecase.dart';
import 'package:movies_app/src/features/movies/domain/usecases/movies_usecase.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  late MoviesUseCase moviesUseCase;
  late GetMovieDetailsUseCase getMovieDetailsUseCase;

  MoviesBloc() : super(MoviesInitial()) {
    moviesUseCase = sl<MoviesUseCase>();
    getMovieDetailsUseCase = sl<GetMovieDetailsUseCase>();

    on<OnGettingMoviesEvent>(_onGettingMoviesEvent);
    on<OnClearingSearchTextFieldEvent>(_onClearingSearchTextFieldEvent);
    on<OnGettingMovieDetailsByIdEvent>(_onGettingMovieDetailsByIdEvent);
  }

  /// Movies event
  _onGettingMoviesEvent(
      OnGettingMoviesEvent event, Emitter<MoviesState> emitter) async {
    // Don't emit loading state is i scroll down to load more
    if (!event.isLoadingMore) {
      emitter(LoadingGetMoviesState());
    }

    final result = await moviesUseCase.call(
      MoviesParams(
          textToSearch: event.textToSearch,
          page: event.page,
          filter: event.filterModel),
    );
    result.fold((l) {
      if (l is CancelTokenFailure) {
        if (!event.isLoadingMore) {
          emitter(LoadingGetMoviesState());
        }
      } else {
        emitter(ErrorGetMoviesState(l.errorMessage));
      }
    }, (r) {
      emitter(
        SuccessGetMoviesState(
          r,
          isLoadingMore: event.isLoadingMore,
        ),
      );
    });
  }

  /// Clear search text field event
  _onClearingSearchTextFieldEvent(OnClearingSearchTextFieldEvent event,
      Emitter<MoviesState> emitter) async {
    emitter(ClearSearchTextFieldState());
  }

  /// Get movie details by id event
  _onGettingMovieDetailsByIdEvent(OnGettingMovieDetailsByIdEvent event,
      Emitter<MoviesState> emitter) async {
    emitter(LoadingGetMovieDetailsByIdState());

    final result = await getMovieDetailsUseCase.call(
      MovieDetailsParams(
        movieId: event.id,
      ),
    );
    result.fold((l) {
      emitter(ErrorGetMovieDetailsByIdState(l.errorMessage));
    }, (r) {
      emitter(
        SuccessGetMovieDetailsByIdState(r),
      );
    });
  }
}
