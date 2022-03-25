part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadTrendingMoviesEvent extends HomeEvent {
  final url = trendingUrl;
  @override
  List<Object?> get props => [url];
}

class LoadDiscoverMoviesEvent extends HomeEvent {
  final url = discoverUrl;
  @override
  List<Object?> get props => [url];
}
