import 'package:archivist/api/igdb_api.dart';
import 'package:archivist/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';

import '../db/database.dart';
import '../db/use_database.dart';
import '../nav_bar.dart';
import '../json_types.dart';

class DescriptionPage extends StatefulWidget {
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
      body:
        Column(
          children: [
            Card(
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(

                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('https://images.igdb.com/igdb/image/upload/t_1080p/arku8.webp'),
                      colorFilter: ColorFilter.mode(
                          Colors.black, BlendMode.softLight)
                  )
                  ),
                ),
              ),
            const SizedBox(height: 20,),
            const Wrap(
              spacing: 10,
              direction: Axis.horizontal,
              verticalDirection: VerticalDirection.down,
              children: [
                Image(image: NetworkImage(scale: 1.2, 'https://images.igdb.com/igdb/image/upload/t_cover_big/co6p5e.webp')
                ),
                Text('Doki Doki Literature Club'),
                Text('The Literature Club is full of cute girls! Will you write the way into their heart? This game is not suitable for children or those who are easily disturbed.'),

              ],
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text('Releases'),
                  Card()
                ],
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Notes'
              ),
            ),
          ],
        ),
    );
  }
}