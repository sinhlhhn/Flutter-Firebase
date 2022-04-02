part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchFavouriteEvent extends MovieDetailEvent {
  final int movieId;

  const FetchFavouriteEvent(this.movieId);
  @override
  List<Object> get props => [movieId];
}

class MovieDetailFavouriteChanged extends MovieDetailEvent {
  final Movie movie;
  const MovieDetailFavouriteChanged(this.movie);

  @override
  List<Object> get props => [];
}
