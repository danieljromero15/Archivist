// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $GameCategoryTable extends GameCategory
    with TableInfo<$GameCategoryTable, GameCategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameCategoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _statusNameMeta =
      const VerificationMeta('statusName');
  @override
  late final GeneratedColumn<String> statusName = GeneratedColumn<String>(
      'status_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, statusName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_category';
  @override
  VerificationContext validateIntegrity(Insertable<GameCategoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('status_name')) {
      context.handle(
          _statusNameMeta,
          statusName.isAcceptableOrUnknown(
              data['status_name']!, _statusNameMeta));
    } else if (isInserting) {
      context.missing(_statusNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameCategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameCategoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      statusName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status_name'])!,
    );
  }

  @override
  $GameCategoryTable createAlias(String alias) {
    return $GameCategoryTable(attachedDatabase, alias);
  }
}

class GameCategoryData extends DataClass
    implements Insertable<GameCategoryData> {
  final int id;
  final String statusName;
  const GameCategoryData({required this.id, required this.statusName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['status_name'] = Variable<String>(statusName);
    return map;
  }

  GameCategoryCompanion toCompanion(bool nullToAbsent) {
    return GameCategoryCompanion(
      id: Value(id),
      statusName: Value(statusName),
    );
  }

  factory GameCategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameCategoryData(
      id: serializer.fromJson<int>(json['id']),
      statusName: serializer.fromJson<String>(json['statusName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'statusName': serializer.toJson<String>(statusName),
    };
  }

  GameCategoryData copyWith({int? id, String? statusName}) => GameCategoryData(
        id: id ?? this.id,
        statusName: statusName ?? this.statusName,
      );
  @override
  String toString() {
    return (StringBuffer('GameCategoryData(')
          ..write('id: $id, ')
          ..write('statusName: $statusName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, statusName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameCategoryData &&
          other.id == this.id &&
          other.statusName == this.statusName);
}

class GameCategoryCompanion extends UpdateCompanion<GameCategoryData> {
  final Value<int> id;
  final Value<String> statusName;
  const GameCategoryCompanion({
    this.id = const Value.absent(),
    this.statusName = const Value.absent(),
  });
  GameCategoryCompanion.insert({
    this.id = const Value.absent(),
    required String statusName,
  }) : statusName = Value(statusName);
  static Insertable<GameCategoryData> custom({
    Expression<int>? id,
    Expression<String>? statusName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (statusName != null) 'status_name': statusName,
    });
  }

  GameCategoryCompanion copyWith({Value<int>? id, Value<String>? statusName}) {
    return GameCategoryCompanion(
      id: id ?? this.id,
      statusName: statusName ?? this.statusName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (statusName.present) {
      map['status_name'] = Variable<String>(statusName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameCategoryCompanion(')
          ..write('id: $id, ')
          ..write('statusName: $statusName')
          ..write(')'))
        .toString();
  }
}

class $GameItemsTable extends GameItems
    with TableInfo<$GameItemsTable, GameItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<DateTime> releaseDate = GeneratedColumn<DateTime>(
      'release_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _coverMeta = const VerificationMeta('cover');
  @override
  late final GeneratedColumn<int> cover = GeneratedColumn<int>(
      'cover', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES game_category (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, name, releaseDate, cover, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_items';
  @override
  VerificationContext validateIntegrity(Insertable<GameItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    }
    if (data.containsKey('cover')) {
      context.handle(
          _coverMeta, cover.isAcceptableOrUnknown(data['cover']!, _coverMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      releaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}release_date']),
      cover: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cover']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status']),
    );
  }

  @override
  $GameItemsTable createAlias(String alias) {
    return $GameItemsTable(attachedDatabase, alias);
  }
}

class GameItem extends DataClass implements Insertable<GameItem> {
  final int id;
  final String name;
  final DateTime? releaseDate;
  final int? cover;
  final int? status;
  const GameItem(
      {required this.id,
      required this.name,
      this.releaseDate,
      this.cover,
      this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<DateTime>(releaseDate);
    }
    if (!nullToAbsent || cover != null) {
      map['cover'] = Variable<int>(cover);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<int>(status);
    }
    return map;
  }

  GameItemsCompanion toCompanion(bool nullToAbsent) {
    return GameItemsCompanion(
      id: Value(id),
      name: Value(name),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      cover:
          cover == null && nullToAbsent ? const Value.absent() : Value(cover),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
    );
  }

  factory GameItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameItem(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      releaseDate: serializer.fromJson<DateTime?>(json['releaseDate']),
      cover: serializer.fromJson<int?>(json['cover']),
      status: serializer.fromJson<int?>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'releaseDate': serializer.toJson<DateTime?>(releaseDate),
      'cover': serializer.toJson<int?>(cover),
      'status': serializer.toJson<int?>(status),
    };
  }

  GameItem copyWith(
          {int? id,
          String? name,
          Value<DateTime?> releaseDate = const Value.absent(),
          Value<int?> cover = const Value.absent(),
          Value<int?> status = const Value.absent()}) =>
      GameItem(
        id: id ?? this.id,
        name: name ?? this.name,
        releaseDate: releaseDate.present ? releaseDate.value : this.releaseDate,
        cover: cover.present ? cover.value : this.cover,
        status: status.present ? status.value : this.status,
      );
  @override
  String toString() {
    return (StringBuffer('GameItem(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('cover: $cover, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, releaseDate, cover, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameItem &&
          other.id == this.id &&
          other.name == this.name &&
          other.releaseDate == this.releaseDate &&
          other.cover == this.cover &&
          other.status == this.status);
}

class GameItemsCompanion extends UpdateCompanion<GameItem> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime?> releaseDate;
  final Value<int?> cover;
  final Value<int?> status;
  const GameItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.cover = const Value.absent(),
    this.status = const Value.absent(),
  });
  GameItemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.releaseDate = const Value.absent(),
    this.cover = const Value.absent(),
    this.status = const Value.absent(),
  }) : name = Value(name);
  static Insertable<GameItem> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? releaseDate,
    Expression<int>? cover,
    Expression<int>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (releaseDate != null) 'release_date': releaseDate,
      if (cover != null) 'cover': cover,
      if (status != null) 'status': status,
    });
  }

  GameItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<DateTime?>? releaseDate,
      Value<int?>? cover,
      Value<int?>? status}) {
    return GameItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      releaseDate: releaseDate ?? this.releaseDate,
      cover: cover ?? this.cover,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<DateTime>(releaseDate.value);
    }
    if (cover.present) {
      map['cover'] = Variable<int>(cover.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('cover: $cover, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

abstract class _$GameDB extends GeneratedDatabase {
  _$GameDB(QueryExecutor e) : super(e);
  _$GameDBManager get managers => _$GameDBManager(this);
  late final $GameCategoryTable gameCategory = $GameCategoryTable(this);
  late final $GameItemsTable gameItems = $GameItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [gameCategory, gameItems];
}

typedef $$GameCategoryTableInsertCompanionBuilder = GameCategoryCompanion
    Function({
  Value<int> id,
  required String statusName,
});
typedef $$GameCategoryTableUpdateCompanionBuilder = GameCategoryCompanion
    Function({
  Value<int> id,
  Value<String> statusName,
});

class $$GameCategoryTableTableManager extends RootTableManager<
    _$GameDB,
    $GameCategoryTable,
    GameCategoryData,
    $$GameCategoryTableFilterComposer,
    $$GameCategoryTableOrderingComposer,
    $$GameCategoryTableProcessedTableManager,
    $$GameCategoryTableInsertCompanionBuilder,
    $$GameCategoryTableUpdateCompanionBuilder> {
  $$GameCategoryTableTableManager(_$GameDB db, $GameCategoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$GameCategoryTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$GameCategoryTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$GameCategoryTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> statusName = const Value.absent(),
          }) =>
              GameCategoryCompanion(
            id: id,
            statusName: statusName,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String statusName,
          }) =>
              GameCategoryCompanion.insert(
            id: id,
            statusName: statusName,
          ),
        ));
}

