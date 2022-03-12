// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:simple_app/Screen/test_screen/home_tab.dart';
import 'package:simple_app/Screen/test_screen/category_tab.dart';
import 'package:simple_app/Screen/test_screen/market_tab.dart';
import 'package:simple_app/Screen/test_screen/tab4.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SafeArea(
          child: _tabController(),
        ),
      ),
    );
  }

  DefaultTabController _tabController() {
    return DefaultTabController(
      length: 5,
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
            Tab(
              text: 'Tab 3',
            ),
            Tab(
              text: 'Tab 4',
            ),
            Tab(
              text: 'Tab 5',
            ),
          ],
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: FirstTab(),
            ),
            const CategoryTab(),
            MarketTab(),
            TestGridView(),
            HomePageView(),
          ],
        ),
      ),
    );
  }
}

//--------------------------State-------------------------
class AnimationButton extends StatefulWidget {
  const AnimationButton({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimationButtonState();
}

class _AnimationButtonState extends State {
  bool _isShow = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _isShow = !_isShow;
              });
            },
            child: const Text('animation'),
          ),
          duration: const Duration(milliseconds: 500),
          bottom: _isShow ? 32 : 200,
        ),
      ],
    );
  }
}
