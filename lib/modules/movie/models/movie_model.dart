import 'package:equatable/equatable.dart';

// Dữ liệu cuối cùng được sử dụng để hiển thị lên UI
class Movie extends Equatable {
  final int? id;
  final num? voteAverage;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? releaseDate;

  const Movie(
    this.id,
    this.voteAverage,
    this.title,
    this.posterPath,
    this.overview,
    this.releaseDate,
  );

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      json['id'],
      json['vote_average'],
      json['title'],
      json['poster_path'],
      json['overview'],
      json['release_date'],
    );
  }

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return "Movie { id: $id }";
  }
}
