import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/modules/movie/bloc/movie_bloc.dart';
import 'package:simple_app/modules/movie/models/movie_model.dart';
import 'package:simple_app/modules/movie_detail/widgets/movie_detail_page.dart';

class MovieFavouriteView extends StatefulWidget {
  const MovieFavouriteView({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieFavouriteView> createState() => _MovieFavouriteViewState();
}

class _MovieFavouriteViewState extends State<MovieFavouriteView> {
  @override
  void initState() {
    context.read<MovieBloc>().add(const FetchFavouriteMovieEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<MovieBloc, MovieState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.data is List<Movie> && state.data != null) {
          final List<Movie> movies = state.data;
          return Container(
            color: theme.backgroundColor,
            child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child:
                                  CachedNetworkImage(imageUrl: movie.posterUrl),
                            ),
                            Text(movie.title ?? ""),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      final movieBloc = context.read<MovieBloc>();
                      Navigator.of(context)
                          .push(MoviewDetailPage.route(movie, movieBloc));
                    },
                  );
                }),
          );
        }
        return Container();
      },
    );
  }
}
