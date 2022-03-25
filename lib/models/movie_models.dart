class MovieModel {
  MovieModel({
    this.page,
    this.results,
  });

  int? page;
  List<Result>? results;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        page: json["page"] as int,
        results: List<Result>.from(
          (json["results"] as List)
              .map((x) => Result.fromJson(Map<String, dynamic>.from(x as Map))),
        ),
      );
}

class Result {
  Result({
    this.posterPath,
    this.overview,
    this.releaseDate,
    this.backdropPath,
    this.title,
    this.genreIds,
  });

  String? posterPath;
  String? overview;
  String? releaseDate;
  String? backdropPath;
  String? title;
  List<int>? genreIds;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        posterPath: json["poster_path"] as String,
        overview: json["overview"] as String,
        releaseDate: json["release_date"] as String?,
        backdropPath: json["backdrop_path"] as String?,
        title: json["title"] as String?,
        genreIds: List<int>.from((json["genre_ids"] as List).map((x) => x)),
      );
}
