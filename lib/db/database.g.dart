// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
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
  static const VerificationMeta _igdbIDMeta = const VerificationMeta('igdbID');
  @override
  late final GeneratedColumn<int> igdbID = GeneratedColumn<int>(
      'igdb_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
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
  static const VerificationMeta _summaryMeta =
      const VerificationMeta('summary');
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
      'summary', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _platformsMeta =
      const VerificationMeta('platforms');
  @override
  late final GeneratedColumn<String> platforms = GeneratedColumn<String>(
      'platforms', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<Status, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Status>($GameItemsTable.$converterstatus);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, igdbID, name, releaseDate, cover, summary, platforms, status, notes];
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
    if (data.containsKey('igdb_i_d')) {
      context.handle(_igdbIDMeta,
          igdbID.isAcceptableOrUnknown(data['igdb_i_d']!, _igdbIDMeta));
    } else if (isInserting) {
      context.missing(_igdbIDMeta);
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
    if (data.containsKey('summary')) {
      context.handle(_summaryMeta,
          summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta));
    }
    if (data.containsKey('platforms')) {
      context.handle(_platformsMeta,
          platforms.isAcceptableOrUnknown(data['platforms']!, _platformsMeta));
    }
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
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
      igdbID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}igdb_i_d'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      releaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}release_date']),
      cover: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cover']),
      summary: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary']),
      platforms: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}platforms']),
      status: $GameItemsTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $GameItemsTable createAlias(String alias) {
    return $GameItemsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Status, int, int> $converterstatus =
      const EnumIndexConverter<Status>(Status.values);
}

