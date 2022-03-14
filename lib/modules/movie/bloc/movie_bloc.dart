import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_app/modules/movie/repos/movie_repository.dart';
import 'package:simple_app/model/movie_model.dart';
import 'package:simple_app/network/api_service/api_response.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository _movieRepository;
  MovieBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(const MovieState()) {
    on<FetchDataEvent>(_onFetchData);
  }

  Future<void> _onFetchData(
      FetchDataEvent event, Emitter<MovieState> emit) async {
    emit(const MovieState.loading("Loading"));
    try {
      final results = await _movieRepository.fetchMovie();
      emit(MovieState.completed(results));
    } catch (e) {
      emit(MovieState.error(e.toString()));
    }
  }
}
