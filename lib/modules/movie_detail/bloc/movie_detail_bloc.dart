import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<MovieDetailFavouriteChanged>(_onFavouriteChange);
  }

  void _onFavouriteChange(
      MovieDetailFavouriteChanged event, Emitter<MovieDetailState> emit) {
    emit(const MovieDetailFavouriteStatus(true));
  }
}
