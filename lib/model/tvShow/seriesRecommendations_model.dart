class SeriesRecommendations {
  final int page;
  final List<SeriesRecommendationResult> results;
  final int totalPages;
  final int totalResults;

  SeriesRecommendations({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SeriesRecommendations.fromJson(Map<String, dynamic> json) {
    return SeriesRecommendations(
      page: json["page"] ?? 0,
      results: (json["results"] as List?)
          ?.map((x) => SeriesRecommendationResult.fromJson(x))
          .toList() ??
          [],
      totalPages: json["total_pages"] ?? 0,
      totalResults: json["total_results"] ?? 0,
    );
  }
}

class SeriesRecommendationResult {
  final bool adult;
  final String? backdropPath;
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final String? posterPath;
  final List<int> genreIds;
  final double popularity;
  final DateTime? firstAirDate;
  final double voteAverage;
  final int voteCount;
  final String? originalLanguage;
  final List<String> originCountry;
  final String? mediaType;

  SeriesRecommendationResult({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
  });

  factory SeriesRecommendationResult.fromJson(Map<String, dynamic> json) {
    return SeriesRecommendationResult(
      adult: json["adult"] ?? false,
      backdropPath: json["backdrop_path"],
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      originalName: json["original_name"] ?? "",
      overview: json["overview"] ?? "",
      posterPath: json["poster_path"],
      genreIds: (json["genre_ids"] as List?)
          ?.map((x) => x as int)
          .toList() ??
          [],
      popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
      firstAirDate: json["first_air_date"] != null &&
          json["first_air_date"].toString().isNotEmpty
          ? DateTime.tryParse(json["first_air_date"])
          : null,
      voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
      voteCount: json["vote_count"] ?? 0,
      originalLanguage: json["original_language"],
      mediaType: json["media_type"],
      originCountry: (json["origin_country"] as List?)
          ?.map((x) => x.toString())
          .toList() ??
          [],
    );
  }
}

enum MediaType {
  TV
}

final mediaTypeValues = EnumValues({
  "tv": MediaType.TV
});

enum OriginCountry {
  CA,
  ES,
  GB,
  US
}

final originCountryValues = EnumValues({
  "CA": OriginCountry.CA,
  "ES": OriginCountry.ES,
  "GB": OriginCountry.GB,
  "US": OriginCountry.US
});

enum OriginalLanguage {
  EN,
  ES
}

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
