import 'package:archivist/api/igdb_api.dart';
import 'package:archivist/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../db/database.dart';
import '../db/use_database.dart';
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
  List<GameItem> data = [];
  List<String> coverUrls = [];

  void getDBData() async{
    db.get().then((response) {
      //print(response);
      //print(response?[0].cover);
      IGDBApi().getCoverUrls(response!).then((i) {
        //print(i);
        setState(() {
          //print(response.runtimeType);
          data = response;
          coverUrls = i;
        });
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
    //db().test();
    getDBData();


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
        ),
        //body: Text('hi')
        body: data.isNotEmpty? GridView.count(
          crossAxisCount: (data.length).round(),
          children: List.generate(coverUrls.length, (index) {
            return Center(
              //child: Image.network(coversList[index]),
                child: IconButton(
                  icon: Image.network(coverUrls[index]),
                  iconSize: 50,
                  onPressed: (){
                    print(data[index]);
                  },
                )
            );
          }),
        ) : const Text("") // TODO replace with loading icon?
    );
  }
}
