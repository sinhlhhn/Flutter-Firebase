import 'package:simple_app/modules/movie/models/movie_model.dart';
import 'package:simple_app/network/api_service/movie_service/movie_api_service.dart';
import 'package:simple_app/network/api_service/movie_service/movie_response.dart';

class MovieRepository {
  final String _apiKey = "1b6d97fa231cd3677c56d9d3ea25b7c5";
  final MovieApiService apiService = MovieApiService();

  Future<List<Movie>> fetchMovie() async {
    final response = await apiService.get("movie/popular?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }
}
