import 'package:flutter/material.dart';
import 'package:simple_app/Utils/debouncer.dart';

class MarketTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MarketTabState();
  }
}

class _MarketTabState extends State {
  List<String> _list = [];
  List<String> _resultSearch = [];

  @override
  void initState() {
    super.initState();
    _list.clear();
    _list.add("Indian rupee");
    _list.add("United States dollar");
    _list.add("Australian dollar");
    _list.add("Euro");
    _list.add("British pound");
    _list.add("Yemeni rial");
    _list.add("Japanese yen");
    _list.add("Hong Kong dollar");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchTextField(
          list: _list,
          myValueSetter: (value) {
            setState(() {
              _resultSearch = value;
            });
          },
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'List Stock',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListStock(
            list: _resultSearch.isEmpty ? _list : _resultSearch,
          ),
        ),
      ],
    );
  }
}

class SearchTextField extends StatefulWidget {
  final ValueSetter<List<String>> myValueSetter;
  final List<String> list;

  const SearchTextField(
      {Key? key, required this.myValueSetter, required this.list})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SearchTextFieldState();
  }
}

class _SearchTextFieldState extends State<SearchTextField> {
  List<String> _searchResult = [];
  final _isSearching = false;
  final Debouncer onSearchDebouncer =
      Debouncer(delay: const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: TextField(
                style: const TextStyle(
                    // color: Colors.white,
                    ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: 'Search Stock',
                ),
                onChanged: _searchOperation,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _searchOperation(String searchText) {
    onSearchDebouncer.debounce(() {
      _searchResult = [];
      print(_searchResult.length);
      if (searchText.isEmpty) {
        widget.myValueSetter(widget.list);
        return;
      }
      if (_isSearching == false) {
        for (var i = 0; i < widget.list.length; i++) {
          String data = widget.list[i];
          print('CHECK');
          if (data.toLowerCase().contains(searchText.toLowerCase())) {
            _searchResult.add(data);
          }
        }
      }
      print(_searchResult.length);
      widget.myValueSetter(_searchResult);
    });
  }
}

class ListStock extends StatefulWidget {
  const ListStock({Key? key, required this.list}) : super(key: key);

  final List<String> list;

  @override
  State<StatefulWidget> createState() {
    return _ListStockState();
  }
}

class _ListStockState extends State<ListStock> {
  @override
  Widget build(BuildContext context) {
    return _listView();
  }

  ListView _listView() {
    return ListView.builder(
      itemBuilder: (context, position) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget.list[position],
              style: const TextStyle(fontSize: 20),
            ),
          ),
        );
      },
      itemCount: widget.list.length,
    );
  }
}
