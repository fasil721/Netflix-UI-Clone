part of 'downloads_bloc.dart';

abstract class DownloadsState extends Equatable {
  const DownloadsState();

  @override
  List<Object> get props => [];
}

class DownloadedMoviesLoadingState extends DownloadsState {
  @override
  List<Object> get props => [];
}

class DownloadedMoviesLoadedState extends DownloadsState {
  final List<Result> movies;
  const DownloadedMoviesLoadedState(this.movies);
  @override
  List<Object> get props => [movies];
}
