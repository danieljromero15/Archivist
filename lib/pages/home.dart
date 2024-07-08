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
  int searchLen = 1;
  List<dynamic> searchList = [{'id': 740, 'cover': 128403, 'first_release_date': 1005782400, 'name': 'Halo: Combat Evolved'}];

  void search() {
    IGDBApi().searchGames("Halo").then((r) {
      setState(() {
        searchLen = r.length;
        searchList = r;
      });
    });
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

    search();
    return Scaffold(
        appBar: NavBar().buildAppBar(context, widget.title),
        drawer: NavBar().buildDrawer(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Search',
          child: const Icon(Icons.search),
        ), // This trailing comma makes auto-formatting nicer for build methods.
        body: GridView.count(
          crossAxisCount: searchLen,
          children: List.generate(searchLen, (index) {
            return Center(
              child: Text(
                '${searchList[index]['name']}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            );
          }),
        ));
  }
}
