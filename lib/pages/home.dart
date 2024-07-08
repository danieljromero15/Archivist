import 'package:archivist/api/igdb_api.dart';
import 'package:archivist/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';

import '../db/database.dart';
import '../db/use_database.dart';
import '../nav_bar.dart';
import '../json_types.dart';

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
        body:
          Column(
            children: [
              const SizedBox(height: 10,),
              const Wrap(
                spacing: 10.0,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: null, child: Text('All')
                  ),
                  ElevatedButton(onPressed: null, child: Text('Planning')
                  ),
                  ElevatedButton(onPressed: null, child: Text('Playing')
                  ),
                  ElevatedButton(onPressed: null, child: Text('Completed')
                  ),
                  ElevatedButton(onPressed: null, child: Text('100%')
                  ),
                ],
              ),
              const SizedBox(height: 50,),
              const Text('Planning'),
              const SizedBox(height: 10,),
              Expanded(child: GridView.extent(
                
                
                maxCrossAxisExtent: 150,
                children: List.generate(coverUrls.length, (index) {
                  return Center(
                    child: ElevatedButton(style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                    ), onPressed: null, child: Image.network(coverUrls[index]), )
                  );
                }),
              ),)
            ],
          ));
  }

}
