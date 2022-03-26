part of 'downloads_bloc.dart';

abstract class DownloadsEvent extends Equatable {
  const DownloadsEvent();
}

class LoadDownloadedMoviesEvent extends DownloadsEvent {
  final String url = upcomingUrl;
  @override
  List<Object> get props => [url];
}
