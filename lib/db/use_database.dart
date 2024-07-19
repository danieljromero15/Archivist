import 'package:archivist/db/database.dart';
import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';

import '../json_types.dart';
import '../main.dart';

class db {
  //TODO add the ability to remove a game from the database
  static void list() async {
    List<GameItem>? allItems =
        await database!.select(database!.gameItems).get();
    print('items in database: $allItems');
  }

  static void insert(Json game, {Status status = Status.planning}) async {
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
            platforms: Value(game['platforms'].toString()),
            status: status,
          ));
      //list();
    } else {
      print("Error: entry already exists");
    }
  }

  static Future<List<GameItem>> getAll({Status? status}) async {
    List<GameItem> allItems;
    if (status == null) {
      allItems = await database!.select(database!.gameItems).get();
    } else {
      allItems = await database!.managers.gameItems
          .filter((f) => f.status.equals(status))
          .get();
    }
    return allItems;
  }

  static Future<GameItem?> get(
      {int? id,
      int? igdbID,
      String? name,
      DateTime? releaseDate,
      int? coverId}) async {
    var gameItems = database!.managers.gameItems;

    if (id != null) {
      return await gameItems.filter((f) => f.id.isIn([id])).getSingle();
    }
    if (igdbID != null) {
      return await gameItems.filter((f) => f.igdbID.isIn([igdbID])).getSingle();
    }
    if (name != null) {
      return await gameItems.filter((f) => f.name.equals(name)).getSingle();
    }
    if (releaseDate != null) {
      return await gameItems
          .filter((f) => f.releaseDate.equals(releaseDate))
          .getSingle();
    }
    if (coverId != null) {
      return await gameItems.filter((f) => f.cover.isIn([coverId])).getSingle();
    }
    return null;
  }

  static Future<void> update(
      {required int id, Status? status, String? notes}) async {
    var game =
        database!.managers.gameItems.filter((f) => f.id.isIn([id]));

    if (status != null) {
      await game.update((o) => o(status: Value(status)));
    }

    if (notes != null) {
      await game.update((o) => o(notes: Value(notes)));
    }
  }

  static void deleteAll() async {
    WidgetsFlutterBinding.ensureInitialized();
    await database!.managers.gameItems.delete();
    print("Database cleared!");
    list();
  }
}
