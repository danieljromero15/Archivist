import 'package:archivist/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'api/igdb_api.dart';
import 'db/database.dart';
import 'pages/home.dart';

GameDB? database;
IGDBApi? gamesApi;

enum Status {
  planning,
  playing,
  finished, // completed on frontend
  completed, // 100% on frontend
}

// changes here are reflected across the rest of the program
Map<Status?, String> statusMap = {
  null: "All",
  Status.planning: "Planning",
  Status.playing: "Playing",
  Status.finished: "Completed",
  Status.completed: "100%",
};

dynamic firstPage;

Future<void> main() async {
  await Settings.init();

  database = GameDB();
  gamesApi = IGDBApi();

  if(!await gamesApi!.test()) {
    firstPage = const SettingsPage();
  } else {
    firstPage = const HomePage(title: 'Archivist Home Page');
  }

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
      home: firstPage,
    );
  }
}

String getTooltip(String name, {int? unixTimestamp, int? year}) {
  String
      message; // originally returned a tooltip but turns out iconbuttons don't actually use tooltips yay
  if (unixTimestamp != null) {
    String time = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000)
        .year
        .toString();
    message = "$name ($time)";
  } else if (year != null) {
    message = "$name ($year)";
  } else {
    message = name;
  }
  return message;
}

void showSnackBar(BuildContext context, {required String text, Duration duration = Durations.long4}) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(SnackBar(
    content: Text(text),
    duration: duration,
    showCloseIcon: true,
  ));
}
