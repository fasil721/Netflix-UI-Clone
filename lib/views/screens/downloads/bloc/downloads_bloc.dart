import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:netfix/constants.dart';
import 'package:netfix/models/movie_models.dart';
import 'package:netfix/services/tmdb_service.dart';

part 'downloads_event.dart';
part 'downloads_state.dart';

class DownloadsBloc extends Bloc<DownloadsEvent, DownloadsState> {
  final TmdbServices _tmdb;
  DownloadsBloc(this._tmdb) : super(DownloadedMoviesLoadingState()) {
    on<LoadDownloadedMoviesEvent>((event, emit) async {
      emit(DownloadedMoviesLoadingState());
      final result = await _tmdb.fetchData(event.url);
      if (result != null) {
        emit(DownloadedMoviesLoadedState(result));
      }
    });
  }
}
