import 'package:flutter/material.dart';

import 'api/igdb_api.dart';
import 'db/database.dart';
import 'pages/home.dart';

GameDB? database;
IGDBApi? gamesApi;

void main() {
  database = GameDB();
  gamesApi = IGDBApi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Archivist',
      theme: ThemeData(
        // This is the theme of your application.
        // TODO: potentially change this
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Archivist Home Page'),
    );
  }
}
