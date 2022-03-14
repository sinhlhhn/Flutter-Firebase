import 'package:simple_app/network/api_service/api_service.dart';
import 'package:simple_app/network/api_service/model/movie_model.dart';
import 'package:simple_app/network/api_service/response/movie_response.dart';

class MovieRepository {
  final String _apiKey = "1b6d97fa231cd3677c56d9d3ea25b7c5";
  final APIService apiService = APIService();

  Future<List<Movie>> fetchMovie() async {
    final response = await apiService.get("movie/popular?apikey=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }
}
