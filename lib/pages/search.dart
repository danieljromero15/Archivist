import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../api/igdb_api.dart';
import '../nav_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.title = 'Search'});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool called = false;
  List<String> coversList = [];

  void getGames() {
    if (!called) {
      if(coversList.isNotEmpty) coversList = [];
      IGDBApi().searchGames("Final Fantasy").then((r) {
        print(r);
        for (var game in r) {
          IGDBApi().getCoverUrl(game).then((url) {
            print('adding ${game['name']}');
            setState(() {
              //searchLen = coversList.length;
              coversList.add(url);
            });
          });
        }
      });
      called = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    //IGDBApi().test();
    getGames();

    return Scaffold(
        appBar: NavBar().buildAppBar(context, widget.title),
        drawer: NavBar().buildDrawer(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(PageTransition(
                child: const SearchPage(),
                type: PageTransitionType.fade));
          },
          tooltip: 'Search',
          child: const Icon(Icons.search),
        ), // This trailing comma makes auto-formatting nicer for build methods.
        body: GridView.count(
          crossAxisCount: (coversList.length / 5).round(),
          children: List.generate(coversList.length, (index) {
            return Center(
              child: Image.network(coversList[index]),
            );
          }),
        ));
  }
}