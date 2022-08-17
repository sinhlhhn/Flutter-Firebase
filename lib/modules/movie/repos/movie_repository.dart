import 'package:simple_app/db/movie_database.dart';
import 'package:simple_app/modules/movie/models/movie_model.dart';
import 'package:simple_app/network/api_service/movie_service/movie_api_service.dart';
import 'package:simple_app/network/api_service/movie_service/movie_response.dart';

class MovieRepository {
  final String _apiKey = "1b6d97fa231cd3677c56d9d3ea25b7c5";
  final MovieApiService _apiService = MovieApiService();
  final MovieDatabase _db = MovieDatabase();

  Future<List<Movie>> fetchMovie() async {
    final response = await _apiService.get("movie/popular?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }

  Future<List<Movie>> fetchFavouriteMovie() async {
    final movies = await _db.readFavouriteMovie();
    return movies;
  }
}
