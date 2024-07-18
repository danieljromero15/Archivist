import 'package:archivist/db/database.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../db/use_database.dart';
import '../json_types.dart';
import '../main.dart';
import '../nav_bar.dart';
import 'description.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.title = 'Search'});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool called = false;
  JsonList gamesList = [];
  String topText = "Top Games";
  String query = ''; // literally only used for search button right now lol

  void getGames(String? query) {
    if (!called) {
      if (query == null) {
        // top games
        gamesApi?.getTopGames().then((r) {
          setCoverUrls(r);
        });
      } else {
        gamesApi?.searchGames(query, limit: 50).then((r) {
          if (r.isEmpty) {
            //TODO a toast about no games found or something
          }
          setCoverUrls(r);
        });

        setState(() {
          topText = "Search for \"$query\"";
        });
      }
      called = true;
    }
  }

  void setCoverUrls(JsonList gamesList) {
    //TODO generate text covers if no image (replace removewhere?)
    //setCoverUrls
    //if (coversList.isNotEmpty) coversList.clear();
    gamesApi?.getCoverUrls(gamesList, size: "cover_big").then((urls) {
      if (urls != null) {
        for (dynamic game in gamesList) {
          if (urls.containsKey(game['id'])) {
            game['cover_url'] = urls[game['id']];
          }
        }

        gamesList.removeWhere((item) => item['cover_url'] == null);

        setState(() {
          this.gamesList = gamesList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //gamesApi.test();
    getGames(null);

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
                Wrap(
                  children: [
                    SizedBox(
                      width: 800,
                      child: TextField(
                        minLines: 1,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), hintText: 'search'),
                        onSubmitted: (value) {
                          called = false;
                          getGames(value);
                        },
                        onChanged: (value) {
                          query = value;
                        },
                      ),
                    ),
                    ElevatedButton(
                        //TODO add padding
                        /*  style: ElevatedButton.styleFrom(
                        fixedSize: Size(200, 200)
                      ),*/
                        onPressed: () {
                          called = false;
                          getGames(query);
                        },
                        child: const Icon(Icons.search))
                  ],
                ),
                const SizedBox(height: 50),
                Align(alignment: Alignment.centerLeft, child: Text(topText)),
                Expanded(
                    child: GridView.extent(
                  maxCrossAxisExtent: 150,
                  children: List.generate(gamesList.length, (index) {
                    return Center(
                        //child: Image.network(coversList[index]),
                      //TODO Have status properly update when selecting option, currently only adds to database with planning status
                        child: PopupMenuButton(
                      icon: Image.network(gamesList[index]["cover_url"]),
                      tooltip: getTooltip(gamesList[index]['name'],
                          unixTimestamp: gamesList[index]
                              ["first_release_date"]),
                      iconSize: 50,
                      onSelected: (status) {
                        //print(gamesList[index]['name']);
                        db.insert(gamesList[index]);
                      },
                          itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem<Status>(
                              value: Status.planning,
                              child: Text('Planning')
                          ),
                          const PopupMenuItem(
                              value: Status.playing,
                              child: Text('Playing')
                          ),
                          const PopupMenuItem(
                              value: Status.finished,
                              child: Text('Completed')
                          ),
                          const PopupMenuItem(
                              value: Status.completed,
                              child: Text('100%')
                          )
                        ];
                          },
                    )
                    );
                  }),
                )),
              ],
            ),
          ),
        ));
  }
}