class GameItem extends DataClass implements Insertable<GameItem> {
  final int id;
  final int igdbID;
  final String name;
  final DateTime? releaseDate;
  final int? cover;
  final String? summary;
  final String? platforms;
  final Status status;
  final String? notes;
  const GameItem(
      {required this.id,
      required this.igdbID,
      required this.name,
      this.releaseDate,
      this.cover,
      this.summary,
      this.platforms,
      required this.status,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['igdb_i_d'] = Variable<int>(igdbID);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<DateTime>(releaseDate);
    }
    if (!nullToAbsent || cover != null) {
      map['cover'] = Variable<int>(cover);
    }
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    if (!nullToAbsent || platforms != null) {
      map['platforms'] = Variable<String>(platforms);
    }
    {
      map['status'] =
          Variable<int>($GameItemsTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  GameItemsCompanion toCompanion(bool nullToAbsent) {
    return GameItemsCompanion(
      id: Value(id),
      igdbID: Value(igdbID),
      name: Value(name),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      cover:
          cover == null && nullToAbsent ? const Value.absent() : Value(cover),
      summary: summary == null && nullToAbsent
          ? const Value.absent()
          : Value(summary),
      platforms: platforms == null && nullToAbsent
          ? const Value.absent()
          : Value(platforms),
      status: Value(status),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory GameItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameItem(
      id: serializer.fromJson<int>(json['id']),
      igdbID: serializer.fromJson<int>(json['igdbID']),
      name: serializer.fromJson<String>(json['name']),
      releaseDate: serializer.fromJson<DateTime?>(json['releaseDate']),
      cover: serializer.fromJson<int?>(json['cover']),
      summary: serializer.fromJson<String?>(json['summary']),
      platforms: serializer.fromJson<String?>(json['platforms']),
      status: $GameItemsTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'igdbID': serializer.toJson<int>(igdbID),
      'name': serializer.toJson<String>(name),
      'releaseDate': serializer.toJson<DateTime?>(releaseDate),
      'cover': serializer.toJson<int?>(cover),
      'summary': serializer.toJson<String?>(summary),
      'platforms': serializer.toJson<String?>(platforms),
      'status': serializer
          .toJson<int>($GameItemsTable.$converterstatus.toJson(status)),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  GameItem copyWith(
          {int? id,
          int? igdbID,
          String? name,
          Value<DateTime?> releaseDate = const Value.absent(),
          Value<int?> cover = const Value.absent(),
          Value<String?> summary = const Value.absent(),
          Value<String?> platforms = const Value.absent(),
          Status? status,
          Value<String?> notes = const Value.absent()}) =>
      GameItem(
        id: id ?? this.id,
        igdbID: igdbID ?? this.igdbID,
        name: name ?? this.name,
        releaseDate: releaseDate.present ? releaseDate.value : this.releaseDate,
        cover: cover.present ? cover.value : this.cover,
        summary: summary.present ? summary.value : this.summary,
        platforms: platforms.present ? platforms.value : this.platforms,
        status: status ?? this.status,
        notes: notes.present ? notes.value : this.notes,
      );
  @override
  String toString() {
    return (StringBuffer('GameItem(')
          ..write('id: $id, ')
          ..write('igdbID: $igdbID, ')
          ..write('name: $name, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('cover: $cover, ')
          ..write('summary: $summary, ')
          ..write('platforms: $platforms, ')
          ..write('status: $status, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, igdbID, name, releaseDate, cover, summary, platforms, status, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameItem &&
          other.id == this.id &&
          other.igdbID == this.igdbID &&
          other.name == this.name &&
          other.releaseDate == this.releaseDate &&
          other.cover == this.cover &&
          other.summary == this.summary &&
          other.platforms == this.platforms &&
          other.status == this.status &&
          other.notes == this.notes);
}

class GameItemsCompanion extends UpdateCompanion<GameItem> {
  final Value<int> id;
  final Value<int> igdbID;
  final Value<String> name;
  final Value<DateTime?> releaseDate;
  final Value<int?> cover;
  final Value<String?> summary;
  final Value<String?> platforms;
  final Value<Status> status;
  final Value<String?> notes;
  const GameItemsCompanion({
    this.id = const Value.absent(),
    this.igdbID = const Value.absent(),
    this.name = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.cover = const Value.absent(),
    this.summary = const Value.absent(),
    this.platforms = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
  });
  GameItemsCompanion.insert({
    this.id = const Value.absent(),
    required int igdbID,
    required String name,
    this.releaseDate = const Value.absent(),
    this.cover = const Value.absent(),
    this.summary = const Value.absent(),
    this.platforms = const Value.absent(),
    required Status status,
    this.notes = const Value.absent(),
  })  : igdbID = Value(igdbID),
        name = Value(name),
        status = Value(status);
  static Insertable<GameItem> custom({
    Expression<int>? id,
    Expression<int>? igdbID,
    Expression<String>? name,
    Expression<DateTime>? releaseDate,
    Expression<int>? cover,
    Expression<String>? summary,
    Expression<String>? platforms,
    Expression<int>? status,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (igdbID != null) 'igdb_i_d': igdbID,
      if (name != null) 'name': name,
      if (releaseDate != null) 'release_date': releaseDate,
      if (cover != null) 'cover': cover,
      if (summary != null) 'summary': summary,
      if (platforms != null) 'platforms': platforms,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
    });
  }

  GameItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? igdbID,
      Value<String>? name,
      Value<DateTime?>? releaseDate,
      Value<int?>? cover,
      Value<String?>? summary,
      Value<String?>? platforms,
      Value<Status>? status,
      Value<String?>? notes}) {
    return GameItemsCompanion(
      id: id ?? this.id,
      igdbID: igdbID ?? this.igdbID,
      name: name ?? this.name,
      releaseDate: releaseDate ?? this.releaseDate,
      cover: cover ?? this.cover,
      summary: summary ?? this.summary,
      platforms: platforms ?? this.platforms,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (igdbID.present) {
      map['igdb_i_d'] = Variable<int>(igdbID.value);
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
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (platforms.present) {
      map['platforms'] = Variable<String>(platforms.value);
    }
    if (status.present) {
      map['status'] =
          Variable<int>($GameItemsTable.$converterstatus.toSql(status.value));
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameItemsCompanion(')
          ..write('id: $id, ')
          ..write('igdbID: $igdbID, ')
          ..write('name: $name, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('cover: $cover, ')
          ..write('summary: $summary, ')
          ..write('platforms: $platforms, ')
          ..write('status: $status, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

abstract class _$GameDB extends GeneratedDatabase {
  _$GameDB(QueryExecutor e) : super(e);
  _$GameDBManager get managers => _$GameDBManager(this);
  late final $GameItemsTable gameItems = $GameItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [gameItems];
}

typedef $$GameItemsTableInsertCompanionBuilder = GameItemsCompanion Function({
  Value<int> id,
  required int igdbID,
  required String name,
  Value<DateTime?> releaseDate,
  Value<int?> cover,
  Value<String?> summary,
  Value<String?> platforms,
  required Status status,
  Value<String?> notes,
});
typedef $$GameItemsTableUpdateCompanionBuilder = GameItemsCompanion Function({
  Value<int> id,
  Value<int> igdbID,
  Value<String> name,
  Value<DateTime?> releaseDate,
  Value<int?> cover,
  Value<String?> summary,
  Value<String?> platforms,
  Value<Status> status,
  Value<String?> notes,
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
            Value<int> igdbID = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime?> releaseDate = const Value.absent(),
            Value<int?> cover = const Value.absent(),
            Value<String?> summary = const Value.absent(),
            Value<String?> platforms = const Value.absent(),
            Value<Status> status = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              GameItemsCompanion(
            id: id,
            igdbID: igdbID,
            name: name,
            releaseDate: releaseDate,
            cover: cover,
            summary: summary,
            platforms: platforms,
            status: status,
            notes: notes,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required int igdbID,
            required String name,
            Value<DateTime?> releaseDate = const Value.absent(),
            Value<int?> cover = const Value.absent(),
            Value<String?> summary = const Value.absent(),
            Value<String?> platforms = const Value.absent(),
            required Status status,
            Value<String?> notes = const Value.absent(),
          }) =>
              GameItemsCompanion.insert(
            id: id,
            igdbID: igdbID,
            name: name,
            releaseDate: releaseDate,
            cover: cover,
            summary: summary,
            platforms: platforms,
            status: status,
            notes: notes,
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

  ColumnFilters<int> get igdbID => $state.composableBuilder(
      column: $state.table.igdbID,
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

  ColumnFilters<String> get summary => $state.composableBuilder(
      column: $state.table.summary,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get platforms => $state.composableBuilder(
      column: $state.table.platforms,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<Status, Status, int> get status =>
      $state.composableBuilder(
          column: $state.table.status,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$GameItemsTableOrderingComposer
    extends OrderingComposer<_$GameDB, $GameItemsTable> {
  $$GameItemsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get igdbID => $state.composableBuilder(
      column: $state.table.igdbID,
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

  ColumnOrderings<String> get summary => $state.composableBuilder(
      column: $state.table.summary,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get platforms => $state.composableBuilder(
      column: $state.table.platforms,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$GameDBManager {
  final _$GameDB _db;
  _$GameDBManager(this._db);
  $$GameItemsTableTableManager get gameItems =>
      $$GameItemsTableTableManager(_db, _db.gameItems);
}
