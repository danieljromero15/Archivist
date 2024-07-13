import 'package:drift/drift.dart';

// These additional imports are necessary to open the sqlite3 database
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

class GameItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get igdbID => integer().unique()();

  TextColumn get name => text().withLength(min: 1, max: 128)();

  DateTimeColumn get releaseDate => dateTime().nullable()();

  IntColumn get cover => integer().nullable()();

  TextColumn get summary => text().nullable()();

  TextColumn get platforms => text().nullable()();

  IntColumn get status => integer().nullable().references(GameCategory, #id)();
//clientDefault((){return 0;})
}

class GameCategory extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get statusName => text()();
}

@DriftDatabase(tables: [GameItems, GameCategory])
class GameDB extends _$GameDB {
  GameDB() : super(_openConnection());

  @override
  int get schemaVersion => 2;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
