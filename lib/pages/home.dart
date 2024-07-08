import 'package:archivist/api/igdb_api.dart';
import 'package:flutter/material.dart';

import '../nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.title = 'Archivist Home Page'});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //int searchLen = 1;
  bool called = false;

  // placeholders to prevent error
  /*JsonList searchList = [
    {
      'id': 740,
      'cover': 128403,
      'first_release_date': 1005782400,
      'name': 'Halo: Combat Evolved'
    }
  ];*/
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    //IGDBApi().test();

    getGames();
    return Scaffold(
        appBar: NavBar().buildAppBar(context, widget.title),
        drawer: NavBar().buildDrawer(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
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
