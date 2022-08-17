part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchDataEvent extends MovieEvent {
  const FetchDataEvent();
}

class FetchFavouriteMovieEvent extends MovieEvent {
  const FetchFavouriteMovieEvent();
}
