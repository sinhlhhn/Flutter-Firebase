part of 'movie_bloc.dart';

class MovieState extends APIResponse {
  const MovieState();

  const MovieState.loading(String message) : super.loading(message);
  const MovieState.completed(List<Movie> data) : super.completed(data);
  const MovieState.error(String message) : super.error(message);

  @override
  List<Object?> get props => super.props;
}
