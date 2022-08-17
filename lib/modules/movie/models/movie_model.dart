import 'package:equatable/equatable.dart';

// Dữ liệu cuối cùng được sử dụng để hiển thị lên UI

class Movie extends Equatable {
  final int? voteCount;
  final int? id;
  final bool? video;
  final dynamic voteAverage;
  final String? title;
  final dynamic popularity;
  final String? posterPath;
  final String? originalLanguage;
  final String? originalTitle;
  final List<int>? genreIds;
  final String? backdropPath;
  final bool? adult;
  final String? overview;
  final String? releaseDate;
  bool? isFavourite;

  Movie(
      {this.voteCount,
      this.id,
      this.video,
      this.voteAverage,
      this.title,
      this.popularity,
      this.posterPath,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.backdropPath,
      this.adult,
      this.overview,
      this.releaseDate,
      this.isFavourite});

  String get posterUrl {
    return "https://image.tmdb.org/t/p/w342" + (posterPath ?? "");
  }

  String get backdropUrl {
    return "https://image.tmdb.org/t/p/w342" + (backdropPath ?? "");
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        voteCount: json['vote_count'],
        id: json['id'],
        video: json['video'],
        voteAverage: json['vote_average'],
        title: json['title'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        genreIds: json['genre_ids'].cast<int>(),
        backdropPath: json['backdrop_path'],
        adult: json['adult'],
        overview: json['overview'],
        releaseDate: json['release_date'],
        isFavourite: json['is_favourite'] == 1);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vote_count'] = voteCount;
    data['id'] = id;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['title'] = title;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['genre_ids'] = genreIds;
    data['backdrop_path'] = backdropPath;
    data['adult'] = adult;
    data['overview'] = overview;
    data['release_date'] = releaseDate;
    data['is_favourite'] = isFavourite;
    return data;
  }

  /// SQLite
  factory Movie.fromSqlJson(Map<String, dynamic> json) {
    return Movie(
        voteCount: json['vote_count'],
        id: json['id'],
        voteAverage: json['vote_average'],
        title: json['title'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        backdropPath: json['backdrop_path'],
        overview: json['overview'],
        releaseDate: json['release_date'],
        isFavourite: json['is_favourite'] == 1);
  }

  Map<String, dynamic> toSqlJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vote_count'] = voteCount;
    data['id'] = id;
    data['vote_average'] = voteAverage;
    data['title'] = title;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['backdrop_path'] = backdropPath;
    data['overview'] = overview;
    data['release_date'] = releaseDate;
    data['is_favourite'] = isFavourite ?? false ? 1 : 0;
    return data;
  }

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return "Movie { id: $id }";
  }
}

class MovieFields {
  static const String voteCount = "vote_count";
  static const String comparison = "id";
  static const String id = "_id";
  static const String video = "video";
  static const String voteAverage = "vote_average";
  static const String title = "title";
  static const String popularity = "popularity";
  static const String posterPath = "poster_path";
  static const String originalLanguage = "original_language";
  static const String originalTitle = "original_title";
  static const String genreIds = "genre_ids";
  static const String backdropPath = "backdrop_path";
  static const String adult = "adult";
  static const String overview = "overview";
  static const String releaseDate = "release_date";
  static const String isFavourite = "is_favourite";
}
