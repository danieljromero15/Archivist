import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../db/use_database.dart';
import '../json_types.dart';
import '../main.dart';
import '../nav_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.title = 'Search'});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool called = false;
  JsonList gamesList = [];
  List<String> coversList = [];

  void getGames() {
    if (!called) {
      if (coversList.isNotEmpty) coversList = [];
      gamesApi?.searchGames("Final Fantasy").then((r) {
        gamesApi?.getCoverUrls(r).then((urls) {
          setState(() {
            gamesList = r;
            coversList = urls;
          });
        });
      });
      called = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    //gamesApi.test();
    getGames();

    return Scaffold(
        appBar: NavBar().buildAppBar(context, widget.title),
        drawer: NavBar().buildDrawer(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(PageTransition(
                child: const SearchPage(), type: PageTransitionType.fade));
          },
          tooltip: 'Search',
          child: const Icon(Icons.search),
        ),
        body: Column(
          children: [
            Expanded(
                child: GridView.extent(
              maxCrossAxisExtent: 150,
              children: List.generate(coversList.length, (index) {
                return Center(
                    //child: Image.network(coversList[index]),
                    child: IconButton(
                  icon: Image.network(coversList[index]),
                  iconSize: 50,
                  onPressed: () {
                    db.insert(gamesList[index]);
                  },
                ));
              }),
            )),
          ],
        ));
  }
}
