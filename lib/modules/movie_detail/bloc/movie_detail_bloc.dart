import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_app/modules/movie/models/movie_model.dart';
import 'package:simple_app/modules/movie_detail/repos/movie_detail_repository.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieDetailRepository _movieDetailRepository;

  MovieDetailBloc({required MovieDetailRepository movieDetailRepository})
      : _movieDetailRepository = movieDetailRepository,
        super(MovieDetailInitial()) {
    on<MovieDetailFavouriteChanged>(_onFavouriteChange);
    on<FetchFavouriteEvent>(_onFetchFavourite);
  }

  void _onFetchFavourite(
      FetchFavouriteEvent event, Emitter<MovieDetailState> emit) async {
    final isFavourite = await _movieDetailRepository.getMovieFavouriteState(
        movieId: event.movieId);
    emit(MovieDetailFavouriteStatus(isFavourite));
  }

  void _onFavouriteChange(
      MovieDetailFavouriteChanged event, Emitter<MovieDetailState> emit) async {
    try {
      await _movieDetailRepository.insertMovie(movie: event.movie);
      final isFavourite = event.movie.isFavourite ?? false;
      emit(MovieDetailPopupFavouriteStatus(isFavourite));
      emit(MovieDetailFavouriteStatus(isFavourite));
    } catch (e) {
      print(e);
    }
  }
}
