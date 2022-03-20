import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/modules/movie/bloc/movie_bloc.dart';
import 'package:simple_app/modules/movie/repos/movie_repository.dart';
import 'package:simple_app/modules/movie/widgets/movie_view.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({
    Key? key,
  }) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const MoviePage());
  }

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage>
    with AutomaticKeepAliveClientMixin {
  final MovieRepository movieRepository = MovieRepository();

  /// Giúp cho `Widget` này không `rebuild` khi chuyển `tab`
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RepositoryProvider.value(
      value: movieRepository,
      child: BlocProvider(
        create: (context) => MovieBloc(
          movieRepository: movieRepository,
        ),
        child: const Scaffold(
          body: MovieView(),
        ),
      ),
    );
  }
}
