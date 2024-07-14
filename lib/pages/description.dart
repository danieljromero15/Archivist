import 'package:archivist/db/database.dart';
import 'package:archivist/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';
import '../nav_bar.dart';

class DescriptionPage extends StatefulWidget {
  //TODO Replace title with title of game
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
    getGameData();

    return Scaffold(
        appBar: NavBar().buildAppBar(context, widget.game.name),
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
                        Text(widget.game.name),
                        const SizedBox(
                          height: 10,
                        ),
                        const DropdownMenu(
                            label: Text('Status'),
                            dropdownMenuEntries: <DropdownMenuEntry<Text>>[
                              //TODO Replace Text field with Statuses List
                              DropdownMenuEntry(
                                  value: Text('planning'), label: 'Planning'),
                              DropdownMenuEntry(
                                  value: Text('playing'), label: 'Playing'),
                              DropdownMenuEntry(
                                  value: Text('completed'), label: 'Completed'),
                              DropdownMenuEntry(
                                  value: Text('100%'), label: '100%')
                            ])
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                          child: Text(widget.game.summary as String),
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
                                'Release Date: ${widget.game.releaseDate?.year}')
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
                // TODO Hook up Textfield to User Notes
                const TextField(
                  minLines: 3,
                  maxLines: 20,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Notes'),
                ),
              ],
            ),
          ),
        ));
  }
}
