import 'package:simple_app/db/movie_database.dart';
import 'package:simple_app/modules/movie/models/movie_model.dart';

class MovieDetailRepository {
  final _db = MovieDatabase();

  Future<bool> getMovieFavouriteState({required int movieId}) async {
    final movie = await _db.readMovieWith(movieId: movieId);
    if (movie != null) {
      return movie.isFavourite ?? false;
    }
    return false;
  }

  Future<void> insertMovie({required Movie movie}) async {
    if (movie.id == null || movie.isFavourite == null) {
      throw "Movie id is null";
    }
    try {
      final existMovie = await _db.readMovieWith(movieId: movie.id!);
      if (existMovie != null) {
        updateFavourite(movieId: movie.id!, isFavourite: movie.isFavourite!);
        return;
      }
      await _db.insertMovie(movie);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateFavourite(
      {required int movieId, required bool isFavourite}) async {
    try {
      await _db.updateFavouriteMovie(
          movieId: movieId, isFavourite: isFavourite);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteDB() async {
    try {
      await _db.deleteDB();
    } catch (e) {
      rethrow;
    }
  }
}
