import 'package:archivist/db/database.dart';
import 'package:archivist/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert' show utf8;

import '../db/use_database.dart';
import '../main.dart';
import '../nav_bar.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({super.key, required this.game});

  final GameItem game;


  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  bool called = false;
  String imageUrl =
      "https://placehold.co/1080x1920/png"; // TODO replace with loading? idk
  Container container = Container(
    height: 100,
    width: double.infinity,
    decoration: const BoxDecoration(

        /*    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('https://images.igdb.com/igdb/image/upload/t_1080p/arku8.webp'),
                  ) */
        color: Colors.grey),
  );
  List<Text> platforms = [];

  void getGameData() async {
    if (!called) {
      gamesApi?.getCoverUrl(widget.game.cover!, size: "1080p").then((url) {
        setState(() {
          imageUrl = url;
        });
        //print(imageUrl);
      });

      gamesApi?.getArtworkUrl(widget.game.igdbID).then((url) {
        //print(url);
        if (url != null) {
          setState(() {
            container = Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(url),
              )),
            );
          });
        }
      });

      List<String>? platformsInt = widget.game.platforms
          ?.replaceFirst("[", '')
          .replaceFirst("]", '')
          .split(",");
      if (platformsInt != null && platformsInt.isNotEmpty) {
        for (String platformNum in platformsInt) {
          platforms.add(
              Text(gamesApi!.getPlatform(int.parse(platformNum)) as String));
        }
      }

      called = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var game = widget.game;


    getGameData();

    // populates notes field with notes data if there already is data
    TextEditingController notesField = TextEditingController();
    TextEditingController statusDropdown = TextEditingController();
    if (game.notes != null) notesField.text = game.notes.toString();
    statusDropdown.text = statusMap[game.status]!;

    String gameSummary = game.summary as String;


    return Scaffold(
        appBar: NavBar().buildAppBar(context, game.name),
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
            height: double.infinity,
            width: 1600,
            child: Wrap(
              runAlignment: WrapAlignment.start,
              spacing: 20,
              children: [
                container,
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Image.network(
                          imageUrl,
                          scale: 3.0,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(game.name),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownMenu(
                          controller: statusDropdown,
                            label: const Text('Status'),
                            dropdownMenuEntries: <DropdownMenuEntry<Status>>[
                              DropdownMenuEntry(
                                  value: Status.planning, label: statusMap[Status.planning].toString()),
                              DropdownMenuEntry(
                                  value: Status.playing, label: statusMap[Status.playing].toString()),
                              DropdownMenuEntry(
                                  value: Status.finished, label: statusMap[Status.finished].toString()),
                              DropdownMenuEntry(
                                  value: Status.completed, label: statusMap[Status.completed].toString())
                            ],
                          onSelected: (status){
                            db.update(id: game.id, status: status);
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                          child: Text(utf8.decode(gameSummary.codeUnits)),
                        ),
                        Column(
                          children: [
                            const Text('Platforms'),
                            Card(
                              child: Column(
                                children: platforms,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                                'Release Date: ${game.releaseDate?.year}')
                          ],
                        ),
                      ],
                    )),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: notesField,
                  minLines: 3,
                  maxLines: 20,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Notes'),
                  onChanged: (value) {
                    db.update(id: game.id, notes: value);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
