import 'package:archivist/db/database.dart';
import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';

import '../json_types.dart';
import '../main.dart';

class db {
  static void list() async {
    List<GameItem>? allItems =
        await database?.select(database!.gameItems).get();
    print('items in database: $allItems');
  }

  static void insert(Json game) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (!(await database!.managers.gameItems
        .filter((f) => f.igdbID(game['id']))
        .exists())) {
      await database
          ?.into(database!.gameItems)
          .insert(GameItemsCompanion.insert(
            igdbID: game['id'],
            name: game['name'],
            releaseDate: Value(DateTime.fromMillisecondsSinceEpoch(
                game['first_release_date'] * 1000)),
            cover: Value(game['cover']),
            summary: Value(game['summary']),
            status: const Value(0),
          ));
      //list();
    } else {
      print("Error: entry already exists");
    }
  }

  static Future<List<GameItem>?> get() async {
    List<GameItem>? allItems =
        await database?.select(database!.gameItems).get();
    return allItems;
  }

  static void deleteAll() async {
    WidgetsFlutterBinding.ensureInitialized();
    await database?.managers.gameItems.delete();
    print("Database cleared!");
    list();
  }
}
