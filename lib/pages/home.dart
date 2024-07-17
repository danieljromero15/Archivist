import 'package:archivist/pages/description.dart';
import 'package:archivist/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../db/database.dart';
import '../db/use_database.dart';
import '../main.dart';
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
  bool called = false;
  List<GameItem> data = [];
  Map<int, String> coverUrls = <int, String>{};

  void getDBData() async {
    if (!called) {
      db.getAll().then((response) {
        //print(response);
        //print(response?[0].cover);
        if (response!.isNotEmpty) {
          gamesApi?.getCoverUrls(response).then((i) {
            //print(i);
            setState(() {
              //print(response.runtimeType);
              data = response;
              coverUrls = i!;
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
    //db().test();
    getDBData();

    return Scaffold(
      appBar: NavBar().buildAppBar(context, widget.title),
      drawer: NavBar().buildDrawer(context),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 1600,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 10.0,
                alignment: WrapAlignment.spaceEvenly,
                //TODO implement onPressed
                children: [
                  const ElevatedButton(onPressed: null, child: Text('All')),
                  ElevatedButton(onPressed: null, child: Text(statusMap[Status.planning]!)),
                  ElevatedButton(onPressed: null, child: Text(statusMap[Status.playing]!)),
                  ElevatedButton(onPressed: null, child: Text(statusMap[Status.finished]!)),
                  ElevatedButton(onPressed: null, child: Text(statusMap[Status.completed]!)),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Text('Planning'), //TODO replace with current page
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.extent(
                  maxCrossAxisExtent: 150,
                  children: List.generate(coverUrls.length, (index) {
                    return Center(
                        child: IconButton(
                      /*style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        disabledForegroundColor: Colors.transparent,
                        disabledBackgroundColor: Colors.transparent,
                      ),*/
                      onPressed: () {
                        Navigator.of(context).push(PageTransition(
                            child: DescriptionPage(game: data[index]),
                            type: PageTransitionType.fade));
                      },
                      icon: Image.network(coverUrls[data[index].igdbID]!),
                      iconSize: 50,
                      tooltip: getTooltip(data[index].name,
                          year: data[index].releaseDate?.year),
                    ));
                  }),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(PageTransition(
              child: const SearchPage(), type: PageTransitionType.fade));
        },
        tooltip: 'Search',
        child: const Icon(Icons.search),
      ),
    );
  }
}
