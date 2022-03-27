part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class MovieDetailFavouriteChanged extends MovieDetailEvent {
  const MovieDetailFavouriteChanged();

  @override
  List<Object> get props => [];
}
