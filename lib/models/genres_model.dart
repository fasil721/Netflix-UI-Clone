class GenresModel {
  GenresModel({
    this.genres,
  });

  List<Genre>? genres;

  factory GenresModel.fromJson(Map<String, dynamic> json) => GenresModel(
        genres: List<Genre>.from(
          (json["genres"] as List)
              .map((x) => Genre.fromJson(Map<String, dynamic>.from(x as Map))),
        ),
      );
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"] as int,
        name: json["name"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
