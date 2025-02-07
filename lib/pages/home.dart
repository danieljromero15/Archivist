import 'package:archivist/pages/description.dart';
import 'package:archivist/pages/search.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../db/database.dart' as database;
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
  Status? status;
  bool called = false;
  bool received = false;
  bool alphaOrder = false;
  List<database.GameItem> data = [];
  Map<int, String> coverUrls = <int, String>{};

  void changePage(Status? status) {
    this.status = status;
    called = false;
    getDBData();
  }

  void getDBData({bool alphabeticalOrder = false}) async {
    if (!called) {
      db.getAll(status: status).then((response) {
        if (response.isNotEmpty) {
          gamesApi?.getCoverUrls(response).then((i) {
            if (alphaOrder) {
              response.sort((a, b) => a.name
                  .toString()
                  .toLowerCase()
                  .compareTo(b.name.toString().toLowerCase()));
            }
            setState(() {
              data = response;
              coverUrls = i!;
              received = true;
            });
          });
        } else {
          setState(() {
            data = response;
            coverUrls.clear();
            received = true;
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
    getDBData(alphabeticalOrder: alphaOrder);

    //print(status);

    dynamic body;

    if (!received) {
      body = const CircularProgressIndicator();
    } else {
      body = Expanded(
        child: GridView.extent(
          maxCrossAxisExtent: 150,
          children: List.generate(coverUrls.length, (index) {
            return Center(
                child: GestureDetector(
              onSecondaryTapDown: (details) {
                _showPopupMenu(context, details.globalPosition, data[index].id);
              },
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
                //icon: Image.network(coverUrls[data[index].igdbID]!),
                icon: CachedNetworkImage(
                  imageUrl: coverUrls[data[index].igdbID]!,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                iconSize: 50,
                tooltip: getTooltip(data[index].name,
                    year: data[index].releaseDate?.year),
              ),
            ));
          }),
        ),
      );
    }

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
                children: [
                  DropdownButton(
                      focusColor: Theme.of(context).scaffoldBackgroundColor,
                      icon: const Icon(Icons.sort),
                      hint: const Text("Sort"),
                      items: const [
                        DropdownMenuItem(value: 0, child: Text('Last Added')),
                        DropdownMenuItem(value: 1, child: Text('Alphabetical')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _handleSortListOutput(context, value!);
                        });
                      }),
                  ElevatedButton(
                      onPressed: () {
                        changePage(null);
                      },
                      child: const Text('All')),
                  ElevatedButton(
                      onPressed: () {
                        changePage(Status.planning);
                      },
                      child: Text(statusMap[Status.planning]!)),
                  ElevatedButton(
                      onPressed: () {
                        changePage(Status.playing);
                      },
                      child: Text(statusMap[Status.playing]!)),
                  ElevatedButton(
                      onPressed: () {
                        changePage(Status.finished);
                      },
                      child: Text(statusMap[Status.finished]!)),
                  ElevatedButton(
                      onPressed: () {
                        changePage(Status.completed);
                      },
                      child: Text(statusMap[Status.completed]!)),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Text(statusMap[status]!),
              const SizedBox(
                height: 10,
              ),
              body,
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

  void _showPopupMenu(BuildContext context, Offset offset, int id) {
    showMenu(
        context: context,
        position:
            RelativeRect.fromLTRB(offset.dx, offset.dy, offset.dx, offset.dy),
        items: [
          const PopupMenuItem(value: 0, child: Text('Delete')
              //TODO Undo feature
              )
        ]).then((value) {
      if (value != null) {
        _handleMenuItemClick(context, id, value);
      }
    });
  }

  _handleMenuItemClick(BuildContext context, int id, int value) {
    db.delete(id: id);
    changePage(status);
    showSnackBar(context, text: 'Deleted from library');
  }

  //TODO Fill this function
  _handleSortListOutput(BuildContext context, int output) {
    switch (output) {
      case 0:
        //code
        setState(() {
          alphaOrder = false;
        });
        changePage(status);
        showSnackBar(context, text: 'Sorted by Last Added');
        break;
      case 1:
        //code
        setState(() {
          alphaOrder = true;
        });
        changePage(status);
        showSnackBar(context, text: 'Sorted Alphabetically');
        break;
      default:
        break;
    }
  }
}
