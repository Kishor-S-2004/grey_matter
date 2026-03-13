import 'package:cloud_firestore/cloud_firestore.dart';

class MovieReview {
  int id;
  int page;
  List<MovieReviewResults> results;
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
    results: List<MovieReviewResults>.from(json["results"].map((x) => MovieReviewResults.fromJson(x))),
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

class MovieReviewResults {
  String? author;
  String? movieName;
  int? movieId;
  AuthorDetails? authorDetails;
  String? content;
  DateTime? createdAt;
  String? id;
  DateTime? updatedAt;
  String? url;

  MovieReviewResults({
    this.author,
    this.movieName,
    this.movieId,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  factory MovieReviewResults.fromJson(Map<String, dynamic> json) => MovieReviewResults(
    author: json["author"] ?? '',
    movieName: json['movie_name'] ?? '',
    movieId: json['movie_id'] ?? 0,
    authorDetails: json["author_details"] != null
        ? AuthorDetails.fromJson(json["author_details"])
        : null,
    content: json["content"] ?? '',
    createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
    id: json["id"]?.toString(),
    updatedAt: json["updated_at"]!= null ? DateTime.tryParse(json["updated_at"]) : null,
    url: json["url"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "movie_name":movieName,
    'movie_id':movieId,
    "author_details": authorDetails?.toJson(),
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
  double? rating;

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
      rating: (json["rating"] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "avatar_path": avatarPath,
    "rating": rating,
  };
}
