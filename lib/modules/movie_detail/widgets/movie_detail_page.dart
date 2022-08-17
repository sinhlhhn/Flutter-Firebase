import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/modules/movie/bloc/movie_bloc.dart';
import 'package:simple_app/modules/movie/models/movie_model.dart';
import 'package:simple_app/modules/movie/repos/movie_repository.dart';
import 'package:simple_app/modules/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:simple_app/modules/movie_detail/repos/movie_detail_repository.dart';
import 'package:simple_app/modules/movie_detail/widgets/movie_detail_view.dart';

class MoviewDetailPage extends StatelessWidget {
  const MoviewDetailPage(
      {required this.movie, required this.movieBloc, Key? key})
      : super(key: key);

  final Movie movie;
  final MovieBloc movieBloc;

  static Route route(Movie movie, MovieBloc movieBloc) {
    return MaterialPageRoute(builder: (_) {
      return MoviewDetailPage(
        movie: movie,
        movieBloc: movieBloc,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MovieDetailBloc(
              movieDetailRepository: MovieDetailRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => movieBloc,
          ),
        ],
        child: MovieDetailView(movie: movie),
      ),
    );
  }
}
