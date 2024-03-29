import 'package:flutter/material.dart';
import 'package:simple_app/Screen/test_screen/tab4.dart';
import 'package:simple_app/modules/movie/widgets/movie_page.dart';
import 'package:simple_app/modules/movie_favourite/widgets/movie_favourite_page.dart';
import 'package:simple_app/modules/profile/widgets/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(color: theme.primaryColor),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TabBar(
              indicatorColor: Colors.transparent,
              unselectedLabelColor: theme.backgroundColor,
              tabs: const [
                Tab(
                  icon: Icon(Icons.movie),
                  text: "Movie",
                ),
                Tab(
                  icon: Icon(Icons.favorite),
                  text: "Favourite",
                ),
                Tab(
                  icon: Icon(Icons.person),
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            // TestTab(),
            MoviePage(),
            MovieFavouritePage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
