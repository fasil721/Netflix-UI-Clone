import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:netfix/constants.dart';
import 'package:netfix/models/movie_models.dart';
import 'package:netfix/services/tmdb_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TmdbServices _tmdb;
  HomeBloc(this._tmdb) : super(HomeInitial()) {
    on<LoadTrendingMoviesEvent>((event, emit) async {
      emit(MainPosterLoadingState());
      final result = await _tmdb.fetchData(event.url);
      if (result != null) {
        emit(MainPosterLoadedState(result));
      }
    });
    
    on<LoadDiscoverMoviesEvent>((event, emit) async {
      emit(HomeListLoadingState());
      final result = await _tmdb.fetchData(event.url);
      if (result != null) {
        emit(HomeListLoadedState(result));
      }
    });
  }
}
