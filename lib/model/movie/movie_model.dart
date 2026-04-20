class MovieModel {
  final int? page;
  final List<Result>? results;
  final int? totalPages;
  final int? totalResults;

  MovieModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      page: json["page"],
      results: json["results"] != null
          ? List<Result>.from(
          json["results"].map((x) => Result.fromJson(x)))
          : [],
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
    );
  }

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": results?.map((x) => x.toJson()).toList(),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final String? genreName;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final int? releaseYear;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  Result({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.genreName,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.releaseYear,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      adult: json["adult"] ?? false,
      backdropPath: json["backdrop_path"] ?? '',
      genreIds: json["genre_ids"] != null
          ? List<int>.from(json["genre_ids"].map((x) => x))
          : [],
      genreName: json['genreName'] ?? '',
      id: json["id"] ?? 0,
      originalLanguage: json["original_language"] ?? " ",
      originalTitle: json["original_title"] ?? '',
      overview: json["overview"] ?? '',
      popularity: json["popularity"]?.toDouble(),
      posterPath: json["poster_path"] ?? '',
      releaseDate: json["release_date"] != null &&
          json["release_date"].toString().isNotEmpty
          ? DateTime.tryParse(json["release_date"])
          : null,
      releaseYear: json['releaseYear'] ?? 0,
      title: json["title"] ?? '',
      video: json["video"] ?? false,
      voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
      voteCount: json["vote_count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": genreIds,
    "id": id,
    'genreName':genreName,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate?.toIso8601String(),
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
