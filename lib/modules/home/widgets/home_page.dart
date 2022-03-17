import 'package:flutter/material.dart';
import 'package:simple_app/modules/movie/widgets/movie_page.dart';
import 'package:simple_app/modules/profile/widgets/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: const TabBar(
          labelColor: Colors.red,
          tabs: [
            Tab(
              text: 'Tab 1',
            ),
            Tab(
              text: 'Tab 2',
            ),
          ],
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MoviePage(),
            const ProfilePage(),
          ],
        ),
      ),
    );
  }
}
