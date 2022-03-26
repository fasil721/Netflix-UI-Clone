import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:netfix/constants.dart';
import 'package:netfix/models/genres_model.dart';
import 'package:netfix/models/movie_models.dart';
import 'package:netfix/services/tmdb_service.dart';

part 'comingsoon_event.dart';
part 'comingsoon_state.dart';

class ComingsoonBloc extends Bloc<ComingsoonEvent, ComingsoonState> {
  final TmdbServices _tmdb;
  ComingsoonBloc(this._tmdb) : super(UpcomingMoviesLoadingState()) {
    on<LoadUpcomingMoviesEvent>((event, emit) async {
      emit(UpcomingMoviesLoadingState());
      final result = await _tmdb.fetchData(event.url);
      if (result != null) {
        emit(UpcomingMoviesLoadedState(result));
      }
    });
    
    on<LoadGenresEvent>((event, emit) async {
      final result = await _tmdb.genre();
      if (result != null) {
        emit(LoadGenresState(result));
      }
    });
  }
}
