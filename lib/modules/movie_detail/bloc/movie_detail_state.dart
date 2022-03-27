part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailFavouriteStatus extends MovieDetailState {
  final bool isFavourite;

  const MovieDetailFavouriteStatus(this.isFavourite);

  @override
  List<Object> get props => [isFavourite];
}
