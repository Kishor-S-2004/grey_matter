class SearchTvShow {
  final int page;
  final List<SearchTvShowResult> results;
  final int totalPages;
  final int totalResults;

  SearchTvShow({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchTvShow.fromJson(Map<String, dynamic> json) => SearchTvShow(
    page: json["page"] ?? 0,
    results: (json["results"] as List<dynamic>?)
        ?.map((x) => SearchTvShowResult.fromJson(x))
        .toList() ??
        [],
    totalPages: json["total_pages"] ?? 0,
    totalResults: json["total_results"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": results.map((x) => x.toJson()).toList(),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class SearchTvShowResult {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final List<String> originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final DateTime? firstAirDate;
  final String? name;
  final double voteAverage;
  final int voteCount;

  SearchTvShowResult({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  factory SearchTvShowResult.fromJson(Map<String, dynamic> json) {
    final firstAirDateStr = json["first_air_date"];

    return SearchTvShowResult(
      adult: json["adult"] ?? false,
      backdropPath: json["backdrop_path"],
      genreIds: (json["genre_ids"] as List<dynamic>?)
          ?.map((x) => x as int)
          .toList() ??
          [],
      id: json["id"] ?? 0,
      originCountry: (json["origin_country"] as List<dynamic>?)
          ?.map((x) => x.toString())
          .toList() ??
          [],
      originalLanguage: json["original_language"],
      originalName: json["original_name"],
      overview: json["overview"],
      popularity: (json["popularity"] ?? 0).toDouble(),
      posterPath: json["poster_path"],
      firstAirDate: (firstAirDateStr != null && firstAirDateStr.toString().isNotEmpty)
          ? DateTime.tryParse(firstAirDateStr)
          : null,
      name: json["name"],
      voteAverage: (json["vote_average"] ?? 0).toDouble(),
      voteCount: json["vote_count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": genreIds,
    "id": id,
    "origin_country": originCountry,
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "first_air_date": firstAirDate?.toIso8601String().split('T').first,
    "name": name,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
