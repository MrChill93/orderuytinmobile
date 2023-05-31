import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/orders.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late var findOrder = TextEditingController();

  onFindOrder(String orderNo) async {
    await fetchFoundOrder(http.Client(), orderNo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Search Example"),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchItem());
              }),
        ],
      ),
    );
  }
}

final List<String> myList = [
  "google",
  "IOS",
  "Android",
  "Linux",
  "MacOS",
  "Windows"
];

class SearchItem extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? myList
        : myList
            .where((p) => p.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          close(context, suggestionsList[index]);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailScreen(myList
                      .indexWhere((item) => item == suggestionsList[index]))));
        },
        title: Text(suggestionsList[index]),
      ),
      itemCount: suggestionsList.length,
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {});
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
}

class DetailScreen extends StatelessWidget {
  final int index;

  const DetailScreen(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(myList[index]),
        ),
        body: Center(
          child: Text(
            myList[index],
            style: const TextStyle(fontSize: 22),
          ),
        ));
  }
}
