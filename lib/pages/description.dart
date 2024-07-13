import 'package:archivist/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../nav_bar.dart';

class DescriptionPage extends StatefulWidget {
  //TODO Replace title with title of game
  const DescriptionPage({super.key, this.title = 'Game Page'});

  final String title;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBar().buildAppBar(context, widget.title),
        drawer: NavBar().buildDrawer(context),
        body: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: double.infinity,
            width: 1600,
            child: Wrap(
              runAlignment: WrapAlignment.start,
              spacing: 20,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  // TODO: IF ARTWORK FOUND, MAKE THE ARTWORK REPLACE TEMP GREY
                  // TODO: IF NO ARTWORK FOUND, DECREASE HEIGHT
                  decoration: const BoxDecoration(

                      /*    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('https://images.igdb.com/igdb/image/upload/t_1080p/arku8.webp'),
                  ) */
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Column(
                      children: [
                        Image(
                            // TODO Replace temp cover with cover of actual game
                            image: NetworkImage(
                                scale: 1.2,
                                'https://images.igdb.com/igdb/image/upload/t_cover_big/co6p5e.webp')),
                        SizedBox(
                          height: 10,
                        ),
                        //TODO Replace Text with actual title of game
                        Text('Doki Doki Literature Club'),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownMenu(
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
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                          //TODO Replace temp summary with summary of game
                          child: Text(
                              'The Literature Club is full of cute girls! Will you write the way into their heart? This game is not suitable for children or those who are easily disturbed.'
                              //  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec pretium mollis gravida. Nulla ac odio vel lacus maximus aliquam gravida at lacus. Donec ac gravida augue. Phasellus vitae tortor tristique, pharetra nisi in, faucibus urna. Duis ornare orci est, vel porta nunc accumsan id. In fermentum erat sed ipsum euismod, sit amet tincidunt libero eleifend. Sed lorem nisi, maximus et lorem quis, egestas placerat nisl. Nulla leo lacus, rutrum a dignissim eget, ultricies laoreet ipsum. Duis non urna metus. Duis vitae pharetra ex, eget laoreet odio. Nam pretium at lectus id varius. Nullam laoreet purus sed erat pretium, sit amet tincidunt tellus consectetur. Donec et hendrerit urna. Mauris vitae tellus a erat tristique ultrices id eget ex.'

                              ),
                        ),
                        Column(
                          children: [
                            Text('Platforms'),
                            Card(
                              child: Column(
                                //TODO Replace platforms with platforms of game
                                children: [
                                  Text('Windows(PC)'),
                                  Text('Mac'),
                                  Text('Linux')
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            //TODO Replace release date with actual release date
                            Text('Release Date: 2016')
                          ],
                        ),
                      ],
                    )),
                    SizedBox(
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
                  maxLines: 20,
                  minLines: 3,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Notes'),
                ),
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
