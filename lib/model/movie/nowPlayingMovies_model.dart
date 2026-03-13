class NowPlayingMovies {
  final Dates? dates;
  final int? page;
  final List<NowPlayingMovieResult>? results;
  final int? totalPages;
  final int? totalResults;

  NowPlayingMovies({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory NowPlayingMovies.fromJson(Map<String, dynamic> json) {
    return NowPlayingMovies(
      dates: json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
      page: json["page"],
      results: json["results"] != null
          ? List<NowPlayingMovieResult>.from(
          json["results"].map((x) => NowPlayingMovieResult.fromJson(x)))
          : [],
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
    );
  }

  Map<String, dynamic> toJson() => {
    "dates": dates?.toJson(),
    "page": page,
    "results": results?.map((x) => x.toJson()).toList(),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Dates {
  final DateTime? maximum;
  final DateTime? minimum;

  Dates({this.maximum, this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
      maximum: json["maximum"] != null
          ? DateTime.tryParse(json["maximum"])
          : null,
      minimum: json["minimum"] != null
          ? DateTime.tryParse(json["minimum"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "maximum": maximum?.toIso8601String(),
    "minimum": minimum?.toIso8601String(),
  };
}

class NowPlayingMovieResult {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  NowPlayingMovieResult({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory NowPlayingMovieResult.fromJson(Map<String, dynamic> json) {
    return NowPlayingMovieResult(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      genreIds: json["genre_ids"] != null
          ? List<int>.from(json["genre_ids"].map((x) => x))
          : [],
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"]?.toDouble(),
      posterPath: json["poster_path"],
      releaseDate: json["release_date"] != null &&
          json["release_date"].toString().isNotEmpty
          ? DateTime.tryParse(json["release_date"])
          : null,
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"]?.toDouble(),
      voteCount: json["vote_count"],
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
    "release_date": releaseDate?.toIso8601String(),
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
