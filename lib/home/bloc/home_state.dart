part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class MainPosterLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class MainPosterLoadedState extends HomeState {
  final List<Result> movies;
  const MainPosterLoadedState(this.movies);
  @override
  List<Object> get props => [movies];
}

class HomeListLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeListLoadedState extends HomeState {
  final List<Result> movies;
  const HomeListLoadedState(this.movies);
  @override
  List<Object> get props => [movies];
}