class $$GameCategoryTableProcessedTableManager extends ProcessedTableManager<
    _$GameDB,
    $GameCategoryTable,
    GameCategoryData,
    $$GameCategoryTableFilterComposer,
    $$GameCategoryTableOrderingComposer,
    $$GameCategoryTableProcessedTableManager,
    $$GameCategoryTableInsertCompanionBuilder,
    $$GameCategoryTableUpdateCompanionBuilder> {
  $$GameCategoryTableProcessedTableManager(super.$state);
}

class $$GameCategoryTableFilterComposer
    extends FilterComposer<_$GameDB, $GameCategoryTable> {
  $$GameCategoryTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get statusName => $state.composableBuilder(
      column: $state.table.statusName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter gameItemsRefs(
      ComposableFilter Function($$GameItemsTableFilterComposer f) f) {
    final $$GameItemsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.gameItems,
        getReferencedColumn: (t) => t.status,
        builder: (joinBuilder, parentComposers) =>
            $$GameItemsTableFilterComposer(ComposerState(
                $state.db, $state.db.gameItems, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$GameCategoryTableOrderingComposer
    extends OrderingComposer<_$GameDB, $GameCategoryTable> {
  $$GameCategoryTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get statusName => $state.composableBuilder(
      column: $state.table.statusName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$GameItemsTableInsertCompanionBuilder = GameItemsCompanion Function({
  Value<int> id,
  required String name,
  Value<DateTime?> releaseDate,
  Value<int?> cover,
  Value<int?> status,
});
typedef $$GameItemsTableUpdateCompanionBuilder = GameItemsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<DateTime?> releaseDate,
  Value<int?> cover,
  Value<int?> status,
});

class $$GameItemsTableTableManager extends RootTableManager<
    _$GameDB,
    $GameItemsTable,
    GameItem,
    $$GameItemsTableFilterComposer,
    $$GameItemsTableOrderingComposer,
    $$GameItemsTableProcessedTableManager,
    $$GameItemsTableInsertCompanionBuilder,
    $$GameItemsTableUpdateCompanionBuilder> {
  $$GameItemsTableTableManager(_$GameDB db, $GameItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$GameItemsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$GameItemsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$GameItemsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime?> releaseDate = const Value.absent(),
            Value<int?> cover = const Value.absent(),
            Value<int?> status = const Value.absent(),
          }) =>
              GameItemsCompanion(
            id: id,
            name: name,
            releaseDate: releaseDate,
            cover: cover,
            status: status,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<DateTime?> releaseDate = const Value.absent(),
            Value<int?> cover = const Value.absent(),
            Value<int?> status = const Value.absent(),
          }) =>
              GameItemsCompanion.insert(
            id: id,
            name: name,
            releaseDate: releaseDate,
            cover: cover,
            status: status,
          ),
        ));
}

class $$GameItemsTableProcessedTableManager extends ProcessedTableManager<
    _$GameDB,
    $GameItemsTable,
    GameItem,
    $$GameItemsTableFilterComposer,
    $$GameItemsTableOrderingComposer,
    $$GameItemsTableProcessedTableManager,
    $$GameItemsTableInsertCompanionBuilder,
    $$GameItemsTableUpdateCompanionBuilder> {
  $$GameItemsTableProcessedTableManager(super.$state);
}

class $$GameItemsTableFilterComposer
    extends FilterComposer<_$GameDB, $GameItemsTable> {
  $$GameItemsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get releaseDate => $state.composableBuilder(
      column: $state.table.releaseDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get cover => $state.composableBuilder(
      column: $state.table.cover,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$GameCategoryTableFilterComposer get status {
    final $$GameCategoryTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.status,
        referencedTable: $state.db.gameCategory,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$GameCategoryTableFilterComposer(ComposerState($state.db,
                $state.db.gameCategory, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$GameItemsTableOrderingComposer
    extends OrderingComposer<_$GameDB, $GameItemsTable> {
  $$GameItemsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get releaseDate => $state.composableBuilder(
      column: $state.table.releaseDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get cover => $state.composableBuilder(
      column: $state.table.cover,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$GameCategoryTableOrderingComposer get status {
    final $$GameCategoryTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.status,
        referencedTable: $state.db.gameCategory,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$GameCategoryTableOrderingComposer(ComposerState($state.db,
                $state.db.gameCategory, joinBuilder, parentComposers)));
    return composer;
  }
}

class _$GameDBManager {
  final _$GameDB _db;
  _$GameDBManager(this._db);
  $$GameCategoryTableTableManager get gameCategory =>
      $$GameCategoryTableTableManager(_db, _db.gameCategory);
  $$GameItemsTableTableManager get gameItems =>
      $$GameItemsTableTableManager(_db, _db.gameItems);
}
