import 'dart:math';

import 'package:flutter/material.dart';

class TestTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200.0,
          height: 100.0,
          color: Colors.green,
          padding: EdgeInsets.all(35),
          margin: EdgeInsets.all(20),
          alignment: Alignment.bottomRight,
          child: Text("Hello! I am in the container widget",
              style: TextStyle(fontSize: 25)),
        ),
        Container(
          width: 200.0,
          height: 100.0,
          color: Colors.green,
          padding: EdgeInsets.all(35),
          margin: EdgeInsets.all(20),
          alignment: Alignment.bottomRight,
          transform: Matrix4.rotationZ(0.1),
          child: Text("Hello! I am in the container widget",
              style: TextStyle(fontSize: 25)),
        )
      ],
    );
  }
}

class TestGridView extends StatelessWidget {
  Widget removePaddingGridView(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            // margin: EdgeInsets.zero,
            color: Colors.amber,
            child: Center(child: Text('$index')),
          );
        },
      ),
    );
  }

  Widget normalGridView() {
    return GridView.count(
      primary: false,
      // padding: const EdgeInsets.all(20),
      // crossAxisSpacing: 10,
      // mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text("He'd have you all unravel at the"),
          color: Colors.teal[100],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Heed not the rabble'),
          color: Colors.teal[200],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Sound of screams but the'),
          color: Colors.teal[300],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Who scream'),
          color: Colors.teal[400],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Revolution is coming...'),
          color: Colors.teal[500],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Revolution, they...'),
          color: Colors.teal[600],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return removePaddingGridView(context);
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _count = 0; // used by StreamBuilder

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildFutureBuilder(),
          SizedBox(height: 24),
          _buildStreamBuilder(),
        ],
      ),
    );
  }

  // constructing FutureBuilder
  Widget _buildFutureBuilder() {
    return Center(
      child: FutureBuilder<int>(
        future: _calculateSquare(10),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return Text("Square = ${snapshot.data}");

          return CircularProgressIndicator();
        },
      ),
    );
  }

  // used by FutureBuilder
  Future<int> _calculateSquare(int num) async {
    await Future.delayed(Duration(seconds: 5));
    return num * num;
  }

  // constructing StreamBuilder
  Widget _buildStreamBuilder() {
    return Center(
      child: StreamBuilder<int>(
        stream: _stopwatch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active)
            return Text("Stopwatch = ${snapshot.data}");

          return CircularProgressIndicator();
        },
      ),
    );
  }

  // used by StreamBuilder
  Stream<int> _stopwatch() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield _count++;
    }
  }
}

class TestTab1 extends StatelessWidget {
  final List<String> entries = <String>[
    'images/bitcoin.png',
    'images/dogecoin.png',
    'images/etherium.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 1000,
        itemBuilder: (BuildContext context, int index) {
          final img = Random().nextInt(2);
          return Container(
            height: 50,
            child: Center(
                child: Row(
              children: [
                Image.asset(entries[img]),
                Text('Entry $index'),
              ],
            )),
          );
        });
  }
}

class HomePageView extends StatelessWidget {
  HomePageView({Key? key}) : super(key: key);

  final _controller = PageController(viewportFraction: 0.8);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(color: Colors.blue),
        ),
        Expanded(
          flex: 2,
          child: PageView.builder(
            controller: _controller,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.red,
                child: Row(children: [
                  Container(
                    margin: EdgeInsets.all(24),
                    // margin: EdgeInsets.only(right: 8),
                    // width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.yellow,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('$index'),
                    ),
                  ),
                ]),
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(color: Colors.green),
        ),
      ],
    );
  }
}
