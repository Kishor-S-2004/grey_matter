class AiringToday {
  int page;
  List<AiringTodayResults> results;
  int totalPages;
  int totalResults;

  AiringToday({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory AiringToday.fromJson(Map<String, dynamic> json) => AiringToday(
    page: json["page"],
    results: List<AiringTodayResults>.from(json["results"].map((x) => AiringTodayResults.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class AiringTodayResults {
  String? backdropPath;
  DateTime? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  AiringTodayResults({
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    this.id,
    this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  factory AiringTodayResults.fromJson(Map<String, dynamic> json) => AiringTodayResults(
    backdropPath: json["backdrop_path"] ?? '',
    firstAirDate: json['first_air_date'] != null && (json['first_air_date'] as String).isNotEmpty ? DateTime.tryParse(json['first_air_date']) : null,
    genreIds: (json['genre_ids'] as List<dynamic>?)?.map((x)=> x as int).toList() ?? [],
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    originCountry: (json['origin_country'] as List<dynamic>?)?.map((x) => x as String).toList() ?? [],
    originalLanguage: json["original_language"] ?? '',
    originalName: json["original_name"] ?? '',
    overview: json["overview"] ?? '',
    popularity: json["popularity"]?.toDouble() ?? 0.0,
    posterPath: json["poster_path"] ?? '',
    voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "first_air_date": "${firstAirDate?.year.toString().padLeft(4, '0')}-${firstAirDate?.month.toString().padLeft(2, '0')}-${firstAirDate?.day.toString().padLeft(2, '0')}",
    "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
    "id": id,
    "name": name,
    "origin_country": List<dynamic>.from(originCountry!.map((x) => x)),
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
