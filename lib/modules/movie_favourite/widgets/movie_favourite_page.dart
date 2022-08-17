import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/modules/movie/bloc/movie_bloc.dart';
import 'package:simple_app/modules/movie/repos/movie_repository.dart';
import 'package:simple_app/modules/movie_favourite/widgets/movie_favourite_view.dart';

class MovieFavouritePage extends StatefulWidget {
  const MovieFavouritePage({
    Key? key,
  }) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const MovieFavouritePage());
  }

  @override
  State<MovieFavouritePage> createState() => _MovieFavouritePageState();
}

class _MovieFavouritePageState extends State<MovieFavouritePage>
    with AutomaticKeepAliveClientMixin {
  final MovieRepository movieRepository = MovieRepository();

  /// Giúp cho `Widget` này không `rebuild` khi chuyển `tab`
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => movieRepository,
      child: BlocProvider(
        create: (context) => MovieBloc(movieRepository: movieRepository),
        child: const Scaffold(body: MovieFavouriteView()),
      ),
    );
  }
}
