import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/commom/style/text_style.dart';
import 'package:simple_app/commom/widgets/stateful/lhs_button.dart';
import 'package:simple_app/commom/widgets/stateless/lhs_rating_view.dart';
import 'package:simple_app/modules/movie/models/movie_model.dart';
import 'package:simple_app/modules/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:simple_app/utils/dart.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({
    required this.movie,
    Key? key,
  }) : super(key: key);

  final Movie movie;

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            _backgroundDetail(size),
            _detailPostion(size),
            _detailButton(size),
          ],
        ),
      ),
    );
  }

  Widget _detailButton(Size size) {
    return Positioned(
      bottom: 32,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buyTicket(size),
            _favourite(size),
          ],
        ),
      ),
    );
  }

  Widget _favourite(Size size) {
    return BlocListener<MovieDetailBloc, MovieDetailState>(
      listener: (context, state) {
        if (state is MovieDetailFavouriteStatus) {
          if (state.isFavourite) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text("Film was add to favourite list")),
              );
          }
        }
      },
      child: SizedBox(
        width: size.width / 2 - 32,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // button radius
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.green,
                width: 1,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 5,
            shadowColor: Colors.red,
            primary: Colors.green, // background color
            onPrimary: Colors.white, // text color
            // thêm minimumSize để kích hoạt padding bên ngoài
            minimumSize: const Size.fromHeight(48),
          ),
          child: Text("Favourite"),
          onPressed: () => {
            context
                .read<MovieDetailBloc>()
                .add(const MovieDetailFavouriteChanged())
          },
        ),
      ),
    );
  }

  SizedBox _buyTicket(Size size) {
    return SizedBox(
      width: size.width / 2 - 32,
      child: LHSButton(
        onPress: () {},
        text: const Text("BUY TICKET"),
      ),
    );
  }

  Widget _detailPostion(Size size) {
    return Positioned(
      width: size.width,
      top: size.height / 3,
      bottom: 0,
      child: _detailView(),
    );
  }

  Widget _detailView() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      child: _scrollDetailView(),
    );
  }

  Widget _scrollDetailView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            addVerticalSpace(8),
            _title(),
            _rating(),
            addVerticalSpace(8),
            _dateAndPopular(),
            addVerticalSpace(16),
            _overview()
          ],
        ),
      ),
    );
  }

  Column _overview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Story Line:",
          style:
              LHSTextStyle.contentStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        addVerticalSpace(8),
        Text(
          "${widget.movie.overview}",
          style: LHSTextStyle.contentStyle,
        ),
      ],
    );
  }

  Row _dateAndPopular() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${widget.movie.popularity} views",
          style: LHSTextStyle.contentStyle.copyWith(
            color: Colors.grey[400],
          ),
        ),
        Text(
          "${widget.movie.releaseDate}",
          style: LHSTextStyle.contentStyle.copyWith(
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Row _rating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${widget.movie.voteAverage}",
          style: LHSTextStyle.contentStyle,
        ),
        addHorizontalSpace(8),
        LHSRatingView(rating: widget.movie.voteAverage),
      ],
    );
  }

  Text _title() {
    return Text(
      widget.movie.title ?? "",
      textAlign: TextAlign.center,
      style: LHSTextStyle.headerStyle,
    );
  }

  Widget _backgroundDetail(Size size) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 200),
      tween: Tween<double>(begin: -size.height / 2, end: 0),
      builder: (_, value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: child,
        );
      },
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: CachedNetworkImage(
                height: size.height / 3,
                imageUrl: widget.movie.backdropUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
        ],
      ),
    );
  }
}
