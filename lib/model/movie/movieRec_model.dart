class MovieRecommendations {
  final int page;
  final List<RecommendationResult> results;
  final int totalPages;
  final int totalResults;

  MovieRecommendations({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieRecommendations.fromJson(Map<String, dynamic> json) {
    return MovieRecommendations(
      page: json["page"] is int ? json["page"] : int.tryParse("${json["page"]}") ?? 1,
      results: (json["results"] as List<dynamic>?)
          ?.map((x) => RecommendationResult.fromJson(x))
          .toList() ??
          [],
      totalPages: json["total_pages"] is int
          ? json["total_pages"]
          : int.tryParse("${json["total_pages"]}") ?? 0,
      totalResults: json["total_results"] is int
          ? json["total_results"]
          : int.tryParse("${json["total_results"]}") ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": results.map((x) => x.toJson()).toList(),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class RecommendationResult {
  final bool adult;
  final String backdropPath;
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final MediaType? mediaType;
  final OriginalLanguage? originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final DateTime? releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;

  RecommendationResult({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    this.mediaType,
    this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory RecommendationResult.fromJson(Map<String, dynamic> json) {
    return RecommendationResult(
      adult: json["adult"] ?? false,
      backdropPath: json["backdrop_path"]?.toString() ?? "",
      id: json["id"] is int ? json["id"] : int.tryParse("${json["id"]}") ?? 0,
      title: json["title"]?.toString() ?? "",
      originalTitle: json["original_title"]?.toString() ?? "",
      overview: json["overview"]?.toString() ?? "",
      posterPath: json["poster_path"]?.toString() ?? "",
      mediaType: mediaTypeValues.map[json["media_type"]],
      originalLanguage: originalLanguageValues.map[json["original_language"]],
      genreIds: (json["genre_ids"] as List<dynamic>?)
          ?.map((e) => e is int ? e : int.tryParse("$e") ?? 0)
          .toList() ??
          [],
      popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
      releaseDate: json["release_date"] != null && json["release_date"].toString().isNotEmpty
          ? DateTime.tryParse(json["release_date"])
          : null,
      video: json["video"] ?? false,
      voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
      voteCount: json["vote_count"] is int
          ? json["vote_count"]
          : int.tryParse("${json["vote_count"]}") ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath.isEmpty ? null : backdropPath,
    "id": id,
    "title": title,
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath.isEmpty ? null : posterPath,
    "media_type": mediaTypeValues.reverse[mediaType],
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "genre_ids": genreIds,
    "popularity": popularity,
    "release_date": releaseDate != null
        ? "${releaseDate!.year.toString().padLeft(4, '0')}-"
        "${releaseDate!.month.toString().padLeft(2, '0')}-"
        "${releaseDate!.day.toString().padLeft(2, '0')}"
        : null,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

enum MediaType { MOVIE }

final mediaTypeValues = EnumValues<MediaType>({
  "movie": MediaType.MOVIE,
});

enum OriginalLanguage { EN, IT, JA }

final originalLanguageValues = EnumValues<OriginalLanguage>({
  "en": OriginalLanguage.EN,
  "it": OriginalLanguage.IT,
  "ja": OriginalLanguage.JA,
});

class EnumValues<T> {
  final Map<String, T> map;
  late final Map<T, String> reverseMap;

  EnumValues(this.map) {
    reverseMap = map.map((k, v) => MapEntry(v, k));
  }

  Map<T, String> get reverse => reverseMap;
}
