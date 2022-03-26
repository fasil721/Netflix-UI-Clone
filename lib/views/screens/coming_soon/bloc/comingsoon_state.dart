part of 'comingsoon_bloc.dart';

abstract class ComingsoonState extends Equatable {
  const ComingsoonState();

  @override
  List<Object> get props => [];
}

class UpcomingMoviesLoadingState extends ComingsoonState {
  @override
  List<Object> get props => [];
}

class UpcomingMoviesLoadedState extends ComingsoonState {
  final List<Result> movies;
  const UpcomingMoviesLoadedState(this.movies);
  @override
  List<Object> get props => [movies];
}
