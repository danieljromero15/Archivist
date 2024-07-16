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
  Map<int, String> coversList = <int, String>{};

  void getGames() {
    if (!called) {
      if (coversList.isNotEmpty) coversList.clear();
      gamesApi?.searchGames("Final Fantasy", limit: 25).then((r) {
        gamesApi?.getCoverUrls(r).then((urls) {
          setState(() {
            gamesList = r;
            coversList = urls!;
          });
          //print(gamesList);
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
        body: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 1600,
            child: Column(
              children: [
                const Wrap(
                  children: [
                    SizedBox(
                      width: 800,
                      child: TextField(
                        minLines: 1,
                        maxLines: 1,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: 'search'),
                      ),
                    ),
                    ElevatedButton(
                        /*  style: ElevatedButton.styleFrom(
                        fixedSize: Size(200, 200)
                      ),*/
                        onPressed: null,
                        child: Icon(Icons.search))
                  ],
                ),
                const SizedBox(height: 50),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: const Text('top games')),
                Expanded(
                    child: GridView.extent(
                  maxCrossAxisExtent: 150,
                  children: List.generate(coversList.length, (index) {
                    return Center(
                        //child: Image.network(coversList[index]),
                        child: IconButton(
                      icon: Image.network(coversList[gamesList[index]["id"]]!),
                      tooltip:
                          "${gamesList[index]['name']} (${DateTime.fromMillisecondsSinceEpoch(gamesList[index]["first_release_date"] * 1000).year})",
                      iconSize: 50,
                      onPressed: () {
                        //print(gamesList[index]['name']);
                        db.insert(gamesList[index]);
                      },
                    ));
                  }),
                )),
              ],
            ),
          ),
        ));
  }
}
