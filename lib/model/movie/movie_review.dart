class MovieReview {
  int id;
  int page;
  List<MovieReviewResuts> results;
  int totalPages;
  int totalResults;

  MovieReview({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieReview.fromJson(Map<String, dynamic> json) => MovieReview(
    id: json["id"],
    page: json["page"],
    results: List<MovieReviewResuts>.from(json["results"].map((x) => MovieReviewResuts.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class MovieReviewResuts {
  String author;
  AuthorDetails authorDetails;
  String content;
  DateTime? createdAt;
  String id;
  DateTime? updatedAt;
  String url;

  MovieReviewResuts({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  factory MovieReviewResuts.fromJson(Map<String, dynamic> json) => MovieReviewResuts(
    author: json["author"] ?? '',
    authorDetails: AuthorDetails.fromJson(json["author_details"]),
    content: json["content"] ?? '',
    createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
    id: json["id"] ?? 0,
    updatedAt: json["updated_at"]!= null ? DateTime.tryParse(json["updated_at"]) : null,
    url: json["url"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "author_details": authorDetails.toJson(),
    "content": content,
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "updated_at": updatedAt?.toIso8601String(),
    "url": url,
  };
}

class AuthorDetails {
  String name;
  String username;
  String? avatarPath;
  int? rating;

  AuthorDetails({
    required this.name,
    required this.username,
    required this.avatarPath,
    required this.rating,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) => AuthorDetails(
    name: json["name"] ?? '',
    username: json["username"]?? '',
    avatarPath: json["avatar_path"] ?? '',
    rating: json["rating"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "avatar_path": avatarPath,
    "rating": rating,
  };
}
