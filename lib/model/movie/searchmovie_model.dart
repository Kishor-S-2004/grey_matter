class SearchMovie {
  final int page;
  final List<SearchMovieResult> results;
  final int totalPages;
  final int totalResults;

  SearchMovie({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchMovie.fromJson(Map<String, dynamic> json) {
    return SearchMovie(
      page: json["page"] ?? 0,
      results: (json["results"] as List<dynamic>?)
          ?.map((x) => SearchMovieResult.fromJson(x))
          .toList() ??
          [],
      totalPages: json["total_pages"] ?? 0,
      totalResults: json["total_results"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": results.map((x) => x.toJson()).toList(),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class SearchMovieResult {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  DateTime? releaseDate;
  final String? title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  SearchMovieResult({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory SearchMovieResult.fromJson(Map<String, dynamic> json) {
    return SearchMovieResult(
      adult: json["adult"] ?? false,
      backdropPath: json["backdrop_path"],
      genreIds: (json["genre_ids"] as List<dynamic>?)
          ?.map((x) => x as int)
          .toList() ??
          [],
      id: json["id"] ?? 0,
      originalLanguage: json["original_language"] ?? '',
      originalTitle: json["original_title"] ?? '',
      overview: json["overview"] ?? '',
      popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
      posterPath: json["poster_path"],
      releaseDate: json["release_date"] != null ? DateTime.tryParse(json["release_date"]) : null,
      title: json["title"] ?? '',
      video: json["video"] ?? false,
      voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
      voteCount: json["vote_count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": genreIds,
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
