import 'package:flutter/material.dart';

class FirstTab extends StatelessWidget {
  const FirstTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32, top: 16),
            child: _titleView(),
          ),
          const HeaderHomeView(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 8, 0, 8),
            child: _headerMarket(),
          ),
          SizedBox(
            height: 100,
            child: MarketView(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 8, 0, 8),
            child: _headerFavourite(),
          ),
          FavouriteWidget(),
          GestureDetector(
            onTap: () {
              print('Go to the moon');
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _bottomWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Text _titleView() {
    return const Text(
      'HELLO WORLD',
      style: TextStyle(fontSize: 20),
    );
  }

  Text _headerMarket() {
    return const Text(
      'Market',
      style: TextStyle(fontSize: 20),
    );
  }

  Text _headerFavourite() {
    return const Text(
      'Favourite',
      style: TextStyle(fontSize: 20),
    );
  }

  Row _bottomWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.ac_unit),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text('Go to the moon'),
        )
      ],
    );
  }
}

class HeaderHomeView extends StatelessWidget {
  const HeaderHomeView({Key? key, required this.color}) : super(key: key);

  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _createRow(context),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _createRow(context),
        ),
      ],
    );
  }

  Row _createRow(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _firstContent(context),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _firstContent(context),
        ),
      ],
    );
  }

  DecoratedBox _firstContent(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 48;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 10),
        ],
      ),
      child: SizedBox(
        width: width / 2,
        height: 100,
        child: Center(child: Text(color.toString())),
      ),
    );
  }
}

class MarketView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) => Card(
        color: Colors.yellow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const SizedBox(
          width: 100,
          child: Center(
            child: Text('Market'),
          ),
        ),
      ),
    );
  }
}

class FavouriteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _rowContent(
            CoinModel('BitCoin', '\$10000', 'assets/images/bitcoin.png')),
        _rowContent(
            CoinModel('DogeCoin', '\$1000', 'assets/images/dogecoin.png')),
        _rowContent(
            CoinModel('Ethereum', '\$100', 'assets/images/etherium.jpg')),
      ],
    );
  }

  Padding _rowContent(CoinModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 10),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _nameContent(model.name),
            ),
            const Spacer(),
            _nameContent(model.value),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: _iconContent(model.icon)),
          ],
        ),
      ),
    );
  }

  SizedBox _nameContent(String text) {
    return SizedBox(
      height: 50,
      child: Center(
          child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      )),
    );
  }

  SizedBox _iconContent(String text) {
    return SizedBox(
      height: 50,
      child: Image.asset(
        text,
        width: 30,
        height: 30,
      ),
    );
  }
}

class CoinModel {
  final String name;
  final String value;
  final String icon;

  CoinModel(this.name, this.value, this.icon);
}
