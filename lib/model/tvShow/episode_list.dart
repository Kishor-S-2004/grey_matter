class Episode {
  String id;
  DateTime? airDate;
  List<EpisodeElement> episodes;
  String name;
  List<Network> networks;
  String overview;
  int episodeId;
  String posterPath;
  int seasonNumber;
  double voteAverage;

  Episode({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.networks,
    required this.overview,
    required this.episodeId,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
    id: json["_id"] ?? '',
    airDate: json["air_date"] != null
        ? DateTime.tryParse(json["air_date"])
        : null,
    episodes: (json["episodes"] as List<dynamic>?)
        ?.map((x) => EpisodeElement.fromJson(x))
        .toList() ??
        [],
    name: json["name"] ?? '',
    networks: (json["networks"] as List<dynamic>?)
        ?.map((x) => Network.fromJson(x))
        .toList() ??
        [],
    overview: json["overview"] ?? '',
    episodeId: json["id"] ?? 0,
    posterPath: json["poster_path"] ?? '',
    seasonNumber: json["season_number"] ?? 0,
    voteAverage:
    (json["vote_average"] as num?)?.toDouble() ?? 0.0,
  );
}

class EpisodeElement {
  DateTime? airDate;
  int episodeNumber;
  EpisodeType episodeType;
  int id;
  String name;
  String overview;
  String productionCode;
  int runtime;
  int seasonNumber;
  int showId;
  String stillPath;
  double voteAverage;
  int voteCount;
  List<Crew> crew;
  List<Crew> guestStars;

  EpisodeElement({
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
    required this.crew,
    required this.guestStars,
  });

  factory EpisodeElement.fromJson(Map<String, dynamic> json) =>
      EpisodeElement(
        airDate: json["air_date"] != null
            ? DateTime.tryParse(json["air_date"])
            : null,
        episodeNumber: json["episode_number"] ?? 0,
        episodeType: episodeTypeValues.map[json["episode_type"]] ??
            EpisodeType.STANDARD,
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        overview: json["overview"] ?? '',
        productionCode: json["production_code"] ?? '',
        runtime: json["runtime"] ?? 0,
        seasonNumber: json["season_number"] ?? 0,
        showId: json["show_id"] ?? 0,
        stillPath: json["still_path"] ?? '',
        voteAverage:
        (json["vote_average"] as num?)?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
        crew: (json["crew"] as List<dynamic>?)
            ?.map((x) => Crew.fromJson(x))
            .toList() ??
            [],
        guestStars: (json["guest_stars"] as List<dynamic>?)
            ?.map((x) => Crew.fromJson(x))
            .toList() ??
            [],
      );
}

class Crew {
  Department? department;
  Job? job;
  String creditId;
  bool adult;
  int gender;
  int id;
  Department knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  String? character;
  int? order;

  Crew({
    this.department,
    this.job,
    required this.creditId,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    this.character,
    this.order,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
    department: departmentValues.map[json["department"]],
    job: jobValues.map[json["job"]],
    creditId: json["credit_id"] ?? '',
    adult: json["adult"] ?? false,
    gender: json["gender"] ?? 0,
    id: json["id"] ?? 0,
    knownForDepartment:
    departmentValues.map[json["known_for_department"]] ??
        Department.CREW,
    name: json["name"] ?? '',
    originalName: json["original_name"] ?? '',
    popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
    profilePath: json["profile_path"],
    character: json["character"],
    order: json["order"],
  );
}

enum Department {
  ACTING,
  CAMERA,
  CREW,
  DIRECTING,
  EDITING,
  PRODUCTION,
  WRITING
}

final departmentValues = EnumValues({
  "Acting": Department.ACTING,
  "Camera": Department.CAMERA,
  "Crew": Department.CREW,
  "Directing": Department.DIRECTING,
  "Editing": Department.EDITING,
  "Production": Department.PRODUCTION,
  "Writing": Department.WRITING,
});

enum Job {
  DIRECTOR,
  DIRECTOR_OF_PHOTOGRAPHY,
  EDITOR,
  STORY,
  TELEPLAY,
  WRITER
}

final jobValues = EnumValues({
  "Director": Job.DIRECTOR,
  "Director of Photography": Job.DIRECTOR_OF_PHOTOGRAPHY,
  "Editor": Job.EDITOR,
  "Story": Job.STORY,
  "Teleplay": Job.TELEPLAY,
  "Writer": Job.WRITER,
});

enum EpisodeType { FINALE, STANDARD }

final episodeTypeValues = EnumValues({
  "finale": EpisodeType.FINALE,
  "standard": EpisodeType.STANDARD,
});

class Network {
  int id;
  String logoPath;
  String name;
  String originCountry;

  Network({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    id: json["id"] ?? 0,
    logoPath: json["logo_path"] ?? '',
    name: json["name"] ?? '',
    originCountry: json["origin_country"] ?? '',
  );
}

class EnumValues<T> {
  final Map<String, T> map;
  late final Map<T, String> reverseMap;

  EnumValues(this.map) {
    reverseMap = map.map((k, v) => MapEntry(v, k));
  }

  Map<T, String> get reverse => reverseMap;
}
