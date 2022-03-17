import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/commom/widgets/stateless/lhs_indicator.dart';
import 'package:simple_app/modules/movie/bloc/movie_bloc.dart';
import 'package:simple_app/network/api_service/api_response.dart';

class MovieView extends StatelessWidget {
  const MovieView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        print(state);
        final error = state.message;
        return Stack(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$error'),
                ElevatedButton(
                  onPressed: () {
                    context.read<MovieBloc>().add(const FetchDataEvent());
                  },
                  child: const Text('Fetch'),
                )
              ],
            ),
          ),
          state.status == APIResponseStatus.loading
              ? const LHSIndicator()
              : const SizedBox(),
        ]);
      },
    );
  }
}
