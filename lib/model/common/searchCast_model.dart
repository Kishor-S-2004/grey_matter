class SearchCast {
  final int? page;
  final List<SearchCastResult> results;
  final int? totalPages;
  final int? totalResults;

  SearchCast({
    this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  factory SearchCast.fromJson(Map<String, dynamic> json) => SearchCast(
    page: json["page"],
    results: (json["results"] as List?)
        ?.map((x) => SearchCastResult.fromJson(x))
        .toList() ??
        [],
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": results.map((x) => x.toJson()).toList(),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class SearchCastResult {
  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final List<KnownFor> knownFor;

  SearchCastResult({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    required this.knownFor,
  });

  factory SearchCastResult.fromJson(Map<String, dynamic> json) =>
      SearchCastResult(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: (json["popularity"] as num?)?.toDouble(),
        profilePath: json["profile_path"],
        knownFor: (json["known_for"] as List?)
            ?.map((x) => KnownFor.fromJson(x))
            .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": knownForDepartment,
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath,
    "known_for": knownFor.map((x) => x.toJson()).toList(),
  };
}

class KnownFor {
  final bool? adult;
  final String? backdropPath;
  final int? id;
  final String? name;
  final String? originalName;
  final String? title;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? mediaType;
  final String? originalLanguage;
  final List<int> genreIds;
  final double? popularity;
  final DateTime? releaseDate;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  KnownFor({
    this.adult,
    this.backdropPath,
    this.id,
    this.name,
    this.originalName,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    required this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    id: json["id"],
    name: json['name'] ?? '',
    originalName: json['original_name'] ?? '',
    title: json["title"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    mediaType: json["media_type"],
    originalLanguage: json["original_language"],
    genreIds:
    (json["genre_ids"] as List?)?.map((x) => x as int).toList() ?? [],
    popularity: (json["popularity"] as num?)?.toDouble(),
    releaseDate: json["release_date"] != null &&
        (json["release_date"] as String).isNotEmpty
        ? DateTime.tryParse(json["release_date"])
        : null,
    video: json["video"],
    voteAverage: (json["vote_average"] as num?)?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "id": id,
    "name" : name,
    "title": title,
    "original_name":originalName,
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaType,
    "original_language": originalLanguage,
    "genre_ids": genreIds,
    "popularity": popularity,
    "release_date": releaseDate != null
        ? "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}"
        : null,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
