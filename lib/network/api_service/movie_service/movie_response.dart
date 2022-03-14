import 'package:simple_app/modules/movie/models/movie_model.dart';

/// Chuyển thành `model` khi `request success` và nhận được `data` từ server
class MovieResponse {
  final int totalResults;
  final List<Movie> results;

  MovieResponse(this.totalResults, this.results);

  MovieResponse.empty()
      : totalResults = 0,
        results = [];

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    final totalResults = json['total_results'];
    if (json['results'] != null) {
      List<Movie> results = [];
      json['results'].forEach((v) {
        results.add(Movie.fromJson(v));
      });
      return MovieResponse(totalResults, results);
    }
    return MovieResponse.empty();
  }
}
