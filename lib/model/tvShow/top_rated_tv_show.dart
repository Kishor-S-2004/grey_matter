class Tvshow {
  final int page;
  final List<TopRatedSeriesResult> results;
  final int totalPages;
  final int totalResults;

  Tvshow({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory Tvshow.fromJson(Map<String, dynamic> json) => Tvshow(
    page: json["page"] ?? 0,
    results: (json["results"] as List<dynamic>?)
        ?.map((x) => TopRatedSeriesResult.fromJson(x))
        .toList() ??
        [],
    totalPages: json["total_pages"] ?? 0,
    totalResults: json["total_results"] ?? 0,
  );
}

class TopRatedSeriesResult {
  final String backdropPath;
  final DateTime? firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final List<OriginCountry> originCountry;
  final OriginalLanguage originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  TopRatedSeriesResult({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TopRatedSeriesResult.fromJson(Map<String, dynamic> json) =>
      TopRatedSeriesResult(
        backdropPath: json["backdrop_path"] ?? '',
        firstAirDate: json["first_air_date"] != null &&
            (json["first_air_date"] as String).isNotEmpty
            ? DateTime.tryParse(json["first_air_date"])
            : null,
        genreIds: (json["genre_ids"] as List<dynamic>?)
            ?.map((x) => x as int)
            .toList() ??
            [],
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        originCountry: (json["origin_country"] as List<dynamic>?)
            ?.map((x) =>
        originCountryValues.map[x] ?? OriginCountry.US)
            .toList() ??
            [],
        originalLanguage: originalLanguageValues.map[
        json["original_language"]] ??
            OriginalLanguage.EN,
        originalName: json["original_name"] ?? '',
        overview: json["overview"] ?? '',
        popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
        posterPath: json["poster_path"] ?? '',
        voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
      );
}

enum OriginCountry {
  CA,
  JP,
  KR,
  US
}

final originCountryValues = EnumValues({
  "CA": OriginCountry.CA,
  "JP": OriginCountry.JP,
  "KR": OriginCountry.KR,
  "US": OriginCountry.US
});

enum OriginalLanguage {
  EN,
  JA,
  KO
}

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "ja": OriginalLanguage.JA,
  "ko": OriginalLanguage.KO
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
