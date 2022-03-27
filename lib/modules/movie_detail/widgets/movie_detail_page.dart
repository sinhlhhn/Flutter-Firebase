import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/modules/movie/models/movie_model.dart';
import 'package:simple_app/modules/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:simple_app/modules/movie_detail/repos/movie_detail_repository.dart';
import 'package:simple_app/modules/movie_detail/widgets/movie_detail_view.dart';

class MoviewDetailPage extends StatelessWidget {
  const MoviewDetailPage({required this.movie, Key? key}) : super(key: key);

  final Movie movie;

  static Route route(Movie movie) {
    return MaterialPageRoute(builder: (_) {
      return MoviewDetailPage(movie: movie);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MovieDetailBloc(
          movieDetailRepository: MovieDetailRepository(),
        ),
        child: MovieDetailView(movie: movie),
      ),
    );
  }
}
