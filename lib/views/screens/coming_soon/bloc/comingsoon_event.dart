part of 'comingsoon_bloc.dart';

abstract class ComingsoonEvent extends Equatable {
  const ComingsoonEvent();

  @override
  List<Object> get props => [];
}

class LoadUpcomingMoviesEvent extends ComingsoonEvent {
  final url = upcomingUrl;
  @override
  List<Object> get props => [url];
}
