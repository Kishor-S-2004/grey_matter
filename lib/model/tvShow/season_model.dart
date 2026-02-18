class Season {
  final bool? adult;
  final String? backdropPath;
  final List<CreatedBy> createdBy;
  final List<int> episodeRunTime;
  final DateTime? firstAirDate;
  final List<Genre> genres;
  final String? homepage;
  final int? id;
  final bool? inProduction;
  final List<String> languages;
  final DateTime? lastAirDate;
  final LastEpisodeToAir? lastEpisodeToAir;
  final String? name;
  final dynamic nextEpisodeToAir;
  final List<Network> networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String> originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<Network> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<SeasonElement> seasons;
  final List<SpokenLanguage> spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  Season({
    this.adult,
    this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    this.firstAirDate,
    required this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    required this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    required this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    required this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  factory Season.fromJson(Map<String, dynamic> json) => Season(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    createdBy: (json["created_by"] as List<dynamic>?)
        ?.map((x) => CreatedBy.fromJson(x))
        .toList() ??
        [],
    episodeRunTime: (json["episode_run_time"] as List<dynamic>?)
        ?.map((x) => x as int)
        .toList() ??
        [],
    firstAirDate: (json["first_air_date"] != null &&
        json["first_air_date"].toString().isNotEmpty)
        ? DateTime.tryParse(json["first_air_date"])
        : null,
    genres: (json["genres"] as List<dynamic>?)
        ?.map((x) => Genre.fromJson(x))
        .toList() ??
        [],
    homepage: json["homepage"],
    id: json["id"],
    inProduction: json["in_production"],
    languages: (json["languages"] as List<dynamic>?)
        ?.map((x) => x.toString())
        .toList() ??
        [],
    lastAirDate: (json["last_air_date"] != null &&
        json["last_air_date"].toString().isNotEmpty)
        ? DateTime.tryParse(json["last_air_date"])
        : null,
    lastEpisodeToAir: json["last_episode_to_air"] != null
        ? LastEpisodeToAir.fromJson(json["last_episode_to_air"])
        : null,
    name: json["name"],
    nextEpisodeToAir: json["next_episode_to_air"],
    networks: (json["networks"] as List<dynamic>?)
        ?.map((x) => Network.fromJson(x))
        .toList() ??
        [],
    numberOfEpisodes: json["number_of_episodes"],
    numberOfSeasons: json["number_of_seasons"],
    originCountry: (json["origin_country"] as List<dynamic>?)
        ?.map((x) => x.toString())
        .toList() ??
        [],
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: (json["popularity"] as num?)?.toDouble(),
    posterPath: json["poster_path"],
    productionCompanies: (json["production_companies"] as List<dynamic>?)
        ?.map((x) => Network.fromJson(x))
        .toList() ??
        [],
    productionCountries: (json["production_countries"] as List<dynamic>?)
        ?.map((x) => ProductionCountry.fromJson(x))
        .toList() ??
        [],
    seasons: (json["seasons"] as List<dynamic>?)
        ?.map((x) => SeasonElement.fromJson(x))
        .toList() ??
        [],
    spokenLanguages: (json["spoken_languages"] as List<dynamic>?)
        ?.map((x) => SpokenLanguage.fromJson(x))
        .toList() ??
        [],
    status: json["status"],
    tagline: json["tagline"],
    type: json["type"],
    voteAverage: (json["vote_average"] as num?)?.toDouble(),
    voteCount: json["vote_count"],
  );
}


class CreatedBy {
  final int? id;
  final String? creditId;
  final String? name;
  final int? gender;
  final String? profilePath;

  CreatedBy({
    this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["id"],
    creditId: json["credit_id"],
    name: json["name"],
    gender: json["gender"],
    profilePath: json["profile_path"],
  );
}

class Genre {
  final int? id;
  final String? name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json["id"],
    name: json["name"],
  );
}

class LastEpisodeToAir {
  final int? id;
  final String? name;
  final String? overview;
  final double? voteAverage;
  final int? voteCount;
  final DateTime? airDate;
  final int? episodeNumber;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final int? showId;
  final String? stillPath;

  LastEpisodeToAir({
    this.id,
    this.name,
    this.overview,
    this.voteAverage,
    this.voteCount,
    this.airDate,
    this.episodeNumber,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
  });

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) =>
      LastEpisodeToAir(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        voteAverage: (json["vote_average"] as num?)?.toDouble(),
        voteCount: json["vote_count"],
        airDate: json["air_date"] != null
            ? DateTime.tryParse(json["air_date"])
            : null,
        episodeNumber: json["episode_number"],
        productionCode: json["production_code"],
        runtime: json["runtime"],
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"],
      );
}

class Network {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  Network({this.id, this.logoPath, this.name, this.originCountry});

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    id: json["id"],
    logoPath: json["logo_path"],
    name: json["name"],
    originCountry: json["origin_country"],
  );
}

class ProductionCountry {
  final String? iso31661;
  final String? name;

  ProductionCountry({this.iso31661, this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );
}

class SeasonElement {
  final DateTime? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  SeasonElement({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
    this.voteAverage,
  });

  factory SeasonElement.fromJson(Map<String, dynamic> json) => SeasonElement(
    airDate: json["air_date"] != null
        ? DateTime.tryParse(json["air_date"])
        : null,
    episodeCount: json["episode_count"],
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    seasonNumber: json["season_number"],
    voteAverage: (json["vote_average"] as num?)?.toDouble(),
  );
}

class SpokenLanguage {
  final String? englishName;
  final String? iso6391;
  final String? name;

  SpokenLanguage({this.englishName, this.iso6391, this.name});

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
    englishName: json["english_name"],
    iso6391: json["iso_639_1"],
    name: json["name"],
  );
}
