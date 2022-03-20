import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:simple_app/commom/constant/color.dart';
import 'package:simple_app/commom/constant/font.dart';
import 'package:simple_app/modules/movie/bloc/movie_bloc.dart';
import 'package:simple_app/modules/movie/models/movie_model.dart';
import 'package:simple_app/utils/dart.dart';

class MovieView extends StatefulWidget {
  const MovieView({Key? key}) : super(key: key);

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  Size get _size => MediaQuery.of(context).size;
  double get _movieItemWidth => _size.width / 2;

  final _backgroundController = ScrollController();
  final _movieController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Animation scroll
    _movieController.addListener(() {
      _backgroundController
          .jumpTo(_movieController.offset * (_size.width / _movieItemWidth));
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().add(const FetchDataEvent());
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.data is List<Movie> && state.data != null) {
          final movies = state.data;
          return Stack(
            children: [
              _listBackground(context, movies),
              _listMovie(context, movies),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget _listMovie(BuildContext context, List<Movie> movies) {
    return ScrollSnapList(
      listController: _movieController,
      onItemFocus: (item) => {},
      itemSize: _movieItemWidth,
      padding: EdgeInsets.zero,
      itemCount: movies.length,
      scrollDirection: Axis.horizontal,
      dynamicItemSize: true,
      itemBuilder: (context, index) {
        return _movieIndex(index, movies[index]);
      },
    );
  }

  Widget _movieIndex(int index, Movie movie) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        addVerticalSpace(_size.height * 0.008),
        _movieTitle(movie),
        // _subTitle(),
        addVerticalSpace(_size.height * 0.005),
        _rating(movie.voteAverage),
        addVerticalSpace(_size.height * 0.01),
        _buttonBuy(),
        addVerticalSpace(_size.height * 0.01),
        _listImageMovie(movie),
      ],
    );
  }

  Widget _movieTitle(Movie movie) {
    return SizedBox(
      height: _size.height * 0.15,
      child: Center(
        child: SizedBox(
          width: _movieItemWidth,
          child: Text(
            movie.title ?? "",
            style: const TextStyle(
              fontFamily: FontFamily.movieTitleFont,
              fontSize: 32,
              color: AppColor.movieTitleColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _listImageMovie(Movie movie) {
    return ClipRect(
      child: CachedNetworkImage(
        imageUrl: movie.posterUrl,
        width: _movieItemWidth,
        height: _size.height * 0.3,
      ),
    );
  }

  Widget _buttonBuy() {
    return Container(
      width: _size.width * 0.25,
      height: _size.height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
      ),
      child: const Center(
        child: Text(
          "BUY TICKET",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _rating(dynamic rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          color: ((rating / 2).round() > index) ? Colors.yellow : Colors.grey,
        );
      }),
    );
  }

  Widget _subTitle() {
    return Row(
      children: List.generate(3, (index) {
        return Container(color: Colors.red, child: Text("data"));
      }),
    );
  }

  Widget _listBackground(BuildContext context, List<Movie> movies) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      controller: _backgroundController,
      reverse: true,
      itemBuilder: (context, index) {
        return SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                  // left: -size.width / 3,
                  // right: -size.width / 3,
                  child: CachedNetworkImage(
                imageUrl: movies[index].backdropUrl,
              )),
              Container(
                color: Colors.black.withOpacity(0.4),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(.3),
                      Colors.black.withOpacity(.95),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.5, 0.9],
                  ),
                ),
              )
            ],
          ),
        );
      },
      itemCount: movies.length,
      scrollDirection: Axis.horizontal,
    );
  }
}
