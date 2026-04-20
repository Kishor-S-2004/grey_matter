class TvShowVideo {
  final int? id;
  final List<TvShowVideoResult> results;

  TvShowVideo({
    this.id,
    required this.results,
  });

  factory TvShowVideo.fromJson(Map<String, dynamic> json) => TvShowVideo(
    id: json["id"] as int?,
    results: (json["results"] as List?)
        ?.map((x) => TvShowVideoResult.fromJson(x))
        .toList() ??
        [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "results": results.map((x) => x.toJson()).toList(),
  };
}

class TvShowVideoResult {
  final Iso6391? iso6391;
  final Iso31661? iso31661;
  final String? name;
  final String? key;
  final Site? site;
  final int? size;
  final String? type;
  final bool? official;
  final DateTime? publishedAt;
  final String? id;

  TvShowVideoResult({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  factory TvShowVideoResult.fromJson(Map<String, dynamic> json) =>
      TvShowVideoResult(
        iso6391: iso6391Values.map[json["iso_639_1"]],
        iso31661: iso31661Values.map[json["iso_3166_1"]],
        name: json["name"] as String?,
        key: json["key"] as String?,
        site: siteValues.map[json["site"]],
        size: json["size"] as int?,
        type: json["type"] as String?,
        official: json["official"] as bool?,
        publishedAt: json["published_at"] != null
            ? DateTime.tryParse(json["published_at"])
            : null,
        id: json["id"] as String?,
      );

  Map<String, dynamic> toJson() => {
    "iso_639_1": iso6391Values.reverse[iso6391],
    "iso_3166_1": iso31661Values.reverse[iso31661],
    "name": name,
    "key": key,
    "site": siteValues.reverse[site],
    "size": size,
    "type": type,
    "official": official,
    "published_at": publishedAt?.toIso8601String(),
    "id": id,
  };
}

enum Iso31661 { US }

final iso31661Values = EnumValues<Iso31661>({
  "US": Iso31661.US,
});

enum Iso6391 { EN }

final iso6391Values = EnumValues<Iso6391>({
  "en": Iso6391.EN,
});

enum Site { YOU_TUBE }

final siteValues = EnumValues<Site>({
  "YouTube": Site.YOU_TUBE,
});

class EnumValues<T> {
  final Map<String, T> map;
  late final Map<T, String> reverseMap;

  EnumValues(this.map) {
    reverseMap = map.map((k, v) => MapEntry(v, k));
  }

  Map<T, String> get reverse => reverseMap;
}
