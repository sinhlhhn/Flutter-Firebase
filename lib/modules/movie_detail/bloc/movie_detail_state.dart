part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

/// Trạng thái của `favourite button`
class MovieDetailInitial extends MovieDetailState {}

class MovieDetailFavouriteStatus extends MovieDetailState {
  final bool isFavourite;

  const MovieDetailFavouriteStatus(this.isFavourite);

  @override
  List<Object> get props => [isFavourite];
}

/// Trạng thái của `Popup`
class MovieDetailPopupFavouriteStatus extends MovieDetailState {
  final bool isShowPopup;

  const MovieDetailPopupFavouriteStatus(this.isShowPopup);

  @override
  List<Object> get props => [isShowPopup];
}
