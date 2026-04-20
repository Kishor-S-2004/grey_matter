class SeriesCredits {
  final List<SeriesCastResult> cast;
  final List<SeriesCastResult> crew;
  final int id;

  SeriesCredits({
    required this.cast,
    required this.crew,
    required this.id,
  });

  factory SeriesCredits.fromJson(Map<String, dynamic> json) => SeriesCredits(
    cast: (json["cast"] as List<dynamic>? ?? [])
        .map((x) => SeriesCastResult.fromJson(x))
        .toList(),
    crew: (json["crew"] as List<dynamic>? ?? [])
        .map((x) => SeriesCastResult.fromJson(x))
        .toList(),
    id: json["id"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "cast": cast.map((x) => x.toJson()).toList(),
    "crew": crew.map((x) => x.toJson()).toList(),
    "id": id,
  };
}

class SeriesCastResult {
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String? character;
  final String creditId;
  final int? order;
  final String? department;
  final String? job;

  SeriesCastResult({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  factory SeriesCastResult.fromJson(Map<String, dynamic> json) {
    return SeriesCastResult(
      adult: json["adult"] ?? false,
      gender: json["gender"],
      id: json["id"] ?? 0,
      knownForDepartment: json["known_for_department"] ?? "Unknown",
      name: json["name"] ?? "Unknown",
      originalName: json["original_name"] ?? "",
      popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
      profilePath: json["profile_path"],
      character: json["character"],
      creditId: json["credit_id"] ?? "",
      order: json["order"],
      department: json["department"],
      job: json["job"],
    );
  }

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": knownForDepartment,
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath,
    "character": character,
    "credit_id": creditId,
    "order": order,
    "department": department,
    "job": job,
  };
}
