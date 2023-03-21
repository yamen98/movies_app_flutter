import 'package:bloc/bloc.dart';
import 'package:movies_app/src/core/network/error/failures.dart';
import 'package:movies_app/src/core/util/injections.dart';
import 'package:movies_app/src/features/movies/domain/entities/movies_model.dart';
import 'package:movies_app/src/features/movies/domain/entities/movies_response_model.dart';
import 'package:movies_app/src/features/movies/domain/usecases/movies_usecase.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  late MoviesUseCase moviesUseCase;

  MoviesBloc() : super(MoviesInitial()) {
    moviesUseCase = sl<MoviesUseCase>();

    on<OnGettingMoviesEvent>(_onGettingMovies);
    on<OnClearingSearchTextFieldEvent>(_onClearingSearchTextField);
  }

  /// Movies event
  _onGettingMovies(
      OnGettingMoviesEvent event, Emitter<MoviesState> emitter) async {
    // Don't emit loading state is i scroll down to load more
    if (!event.isLoadingMore) {
      emitter(LoadingGetMoviesState());
    }

    final result = await moviesUseCase.call(
      MoviesParams(
        textToSearch: event.textToSearch,
        page: event.page,
      ),
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
  _onClearingSearchTextField(OnClearingSearchTextFieldEvent event,
      Emitter<MoviesState> emitter) async {
    emitter(ClearSearchTextFieldState());
  }
}
