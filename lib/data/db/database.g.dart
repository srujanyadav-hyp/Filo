// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FilesIndexTable extends FilesIndex
    with TableInfo<$FilesIndexTable, FileIndexEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FilesIndexTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uriMeta = const VerificationMeta('uri');
  @override
  late final GeneratedColumn<String> uri = GeneratedColumn<String>(
    'uri',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeMeta = const VerificationMeta('mime');
  @override
  late final GeneratedColumn<String> mime = GeneratedColumn<String>(
    'mime',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
    'size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modifiedAtMeta = const VerificationMeta(
    'modifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
    'modified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentUriMeta = const VerificationMeta(
    'parentUri',
  );
  @override
  late final GeneratedColumn<String> parentUri = GeneratedColumn<String>(
    'parent_uri',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checksumMeta = const VerificationMeta(
    'checksum',
  );
  @override
  late final GeneratedColumn<String> checksum = GeneratedColumn<String>(
    'checksum',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isIndexedMeta = const VerificationMeta(
    'isIndexed',
  );
  @override
  late final GeneratedColumn<bool> isIndexed = GeneratedColumn<bool>(
    'is_indexed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_indexed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastIndexedAtMeta = const VerificationMeta(
    'lastIndexedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastIndexedAt =
      GeneratedColumn<DateTime>(
        'last_indexed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uri,
    normalizedName,
    mime,
    size,
    createdAt,
    modifiedAt,
    parentUri,
    checksum,
    isIndexed,
    lastIndexedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'files_index';
  @override
  VerificationContext validateIntegrity(
    Insertable<FileIndexEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uri')) {
      context.handle(
        _uriMeta,
        uri.isAcceptableOrUnknown(data['uri']!, _uriMeta),
      );
    } else if (isInserting) {
      context.missing(_uriMeta);
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedNameMeta);
    }
    if (data.containsKey('mime')) {
      context.handle(
        _mimeMeta,
        mime.isAcceptableOrUnknown(data['mime']!, _mimeMeta),
      );
    } else if (isInserting) {
      context.missing(_mimeMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
        _modifiedAtMeta,
        modifiedAt.isAcceptableOrUnknown(data['modified_at']!, _modifiedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    if (data.containsKey('parent_uri')) {
      context.handle(
        _parentUriMeta,
        parentUri.isAcceptableOrUnknown(data['parent_uri']!, _parentUriMeta),
      );
    }
    if (data.containsKey('checksum')) {
      context.handle(
        _checksumMeta,
        checksum.isAcceptableOrUnknown(data['checksum']!, _checksumMeta),
      );
    } else if (isInserting) {
      context.missing(_checksumMeta);
    }
    if (data.containsKey('is_indexed')) {
      context.handle(
        _isIndexedMeta,
        isIndexed.isAcceptableOrUnknown(data['is_indexed']!, _isIndexedMeta),
      );
    }
    if (data.containsKey('last_indexed_at')) {
      context.handle(
        _lastIndexedAtMeta,
        lastIndexedAt.isAcceptableOrUnknown(
          data['last_indexed_at']!,
          _lastIndexedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FileIndexEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FileIndexEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uri: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uri'],
      )!,
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      )!,
      mime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime'],
      )!,
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      modifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}modified_at'],
      )!,
      parentUri: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_uri'],
      ),
      checksum: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}checksum'],
      )!,
      isIndexed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_indexed'],
      )!,
      lastIndexedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_indexed_at'],
      ),
    );
  }

  @override
  $FilesIndexTable createAlias(String alias) {
    return $FilesIndexTable(attachedDatabase, alias);
  }
}

class FileIndexEntry extends DataClass implements Insertable<FileIndexEntry> {
  final int id;
  final String uri;
  final String normalizedName;
  final String mime;
  final int size;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String? parentUri;
  final String checksum;
  final bool isIndexed;
  final DateTime? lastIndexedAt;
  const FileIndexEntry({
    required this.id,
    required this.uri,
    required this.normalizedName,
    required this.mime,
    required this.size,
    required this.createdAt,
    required this.modifiedAt,
    this.parentUri,
    required this.checksum,
    required this.isIndexed,
    this.lastIndexedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uri'] = Variable<String>(uri);
    map['normalized_name'] = Variable<String>(normalizedName);
    map['mime'] = Variable<String>(mime);
    map['size'] = Variable<int>(size);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    if (!nullToAbsent || parentUri != null) {
      map['parent_uri'] = Variable<String>(parentUri);
    }
    map['checksum'] = Variable<String>(checksum);
    map['is_indexed'] = Variable<bool>(isIndexed);
    if (!nullToAbsent || lastIndexedAt != null) {
      map['last_indexed_at'] = Variable<DateTime>(lastIndexedAt);
    }
    return map;
  }

  FilesIndexCompanion toCompanion(bool nullToAbsent) {
    return FilesIndexCompanion(
      id: Value(id),
      uri: Value(uri),
      normalizedName: Value(normalizedName),
      mime: Value(mime),
      size: Value(size),
      createdAt: Value(createdAt),
      modifiedAt: Value(modifiedAt),
      parentUri: parentUri == null && nullToAbsent
          ? const Value.absent()
          : Value(parentUri),
      checksum: Value(checksum),
      isIndexed: Value(isIndexed),
      lastIndexedAt: lastIndexedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastIndexedAt),
    );
  }

  factory FileIndexEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FileIndexEntry(
      id: serializer.fromJson<int>(json['id']),
      uri: serializer.fromJson<String>(json['uri']),
      normalizedName: serializer.fromJson<String>(json['normalizedName']),
      mime: serializer.fromJson<String>(json['mime']),
      size: serializer.fromJson<int>(json['size']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
      parentUri: serializer.fromJson<String?>(json['parentUri']),
      checksum: serializer.fromJson<String>(json['checksum']),
      isIndexed: serializer.fromJson<bool>(json['isIndexed']),
      lastIndexedAt: serializer.fromJson<DateTime?>(json['lastIndexedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uri': serializer.toJson<String>(uri),
      'normalizedName': serializer.toJson<String>(normalizedName),
      'mime': serializer.toJson<String>(mime),
      'size': serializer.toJson<int>(size),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
      'parentUri': serializer.toJson<String?>(parentUri),
      'checksum': serializer.toJson<String>(checksum),
      'isIndexed': serializer.toJson<bool>(isIndexed),
      'lastIndexedAt': serializer.toJson<DateTime?>(lastIndexedAt),
    };
  }

  FileIndexEntry copyWith({
    int? id,
    String? uri,
    String? normalizedName,
    String? mime,
    int? size,
    DateTime? createdAt,
    DateTime? modifiedAt,
    Value<String?> parentUri = const Value.absent(),
    String? checksum,
    bool? isIndexed,
    Value<DateTime?> lastIndexedAt = const Value.absent(),
  }) => FileIndexEntry(
    id: id ?? this.id,
    uri: uri ?? this.uri,
    normalizedName: normalizedName ?? this.normalizedName,
    mime: mime ?? this.mime,
    size: size ?? this.size,
    createdAt: createdAt ?? this.createdAt,
    modifiedAt: modifiedAt ?? this.modifiedAt,
    parentUri: parentUri.present ? parentUri.value : this.parentUri,
    checksum: checksum ?? this.checksum,
    isIndexed: isIndexed ?? this.isIndexed,
    lastIndexedAt: lastIndexedAt.present
        ? lastIndexedAt.value
        : this.lastIndexedAt,
  );
  FileIndexEntry copyWithCompanion(FilesIndexCompanion data) {
    return FileIndexEntry(
      id: data.id.present ? data.id.value : this.id,
      uri: data.uri.present ? data.uri.value : this.uri,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      mime: data.mime.present ? data.mime.value : this.mime,
      size: data.size.present ? data.size.value : this.size,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      modifiedAt: data.modifiedAt.present
          ? data.modifiedAt.value
          : this.modifiedAt,
      parentUri: data.parentUri.present ? data.parentUri.value : this.parentUri,
      checksum: data.checksum.present ? data.checksum.value : this.checksum,
      isIndexed: data.isIndexed.present ? data.isIndexed.value : this.isIndexed,
      lastIndexedAt: data.lastIndexedAt.present
          ? data.lastIndexedAt.value
          : this.lastIndexedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FileIndexEntry(')
          ..write('id: $id, ')
          ..write('uri: $uri, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('mime: $mime, ')
          ..write('size: $size, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('parentUri: $parentUri, ')
          ..write('checksum: $checksum, ')
          ..write('isIndexed: $isIndexed, ')
          ..write('lastIndexedAt: $lastIndexedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uri,
    normalizedName,
    mime,
    size,
    createdAt,
    modifiedAt,
    parentUri,
    checksum,
    isIndexed,
    lastIndexedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FileIndexEntry &&
          other.id == this.id &&
          other.uri == this.uri &&
          other.normalizedName == this.normalizedName &&
          other.mime == this.mime &&
          other.size == this.size &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.parentUri == this.parentUri &&
          other.checksum == this.checksum &&
          other.isIndexed == this.isIndexed &&
          other.lastIndexedAt == this.lastIndexedAt);
}

class FilesIndexCompanion extends UpdateCompanion<FileIndexEntry> {
  final Value<int> id;
  final Value<String> uri;
  final Value<String> normalizedName;
  final Value<String> mime;
  final Value<int> size;
  final Value<DateTime> createdAt;
  final Value<DateTime> modifiedAt;
  final Value<String?> parentUri;
  final Value<String> checksum;
  final Value<bool> isIndexed;
  final Value<DateTime?> lastIndexedAt;
  const FilesIndexCompanion({
    this.id = const Value.absent(),
    this.uri = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.mime = const Value.absent(),
    this.size = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.parentUri = const Value.absent(),
    this.checksum = const Value.absent(),
    this.isIndexed = const Value.absent(),
    this.lastIndexedAt = const Value.absent(),
  });
  FilesIndexCompanion.insert({
    this.id = const Value.absent(),
    required String uri,
    required String normalizedName,
    required String mime,
    required int size,
    required DateTime createdAt,
    required DateTime modifiedAt,
    this.parentUri = const Value.absent(),
    required String checksum,
    this.isIndexed = const Value.absent(),
    this.lastIndexedAt = const Value.absent(),
  }) : uri = Value(uri),
       normalizedName = Value(normalizedName),
       mime = Value(mime),
       size = Value(size),
       createdAt = Value(createdAt),
       modifiedAt = Value(modifiedAt),
       checksum = Value(checksum);
  static Insertable<FileIndexEntry> custom({
    Expression<int>? id,
    Expression<String>? uri,
    Expression<String>? normalizedName,
    Expression<String>? mime,
    Expression<int>? size,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? modifiedAt,
    Expression<String>? parentUri,
    Expression<String>? checksum,
    Expression<bool>? isIndexed,
    Expression<DateTime>? lastIndexedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uri != null) 'uri': uri,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (mime != null) 'mime': mime,
      if (size != null) 'size': size,
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (parentUri != null) 'parent_uri': parentUri,
      if (checksum != null) 'checksum': checksum,
      if (isIndexed != null) 'is_indexed': isIndexed,
      if (lastIndexedAt != null) 'last_indexed_at': lastIndexedAt,
    });
  }

  FilesIndexCompanion copyWith({
    Value<int>? id,
    Value<String>? uri,
    Value<String>? normalizedName,
    Value<String>? mime,
    Value<int>? size,
    Value<DateTime>? createdAt,
    Value<DateTime>? modifiedAt,
    Value<String?>? parentUri,
    Value<String>? checksum,
    Value<bool>? isIndexed,
    Value<DateTime?>? lastIndexedAt,
  }) {
    return FilesIndexCompanion(
      id: id ?? this.id,
      uri: uri ?? this.uri,
      normalizedName: normalizedName ?? this.normalizedName,
      mime: mime ?? this.mime,
      size: size ?? this.size,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      parentUri: parentUri ?? this.parentUri,
      checksum: checksum ?? this.checksum,
      isIndexed: isIndexed ?? this.isIndexed,
      lastIndexedAt: lastIndexedAt ?? this.lastIndexedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uri.present) {
      map['uri'] = Variable<String>(uri.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (mime.present) {
      map['mime'] = Variable<String>(mime.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (parentUri.present) {
      map['parent_uri'] = Variable<String>(parentUri.value);
    }
    if (checksum.present) {
      map['checksum'] = Variable<String>(checksum.value);
    }
    if (isIndexed.present) {
      map['is_indexed'] = Variable<bool>(isIndexed.value);
    }
    if (lastIndexedAt.present) {
      map['last_indexed_at'] = Variable<DateTime>(lastIndexedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FilesIndexCompanion(')
          ..write('id: $id, ')
          ..write('uri: $uri, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('mime: $mime, ')
          ..write('size: $size, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('parentUri: $parentUri, ')
          ..write('checksum: $checksum, ')
          ..write('isIndexed: $isIndexed, ')
          ..write('lastIndexedAt: $lastIndexedAt')
          ..write(')'))
        .toString();
  }
}

class $ExtractedTextTable extends ExtractedText
    with TableInfo<$ExtractedTextTable, ExtractedTextEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExtractedTextTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  @override
  late final GeneratedColumn<int> fileId = GeneratedColumn<int>(
    'file_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES files_index (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ocrEngineVersionMeta = const VerificationMeta(
    'ocrEngineVersion',
  );
  @override
  late final GeneratedColumn<String> ocrEngineVersion = GeneratedColumn<String>(
    'ocr_engine_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _extractedAtMeta = const VerificationMeta(
    'extractedAt',
  );
  @override
  late final GeneratedColumn<DateTime> extractedAt = GeneratedColumn<DateTime>(
    'extracted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fileId,
    content,
    confidence,
    ocrEngineVersion,
    extractedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'extracted_text';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExtractedTextEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('file_id')) {
      context.handle(
        _fileIdMeta,
        fileId.isAcceptableOrUnknown(data['file_id']!, _fileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fileIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('ocr_engine_version')) {
      context.handle(
        _ocrEngineVersionMeta,
        ocrEngineVersion.isAcceptableOrUnknown(
          data['ocr_engine_version']!,
          _ocrEngineVersionMeta,
        ),
      );
    }
    if (data.containsKey('extracted_at')) {
      context.handle(
        _extractedAtMeta,
        extractedAt.isAcceptableOrUnknown(
          data['extracted_at']!,
          _extractedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExtractedTextEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExtractedTextEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      ),
      ocrEngineVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ocr_engine_version'],
      ),
      extractedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}extracted_at'],
      )!,
    );
  }

  @override
  $ExtractedTextTable createAlias(String alias) {
    return $ExtractedTextTable(attachedDatabase, alias);
  }
}

class ExtractedTextEntry extends DataClass
    implements Insertable<ExtractedTextEntry> {
  final int id;
  final int fileId;
  final String content;
  final double? confidence;
  final String? ocrEngineVersion;
  final DateTime extractedAt;
  const ExtractedTextEntry({
    required this.id,
    required this.fileId,
    required this.content,
    this.confidence,
    this.ocrEngineVersion,
    required this.extractedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['file_id'] = Variable<int>(fileId);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || confidence != null) {
      map['confidence'] = Variable<double>(confidence);
    }
    if (!nullToAbsent || ocrEngineVersion != null) {
      map['ocr_engine_version'] = Variable<String>(ocrEngineVersion);
    }
    map['extracted_at'] = Variable<DateTime>(extractedAt);
    return map;
  }

  ExtractedTextCompanion toCompanion(bool nullToAbsent) {
    return ExtractedTextCompanion(
      id: Value(id),
      fileId: Value(fileId),
      content: Value(content),
      confidence: confidence == null && nullToAbsent
          ? const Value.absent()
          : Value(confidence),
      ocrEngineVersion: ocrEngineVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(ocrEngineVersion),
      extractedAt: Value(extractedAt),
    );
  }

  factory ExtractedTextEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExtractedTextEntry(
      id: serializer.fromJson<int>(json['id']),
      fileId: serializer.fromJson<int>(json['fileId']),
      content: serializer.fromJson<String>(json['content']),
      confidence: serializer.fromJson<double?>(json['confidence']),
      ocrEngineVersion: serializer.fromJson<String?>(json['ocrEngineVersion']),
      extractedAt: serializer.fromJson<DateTime>(json['extractedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fileId': serializer.toJson<int>(fileId),
      'content': serializer.toJson<String>(content),
      'confidence': serializer.toJson<double?>(confidence),
      'ocrEngineVersion': serializer.toJson<String?>(ocrEngineVersion),
      'extractedAt': serializer.toJson<DateTime>(extractedAt),
    };
  }

  ExtractedTextEntry copyWith({
    int? id,
    int? fileId,
    String? content,
    Value<double?> confidence = const Value.absent(),
    Value<String?> ocrEngineVersion = const Value.absent(),
    DateTime? extractedAt,
  }) => ExtractedTextEntry(
    id: id ?? this.id,
    fileId: fileId ?? this.fileId,
    content: content ?? this.content,
    confidence: confidence.present ? confidence.value : this.confidence,
    ocrEngineVersion: ocrEngineVersion.present
        ? ocrEngineVersion.value
        : this.ocrEngineVersion,
    extractedAt: extractedAt ?? this.extractedAt,
  );
  ExtractedTextEntry copyWithCompanion(ExtractedTextCompanion data) {
    return ExtractedTextEntry(
      id: data.id.present ? data.id.value : this.id,
      fileId: data.fileId.present ? data.fileId.value : this.fileId,
      content: data.content.present ? data.content.value : this.content,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      ocrEngineVersion: data.ocrEngineVersion.present
          ? data.ocrEngineVersion.value
          : this.ocrEngineVersion,
      extractedAt: data.extractedAt.present
          ? data.extractedAt.value
          : this.extractedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExtractedTextEntry(')
          ..write('id: $id, ')
          ..write('fileId: $fileId, ')
          ..write('content: $content, ')
          ..write('confidence: $confidence, ')
          ..write('ocrEngineVersion: $ocrEngineVersion, ')
          ..write('extractedAt: $extractedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fileId,
    content,
    confidence,
    ocrEngineVersion,
    extractedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExtractedTextEntry &&
          other.id == this.id &&
          other.fileId == this.fileId &&
          other.content == this.content &&
          other.confidence == this.confidence &&
          other.ocrEngineVersion == this.ocrEngineVersion &&
          other.extractedAt == this.extractedAt);
}

class ExtractedTextCompanion extends UpdateCompanion<ExtractedTextEntry> {
  final Value<int> id;
  final Value<int> fileId;
  final Value<String> content;
  final Value<double?> confidence;
  final Value<String?> ocrEngineVersion;
  final Value<DateTime> extractedAt;
  const ExtractedTextCompanion({
    this.id = const Value.absent(),
    this.fileId = const Value.absent(),
    this.content = const Value.absent(),
    this.confidence = const Value.absent(),
    this.ocrEngineVersion = const Value.absent(),
    this.extractedAt = const Value.absent(),
  });
  ExtractedTextCompanion.insert({
    this.id = const Value.absent(),
    required int fileId,
    required String content,
    this.confidence = const Value.absent(),
    this.ocrEngineVersion = const Value.absent(),
    this.extractedAt = const Value.absent(),
  }) : fileId = Value(fileId),
       content = Value(content);
  static Insertable<ExtractedTextEntry> custom({
    Expression<int>? id,
    Expression<int>? fileId,
    Expression<String>? content,
    Expression<double>? confidence,
    Expression<String>? ocrEngineVersion,
    Expression<DateTime>? extractedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileId != null) 'file_id': fileId,
      if (content != null) 'content': content,
      if (confidence != null) 'confidence': confidence,
      if (ocrEngineVersion != null) 'ocr_engine_version': ocrEngineVersion,
      if (extractedAt != null) 'extracted_at': extractedAt,
    });
  }

  ExtractedTextCompanion copyWith({
    Value<int>? id,
    Value<int>? fileId,
    Value<String>? content,
    Value<double?>? confidence,
    Value<String?>? ocrEngineVersion,
    Value<DateTime>? extractedAt,
  }) {
    return ExtractedTextCompanion(
      id: id ?? this.id,
      fileId: fileId ?? this.fileId,
      content: content ?? this.content,
      confidence: confidence ?? this.confidence,
      ocrEngineVersion: ocrEngineVersion ?? this.ocrEngineVersion,
      extractedAt: extractedAt ?? this.extractedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fileId.present) {
      map['file_id'] = Variable<int>(fileId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (ocrEngineVersion.present) {
      map['ocr_engine_version'] = Variable<String>(ocrEngineVersion.value);
    }
    if (extractedAt.present) {
      map['extracted_at'] = Variable<DateTime>(extractedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExtractedTextCompanion(')
          ..write('id: $id, ')
          ..write('fileId: $fileId, ')
          ..write('content: $content, ')
          ..write('confidence: $confidence, ')
          ..write('ocrEngineVersion: $ocrEngineVersion, ')
          ..write('extractedAt: $extractedAt')
          ..write(')'))
        .toString();
  }
}

class $ImageLabelsTable extends ImageLabels
    with TableInfo<$ImageLabelsTable, ImageLabel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImageLabelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  @override
  late final GeneratedColumn<int> fileId = GeneratedColumn<int>(
    'file_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES files_index (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelVersionMeta = const VerificationMeta(
    'modelVersion',
  );
  @override
  late final GeneratedColumn<String> modelVersion = GeneratedColumn<String>(
    'model_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labeledAtMeta = const VerificationMeta(
    'labeledAt',
  );
  @override
  late final GeneratedColumn<DateTime> labeledAt = GeneratedColumn<DateTime>(
    'labeled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fileId,
    label,
    confidence,
    modelVersion,
    labeledAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'image_labels';
  @override
  VerificationContext validateIntegrity(
    Insertable<ImageLabel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('file_id')) {
      context.handle(
        _fileIdMeta,
        fileId.isAcceptableOrUnknown(data['file_id']!, _fileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fileIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('model_version')) {
      context.handle(
        _modelVersionMeta,
        modelVersion.isAcceptableOrUnknown(
          data['model_version']!,
          _modelVersionMeta,
        ),
      );
    }
    if (data.containsKey('labeled_at')) {
      context.handle(
        _labeledAtMeta,
        labeledAt.isAcceptableOrUnknown(data['labeled_at']!, _labeledAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImageLabel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImageLabel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      modelVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_version'],
      ),
      labeledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}labeled_at'],
      )!,
    );
  }

  @override
  $ImageLabelsTable createAlias(String alias) {
    return $ImageLabelsTable(attachedDatabase, alias);
  }
}

class ImageLabel extends DataClass implements Insertable<ImageLabel> {
  final int id;
  final int fileId;
  final String label;
  final double confidence;
  final String? modelVersion;
  final DateTime labeledAt;
  const ImageLabel({
    required this.id,
    required this.fileId,
    required this.label,
    required this.confidence,
    this.modelVersion,
    required this.labeledAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['file_id'] = Variable<int>(fileId);
    map['label'] = Variable<String>(label);
    map['confidence'] = Variable<double>(confidence);
    if (!nullToAbsent || modelVersion != null) {
      map['model_version'] = Variable<String>(modelVersion);
    }
    map['labeled_at'] = Variable<DateTime>(labeledAt);
    return map;
  }

  ImageLabelsCompanion toCompanion(bool nullToAbsent) {
    return ImageLabelsCompanion(
      id: Value(id),
      fileId: Value(fileId),
      label: Value(label),
      confidence: Value(confidence),
      modelVersion: modelVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(modelVersion),
      labeledAt: Value(labeledAt),
    );
  }

  factory ImageLabel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImageLabel(
      id: serializer.fromJson<int>(json['id']),
      fileId: serializer.fromJson<int>(json['fileId']),
      label: serializer.fromJson<String>(json['label']),
      confidence: serializer.fromJson<double>(json['confidence']),
      modelVersion: serializer.fromJson<String?>(json['modelVersion']),
      labeledAt: serializer.fromJson<DateTime>(json['labeledAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fileId': serializer.toJson<int>(fileId),
      'label': serializer.toJson<String>(label),
      'confidence': serializer.toJson<double>(confidence),
      'modelVersion': serializer.toJson<String?>(modelVersion),
      'labeledAt': serializer.toJson<DateTime>(labeledAt),
    };
  }

  ImageLabel copyWith({
    int? id,
    int? fileId,
    String? label,
    double? confidence,
    Value<String?> modelVersion = const Value.absent(),
    DateTime? labeledAt,
  }) => ImageLabel(
    id: id ?? this.id,
    fileId: fileId ?? this.fileId,
    label: label ?? this.label,
    confidence: confidence ?? this.confidence,
    modelVersion: modelVersion.present ? modelVersion.value : this.modelVersion,
    labeledAt: labeledAt ?? this.labeledAt,
  );
  ImageLabel copyWithCompanion(ImageLabelsCompanion data) {
    return ImageLabel(
      id: data.id.present ? data.id.value : this.id,
      fileId: data.fileId.present ? data.fileId.value : this.fileId,
      label: data.label.present ? data.label.value : this.label,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      modelVersion: data.modelVersion.present
          ? data.modelVersion.value
          : this.modelVersion,
      labeledAt: data.labeledAt.present ? data.labeledAt.value : this.labeledAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImageLabel(')
          ..write('id: $id, ')
          ..write('fileId: $fileId, ')
          ..write('label: $label, ')
          ..write('confidence: $confidence, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('labeledAt: $labeledAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, fileId, label, confidence, modelVersion, labeledAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImageLabel &&
          other.id == this.id &&
          other.fileId == this.fileId &&
          other.label == this.label &&
          other.confidence == this.confidence &&
          other.modelVersion == this.modelVersion &&
          other.labeledAt == this.labeledAt);
}

class ImageLabelsCompanion extends UpdateCompanion<ImageLabel> {
  final Value<int> id;
  final Value<int> fileId;
  final Value<String> label;
  final Value<double> confidence;
  final Value<String?> modelVersion;
  final Value<DateTime> labeledAt;
  const ImageLabelsCompanion({
    this.id = const Value.absent(),
    this.fileId = const Value.absent(),
    this.label = const Value.absent(),
    this.confidence = const Value.absent(),
    this.modelVersion = const Value.absent(),
    this.labeledAt = const Value.absent(),
  });
  ImageLabelsCompanion.insert({
    this.id = const Value.absent(),
    required int fileId,
    required String label,
    required double confidence,
    this.modelVersion = const Value.absent(),
    this.labeledAt = const Value.absent(),
  }) : fileId = Value(fileId),
       label = Value(label),
       confidence = Value(confidence);
  static Insertable<ImageLabel> custom({
    Expression<int>? id,
    Expression<int>? fileId,
    Expression<String>? label,
    Expression<double>? confidence,
    Expression<String>? modelVersion,
    Expression<DateTime>? labeledAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileId != null) 'file_id': fileId,
      if (label != null) 'label': label,
      if (confidence != null) 'confidence': confidence,
      if (modelVersion != null) 'model_version': modelVersion,
      if (labeledAt != null) 'labeled_at': labeledAt,
    });
  }

  ImageLabelsCompanion copyWith({
    Value<int>? id,
    Value<int>? fileId,
    Value<String>? label,
    Value<double>? confidence,
    Value<String?>? modelVersion,
    Value<DateTime>? labeledAt,
  }) {
    return ImageLabelsCompanion(
      id: id ?? this.id,
      fileId: fileId ?? this.fileId,
      label: label ?? this.label,
      confidence: confidence ?? this.confidence,
      modelVersion: modelVersion ?? this.modelVersion,
      labeledAt: labeledAt ?? this.labeledAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fileId.present) {
      map['file_id'] = Variable<int>(fileId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (modelVersion.present) {
      map['model_version'] = Variable<String>(modelVersion.value);
    }
    if (labeledAt.present) {
      map['labeled_at'] = Variable<DateTime>(labeledAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImageLabelsCompanion(')
          ..write('id: $id, ')
          ..write('fileId: $fileId, ')
          ..write('label: $label, ')
          ..write('confidence: $confidence, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('labeledAt: $labeledAt')
          ..write(')'))
        .toString();
  }
}

class $EmbeddingsTable extends Embeddings
    with TableInfo<$EmbeddingsTable, Embedding> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmbeddingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  @override
  late final GeneratedColumn<int> fileId = GeneratedColumn<int>(
    'file_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES files_index (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _vectorMeta = const VerificationMeta('vector');
  @override
  late final GeneratedColumn<Uint8List> vector = GeneratedColumn<Uint8List>(
    'vector',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dimMeta = const VerificationMeta('dim');
  @override
  late final GeneratedColumn<int> dim = GeneratedColumn<int>(
    'dim',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelVersionMeta = const VerificationMeta(
    'modelVersion',
  );
  @override
  late final GeneratedColumn<String> modelVersion = GeneratedColumn<String>(
    'model_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantizationLevelMeta = const VerificationMeta(
    'quantizationLevel',
  );
  @override
  late final GeneratedColumn<String> quantizationLevel =
      GeneratedColumn<String>(
        'quantization_level',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fileId,
    vector,
    dim,
    modelVersion,
    quantizationLevel,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'embeddings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Embedding> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('file_id')) {
      context.handle(
        _fileIdMeta,
        fileId.isAcceptableOrUnknown(data['file_id']!, _fileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fileIdMeta);
    }
    if (data.containsKey('vector')) {
      context.handle(
        _vectorMeta,
        vector.isAcceptableOrUnknown(data['vector']!, _vectorMeta),
      );
    } else if (isInserting) {
      context.missing(_vectorMeta);
    }
    if (data.containsKey('dim')) {
      context.handle(
        _dimMeta,
        dim.isAcceptableOrUnknown(data['dim']!, _dimMeta),
      );
    } else if (isInserting) {
      context.missing(_dimMeta);
    }
    if (data.containsKey('model_version')) {
      context.handle(
        _modelVersionMeta,
        modelVersion.isAcceptableOrUnknown(
          data['model_version']!,
          _modelVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_modelVersionMeta);
    }
    if (data.containsKey('quantization_level')) {
      context.handle(
        _quantizationLevelMeta,
        quantizationLevel.isAcceptableOrUnknown(
          data['quantization_level']!,
          _quantizationLevelMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Embedding map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Embedding(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_id'],
      )!,
      vector: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}vector'],
      )!,
      dim: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dim'],
      )!,
      modelVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_version'],
      )!,
      quantizationLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quantization_level'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EmbeddingsTable createAlias(String alias) {
    return $EmbeddingsTable(attachedDatabase, alias);
  }
}

class Embedding extends DataClass implements Insertable<Embedding> {
  final int id;
  final int fileId;
  final Uint8List vector;
  final int dim;
  final String modelVersion;
  final String? quantizationLevel;
  final DateTime createdAt;
  const Embedding({
    required this.id,
    required this.fileId,
    required this.vector,
    required this.dim,
    required this.modelVersion,
    this.quantizationLevel,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['file_id'] = Variable<int>(fileId);
    map['vector'] = Variable<Uint8List>(vector);
    map['dim'] = Variable<int>(dim);
    map['model_version'] = Variable<String>(modelVersion);
    if (!nullToAbsent || quantizationLevel != null) {
      map['quantization_level'] = Variable<String>(quantizationLevel);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EmbeddingsCompanion toCompanion(bool nullToAbsent) {
    return EmbeddingsCompanion(
      id: Value(id),
      fileId: Value(fileId),
      vector: Value(vector),
      dim: Value(dim),
      modelVersion: Value(modelVersion),
      quantizationLevel: quantizationLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(quantizationLevel),
      createdAt: Value(createdAt),
    );
  }

  factory Embedding.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Embedding(
      id: serializer.fromJson<int>(json['id']),
      fileId: serializer.fromJson<int>(json['fileId']),
      vector: serializer.fromJson<Uint8List>(json['vector']),
      dim: serializer.fromJson<int>(json['dim']),
      modelVersion: serializer.fromJson<String>(json['modelVersion']),
      quantizationLevel: serializer.fromJson<String?>(
        json['quantizationLevel'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fileId': serializer.toJson<int>(fileId),
      'vector': serializer.toJson<Uint8List>(vector),
      'dim': serializer.toJson<int>(dim),
      'modelVersion': serializer.toJson<String>(modelVersion),
      'quantizationLevel': serializer.toJson<String?>(quantizationLevel),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Embedding copyWith({
    int? id,
    int? fileId,
    Uint8List? vector,
    int? dim,
    String? modelVersion,
    Value<String?> quantizationLevel = const Value.absent(),
    DateTime? createdAt,
  }) => Embedding(
    id: id ?? this.id,
    fileId: fileId ?? this.fileId,
    vector: vector ?? this.vector,
    dim: dim ?? this.dim,
    modelVersion: modelVersion ?? this.modelVersion,
    quantizationLevel: quantizationLevel.present
        ? quantizationLevel.value
        : this.quantizationLevel,
    createdAt: createdAt ?? this.createdAt,
  );
  Embedding copyWithCompanion(EmbeddingsCompanion data) {
    return Embedding(
      id: data.id.present ? data.id.value : this.id,
      fileId: data.fileId.present ? data.fileId.value : this.fileId,
      vector: data.vector.present ? data.vector.value : this.vector,
      dim: data.dim.present ? data.dim.value : this.dim,
      modelVersion: data.modelVersion.present
          ? data.modelVersion.value
          : this.modelVersion,
      quantizationLevel: data.quantizationLevel.present
          ? data.quantizationLevel.value
          : this.quantizationLevel,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Embedding(')
          ..write('id: $id, ')
          ..write('fileId: $fileId, ')
          ..write('vector: $vector, ')
          ..write('dim: $dim, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('quantizationLevel: $quantizationLevel, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fileId,
    $driftBlobEquality.hash(vector),
    dim,
    modelVersion,
    quantizationLevel,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Embedding &&
          other.id == this.id &&
          other.fileId == this.fileId &&
          $driftBlobEquality.equals(other.vector, this.vector) &&
          other.dim == this.dim &&
          other.modelVersion == this.modelVersion &&
          other.quantizationLevel == this.quantizationLevel &&
          other.createdAt == this.createdAt);
}

class EmbeddingsCompanion extends UpdateCompanion<Embedding> {
  final Value<int> id;
  final Value<int> fileId;
  final Value<Uint8List> vector;
  final Value<int> dim;
  final Value<String> modelVersion;
  final Value<String?> quantizationLevel;
  final Value<DateTime> createdAt;
  const EmbeddingsCompanion({
    this.id = const Value.absent(),
    this.fileId = const Value.absent(),
    this.vector = const Value.absent(),
    this.dim = const Value.absent(),
    this.modelVersion = const Value.absent(),
    this.quantizationLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  EmbeddingsCompanion.insert({
    this.id = const Value.absent(),
    required int fileId,
    required Uint8List vector,
    required int dim,
    required String modelVersion,
    this.quantizationLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : fileId = Value(fileId),
       vector = Value(vector),
       dim = Value(dim),
       modelVersion = Value(modelVersion);
  static Insertable<Embedding> custom({
    Expression<int>? id,
    Expression<int>? fileId,
    Expression<Uint8List>? vector,
    Expression<int>? dim,
    Expression<String>? modelVersion,
    Expression<String>? quantizationLevel,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileId != null) 'file_id': fileId,
      if (vector != null) 'vector': vector,
      if (dim != null) 'dim': dim,
      if (modelVersion != null) 'model_version': modelVersion,
      if (quantizationLevel != null) 'quantization_level': quantizationLevel,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  EmbeddingsCompanion copyWith({
    Value<int>? id,
    Value<int>? fileId,
    Value<Uint8List>? vector,
    Value<int>? dim,
    Value<String>? modelVersion,
    Value<String?>? quantizationLevel,
    Value<DateTime>? createdAt,
  }) {
    return EmbeddingsCompanion(
      id: id ?? this.id,
      fileId: fileId ?? this.fileId,
      vector: vector ?? this.vector,
      dim: dim ?? this.dim,
      modelVersion: modelVersion ?? this.modelVersion,
      quantizationLevel: quantizationLevel ?? this.quantizationLevel,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fileId.present) {
      map['file_id'] = Variable<int>(fileId.value);
    }
    if (vector.present) {
      map['vector'] = Variable<Uint8List>(vector.value);
    }
    if (dim.present) {
      map['dim'] = Variable<int>(dim.value);
    }
    if (modelVersion.present) {
      map['model_version'] = Variable<String>(modelVersion.value);
    }
    if (quantizationLevel.present) {
      map['quantization_level'] = Variable<String>(quantizationLevel.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmbeddingsCompanion(')
          ..write('id: $id, ')
          ..write('fileId: $fileId, ')
          ..write('vector: $vector, ')
          ..write('dim: $dim, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('quantizationLevel: $quantizationLevel, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RulesTable extends Rules with TableInfo<$RulesTable, Rule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _conditionsJsonMeta = const VerificationMeta(
    'conditionsJson',
  );
  @override
  late final GeneratedColumn<String> conditionsJson = GeneratedColumn<String>(
    'conditions_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionsJsonMeta = const VerificationMeta(
    'actionsJson',
  );
  @override
  late final GeneratedColumn<String> actionsJson = GeneratedColumn<String>(
    'actions_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastExecutedAtMeta = const VerificationMeta(
    'lastExecutedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastExecutedAt =
      GeneratedColumn<DateTime>(
        'last_executed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    conditionsJson,
    actionsJson,
    isEnabled,
    priority,
    createdAt,
    updatedAt,
    lastExecutedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<Rule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('conditions_json')) {
      context.handle(
        _conditionsJsonMeta,
        conditionsJson.isAcceptableOrUnknown(
          data['conditions_json']!,
          _conditionsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conditionsJsonMeta);
    }
    if (data.containsKey('actions_json')) {
      context.handle(
        _actionsJsonMeta,
        actionsJson.isAcceptableOrUnknown(
          data['actions_json']!,
          _actionsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actionsJsonMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('last_executed_at')) {
      context.handle(
        _lastExecutedAtMeta,
        lastExecutedAt.isAcceptableOrUnknown(
          data['last_executed_at']!,
          _lastExecutedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Rule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Rule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      conditionsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conditions_json'],
      )!,
      actionsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actions_json'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      lastExecutedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_executed_at'],
      ),
    );
  }

  @override
  $RulesTable createAlias(String alias) {
    return $RulesTable(attachedDatabase, alias);
  }
}

class Rule extends DataClass implements Insertable<Rule> {
  final int id;
  final String name;
  final String? description;
  final String conditionsJson;
  final String actionsJson;
  final bool isEnabled;
  final int priority;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastExecutedAt;
  const Rule({
    required this.id,
    required this.name,
    this.description,
    required this.conditionsJson,
    required this.actionsJson,
    required this.isEnabled,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
    this.lastExecutedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['conditions_json'] = Variable<String>(conditionsJson);
    map['actions_json'] = Variable<String>(actionsJson);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['priority'] = Variable<int>(priority);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastExecutedAt != null) {
      map['last_executed_at'] = Variable<DateTime>(lastExecutedAt);
    }
    return map;
  }

  RulesCompanion toCompanion(bool nullToAbsent) {
    return RulesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      conditionsJson: Value(conditionsJson),
      actionsJson: Value(actionsJson),
      isEnabled: Value(isEnabled),
      priority: Value(priority),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      lastExecutedAt: lastExecutedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastExecutedAt),
    );
  }

  factory Rule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Rule(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      conditionsJson: serializer.fromJson<String>(json['conditionsJson']),
      actionsJson: serializer.fromJson<String>(json['actionsJson']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      priority: serializer.fromJson<int>(json['priority']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastExecutedAt: serializer.fromJson<DateTime?>(json['lastExecutedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'conditionsJson': serializer.toJson<String>(conditionsJson),
      'actionsJson': serializer.toJson<String>(actionsJson),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'priority': serializer.toJson<int>(priority),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastExecutedAt': serializer.toJson<DateTime?>(lastExecutedAt),
    };
  }

  Rule copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    String? conditionsJson,
    String? actionsJson,
    bool? isEnabled,
    int? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> lastExecutedAt = const Value.absent(),
  }) => Rule(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    conditionsJson: conditionsJson ?? this.conditionsJson,
    actionsJson: actionsJson ?? this.actionsJson,
    isEnabled: isEnabled ?? this.isEnabled,
    priority: priority ?? this.priority,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    lastExecutedAt: lastExecutedAt.present
        ? lastExecutedAt.value
        : this.lastExecutedAt,
  );
  Rule copyWithCompanion(RulesCompanion data) {
    return Rule(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      conditionsJson: data.conditionsJson.present
          ? data.conditionsJson.value
          : this.conditionsJson,
      actionsJson: data.actionsJson.present
          ? data.actionsJson.value
          : this.actionsJson,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      priority: data.priority.present ? data.priority.value : this.priority,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastExecutedAt: data.lastExecutedAt.present
          ? data.lastExecutedAt.value
          : this.lastExecutedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Rule(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('conditionsJson: $conditionsJson, ')
          ..write('actionsJson: $actionsJson, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('priority: $priority, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastExecutedAt: $lastExecutedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    conditionsJson,
    actionsJson,
    isEnabled,
    priority,
    createdAt,
    updatedAt,
    lastExecutedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rule &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.conditionsJson == this.conditionsJson &&
          other.actionsJson == this.actionsJson &&
          other.isEnabled == this.isEnabled &&
          other.priority == this.priority &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastExecutedAt == this.lastExecutedAt);
}

class RulesCompanion extends UpdateCompanion<Rule> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> conditionsJson;
  final Value<String> actionsJson;
  final Value<bool> isEnabled;
  final Value<int> priority;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastExecutedAt;
  const RulesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.conditionsJson = const Value.absent(),
    this.actionsJson = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.priority = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastExecutedAt = const Value.absent(),
  });
  RulesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required String conditionsJson,
    required String actionsJson,
    this.isEnabled = const Value.absent(),
    this.priority = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastExecutedAt = const Value.absent(),
  }) : name = Value(name),
       conditionsJson = Value(conditionsJson),
       actionsJson = Value(actionsJson);
  static Insertable<Rule> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? conditionsJson,
    Expression<String>? actionsJson,
    Expression<bool>? isEnabled,
    Expression<int>? priority,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastExecutedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (conditionsJson != null) 'conditions_json': conditionsJson,
      if (actionsJson != null) 'actions_json': actionsJson,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (priority != null) 'priority': priority,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastExecutedAt != null) 'last_executed_at': lastExecutedAt,
    });
  }

  RulesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? conditionsJson,
    Value<String>? actionsJson,
    Value<bool>? isEnabled,
    Value<int>? priority,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? lastExecutedAt,
  }) {
    return RulesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      conditionsJson: conditionsJson ?? this.conditionsJson,
      actionsJson: actionsJson ?? this.actionsJson,
      isEnabled: isEnabled ?? this.isEnabled,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastExecutedAt: lastExecutedAt ?? this.lastExecutedAt,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (conditionsJson.present) {
      map['conditions_json'] = Variable<String>(conditionsJson.value);
    }
    if (actionsJson.present) {
      map['actions_json'] = Variable<String>(actionsJson.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastExecutedAt.present) {
      map['last_executed_at'] = Variable<DateTime>(lastExecutedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RulesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('conditionsJson: $conditionsJson, ')
          ..write('actionsJson: $actionsJson, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('priority: $priority, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastExecutedAt: $lastExecutedAt')
          ..write(')'))
        .toString();
  }
}

class $RuleExecutionLogTable extends RuleExecutionLog
    with TableInfo<$RuleExecutionLogTable, RuleExecutionLogEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RuleExecutionLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ruleIdMeta = const VerificationMeta('ruleId');
  @override
  late final GeneratedColumn<int> ruleId = GeneratedColumn<int>(
    'rule_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rules (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  @override
  late final GeneratedColumn<int> fileId = GeneratedColumn<int>(
    'file_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES files_index (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _executedAtMeta = const VerificationMeta(
    'executedAt',
  );
  @override
  late final GeneratedColumn<DateTime> executedAt = GeneratedColumn<DateTime>(
    'executed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ruleId,
    fileId,
    status,
    errorMessage,
    executedAt,
    durationMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rule_execution_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<RuleExecutionLogEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('rule_id')) {
      context.handle(
        _ruleIdMeta,
        ruleId.isAcceptableOrUnknown(data['rule_id']!, _ruleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleIdMeta);
    }
    if (data.containsKey('file_id')) {
      context.handle(
        _fileIdMeta,
        fileId.isAcceptableOrUnknown(data['file_id']!, _fileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fileIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('executed_at')) {
      context.handle(
        _executedAtMeta,
        executedAt.isAcceptableOrUnknown(data['executed_at']!, _executedAtMeta),
      );
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RuleExecutionLogEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RuleExecutionLogEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ruleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rule_id'],
      )!,
      fileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      executedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}executed_at'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      ),
    );
  }

  @override
  $RuleExecutionLogTable createAlias(String alias) {
    return $RuleExecutionLogTable(attachedDatabase, alias);
  }
}

class RuleExecutionLogEntry extends DataClass
    implements Insertable<RuleExecutionLogEntry> {
  final int id;
  final int ruleId;
  final int fileId;
  final String status;
  final String? errorMessage;
  final DateTime executedAt;
  final int? durationMs;
  const RuleExecutionLogEntry({
    required this.id,
    required this.ruleId,
    required this.fileId,
    required this.status,
    this.errorMessage,
    required this.executedAt,
    this.durationMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['rule_id'] = Variable<int>(ruleId);
    map['file_id'] = Variable<int>(fileId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['executed_at'] = Variable<DateTime>(executedAt);
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<int>(durationMs);
    }
    return map;
  }

  RuleExecutionLogCompanion toCompanion(bool nullToAbsent) {
    return RuleExecutionLogCompanion(
      id: Value(id),
      ruleId: Value(ruleId),
      fileId: Value(fileId),
      status: Value(status),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      executedAt: Value(executedAt),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
    );
  }

  factory RuleExecutionLogEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RuleExecutionLogEntry(
      id: serializer.fromJson<int>(json['id']),
      ruleId: serializer.fromJson<int>(json['ruleId']),
      fileId: serializer.fromJson<int>(json['fileId']),
      status: serializer.fromJson<String>(json['status']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      executedAt: serializer.fromJson<DateTime>(json['executedAt']),
      durationMs: serializer.fromJson<int?>(json['durationMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ruleId': serializer.toJson<int>(ruleId),
      'fileId': serializer.toJson<int>(fileId),
      'status': serializer.toJson<String>(status),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'executedAt': serializer.toJson<DateTime>(executedAt),
      'durationMs': serializer.toJson<int?>(durationMs),
    };
  }

  RuleExecutionLogEntry copyWith({
    int? id,
    int? ruleId,
    int? fileId,
    String? status,
    Value<String?> errorMessage = const Value.absent(),
    DateTime? executedAt,
    Value<int?> durationMs = const Value.absent(),
  }) => RuleExecutionLogEntry(
    id: id ?? this.id,
    ruleId: ruleId ?? this.ruleId,
    fileId: fileId ?? this.fileId,
    status: status ?? this.status,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    executedAt: executedAt ?? this.executedAt,
    durationMs: durationMs.present ? durationMs.value : this.durationMs,
  );
  RuleExecutionLogEntry copyWithCompanion(RuleExecutionLogCompanion data) {
    return RuleExecutionLogEntry(
      id: data.id.present ? data.id.value : this.id,
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
      fileId: data.fileId.present ? data.fileId.value : this.fileId,
      status: data.status.present ? data.status.value : this.status,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      executedAt: data.executedAt.present
          ? data.executedAt.value
          : this.executedAt,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RuleExecutionLogEntry(')
          ..write('id: $id, ')
          ..write('ruleId: $ruleId, ')
          ..write('fileId: $fileId, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('executedAt: $executedAt, ')
          ..write('durationMs: $durationMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ruleId,
    fileId,
    status,
    errorMessage,
    executedAt,
    durationMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RuleExecutionLogEntry &&
          other.id == this.id &&
          other.ruleId == this.ruleId &&
          other.fileId == this.fileId &&
          other.status == this.status &&
          other.errorMessage == this.errorMessage &&
          other.executedAt == this.executedAt &&
          other.durationMs == this.durationMs);
}

class RuleExecutionLogCompanion extends UpdateCompanion<RuleExecutionLogEntry> {
  final Value<int> id;
  final Value<int> ruleId;
  final Value<int> fileId;
  final Value<String> status;
  final Value<String?> errorMessage;
  final Value<DateTime> executedAt;
  final Value<int?> durationMs;
  const RuleExecutionLogCompanion({
    this.id = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.fileId = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.executedAt = const Value.absent(),
    this.durationMs = const Value.absent(),
  });
  RuleExecutionLogCompanion.insert({
    this.id = const Value.absent(),
    required int ruleId,
    required int fileId,
    required String status,
    this.errorMessage = const Value.absent(),
    this.executedAt = const Value.absent(),
    this.durationMs = const Value.absent(),
  }) : ruleId = Value(ruleId),
       fileId = Value(fileId),
       status = Value(status);
  static Insertable<RuleExecutionLogEntry> custom({
    Expression<int>? id,
    Expression<int>? ruleId,
    Expression<int>? fileId,
    Expression<String>? status,
    Expression<String>? errorMessage,
    Expression<DateTime>? executedAt,
    Expression<int>? durationMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ruleId != null) 'rule_id': ruleId,
      if (fileId != null) 'file_id': fileId,
      if (status != null) 'status': status,
      if (errorMessage != null) 'error_message': errorMessage,
      if (executedAt != null) 'executed_at': executedAt,
      if (durationMs != null) 'duration_ms': durationMs,
    });
  }

  RuleExecutionLogCompanion copyWith({
    Value<int>? id,
    Value<int>? ruleId,
    Value<int>? fileId,
    Value<String>? status,
    Value<String?>? errorMessage,
    Value<DateTime>? executedAt,
    Value<int?>? durationMs,
  }) {
    return RuleExecutionLogCompanion(
      id: id ?? this.id,
      ruleId: ruleId ?? this.ruleId,
      fileId: fileId ?? this.fileId,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      executedAt: executedAt ?? this.executedAt,
      durationMs: durationMs ?? this.durationMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ruleId.present) {
      map['rule_id'] = Variable<int>(ruleId.value);
    }
    if (fileId.present) {
      map['file_id'] = Variable<int>(fileId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (executedAt.present) {
      map['executed_at'] = Variable<DateTime>(executedAt.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RuleExecutionLogCompanion(')
          ..write('id: $id, ')
          ..write('ruleId: $ruleId, ')
          ..write('fileId: $fileId, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('executedAt: $executedAt, ')
          ..write('durationMs: $durationMs')
          ..write(')'))
        .toString();
  }
}

class $ActivityLogTable extends ActivityLog
    with TableInfo<$ActivityLogTable, ActivityLogEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _activityTypeMeta = const VerificationMeta(
    'activityType',
  );
  @override
  late final GeneratedColumn<String> activityType = GeneratedColumn<String>(
    'activity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _relatedFileIdMeta = const VerificationMeta(
    'relatedFileId',
  );
  @override
  late final GeneratedColumn<int> relatedFileId = GeneratedColumn<int>(
    'related_file_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES files_index (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _relatedRuleIdMeta = const VerificationMeta(
    'relatedRuleId',
  );
  @override
  late final GeneratedColumn<int> relatedRuleId = GeneratedColumn<int>(
    'related_rule_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rules (id) ON DELETE SET NULL',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    activityType,
    description,
    metadataJson,
    timestamp,
    relatedFileId,
    relatedRuleId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityLogEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('activity_type')) {
      context.handle(
        _activityTypeMeta,
        activityType.isAcceptableOrUnknown(
          data['activity_type']!,
          _activityTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activityTypeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('related_file_id')) {
      context.handle(
        _relatedFileIdMeta,
        relatedFileId.isAcceptableOrUnknown(
          data['related_file_id']!,
          _relatedFileIdMeta,
        ),
      );
    }
    if (data.containsKey('related_rule_id')) {
      context.handle(
        _relatedRuleIdMeta,
        relatedRuleId.isAcceptableOrUnknown(
          data['related_rule_id']!,
          _relatedRuleIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityLogEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityLogEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      activityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_type'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      relatedFileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}related_file_id'],
      ),
      relatedRuleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}related_rule_id'],
      ),
    );
  }

  @override
  $ActivityLogTable createAlias(String alias) {
    return $ActivityLogTable(attachedDatabase, alias);
  }
}

class ActivityLogEntry extends DataClass
    implements Insertable<ActivityLogEntry> {
  final int id;
  final String activityType;
  final String description;
  final String? metadataJson;
  final DateTime timestamp;
  final int? relatedFileId;
  final int? relatedRuleId;
  const ActivityLogEntry({
    required this.id,
    required this.activityType,
    required this.description,
    this.metadataJson,
    required this.timestamp,
    this.relatedFileId,
    this.relatedRuleId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['activity_type'] = Variable<String>(activityType);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || metadataJson != null) {
      map['metadata_json'] = Variable<String>(metadataJson);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || relatedFileId != null) {
      map['related_file_id'] = Variable<int>(relatedFileId);
    }
    if (!nullToAbsent || relatedRuleId != null) {
      map['related_rule_id'] = Variable<int>(relatedRuleId);
    }
    return map;
  }

  ActivityLogCompanion toCompanion(bool nullToAbsent) {
    return ActivityLogCompanion(
      id: Value(id),
      activityType: Value(activityType),
      description: Value(description),
      metadataJson: metadataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataJson),
      timestamp: Value(timestamp),
      relatedFileId: relatedFileId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedFileId),
      relatedRuleId: relatedRuleId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedRuleId),
    );
  }

  factory ActivityLogEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityLogEntry(
      id: serializer.fromJson<int>(json['id']),
      activityType: serializer.fromJson<String>(json['activityType']),
      description: serializer.fromJson<String>(json['description']),
      metadataJson: serializer.fromJson<String?>(json['metadataJson']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      relatedFileId: serializer.fromJson<int?>(json['relatedFileId']),
      relatedRuleId: serializer.fromJson<int?>(json['relatedRuleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'activityType': serializer.toJson<String>(activityType),
      'description': serializer.toJson<String>(description),
      'metadataJson': serializer.toJson<String?>(metadataJson),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'relatedFileId': serializer.toJson<int?>(relatedFileId),
      'relatedRuleId': serializer.toJson<int?>(relatedRuleId),
    };
  }

  ActivityLogEntry copyWith({
    int? id,
    String? activityType,
    String? description,
    Value<String?> metadataJson = const Value.absent(),
    DateTime? timestamp,
    Value<int?> relatedFileId = const Value.absent(),
    Value<int?> relatedRuleId = const Value.absent(),
  }) => ActivityLogEntry(
    id: id ?? this.id,
    activityType: activityType ?? this.activityType,
    description: description ?? this.description,
    metadataJson: metadataJson.present ? metadataJson.value : this.metadataJson,
    timestamp: timestamp ?? this.timestamp,
    relatedFileId: relatedFileId.present
        ? relatedFileId.value
        : this.relatedFileId,
    relatedRuleId: relatedRuleId.present
        ? relatedRuleId.value
        : this.relatedRuleId,
  );
  ActivityLogEntry copyWithCompanion(ActivityLogCompanion data) {
    return ActivityLogEntry(
      id: data.id.present ? data.id.value : this.id,
      activityType: data.activityType.present
          ? data.activityType.value
          : this.activityType,
      description: data.description.present
          ? data.description.value
          : this.description,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      relatedFileId: data.relatedFileId.present
          ? data.relatedFileId.value
          : this.relatedFileId,
      relatedRuleId: data.relatedRuleId.present
          ? data.relatedRuleId.value
          : this.relatedRuleId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityLogEntry(')
          ..write('id: $id, ')
          ..write('activityType: $activityType, ')
          ..write('description: $description, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('timestamp: $timestamp, ')
          ..write('relatedFileId: $relatedFileId, ')
          ..write('relatedRuleId: $relatedRuleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    activityType,
    description,
    metadataJson,
    timestamp,
    relatedFileId,
    relatedRuleId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityLogEntry &&
          other.id == this.id &&
          other.activityType == this.activityType &&
          other.description == this.description &&
          other.metadataJson == this.metadataJson &&
          other.timestamp == this.timestamp &&
          other.relatedFileId == this.relatedFileId &&
          other.relatedRuleId == this.relatedRuleId);
}

class ActivityLogCompanion extends UpdateCompanion<ActivityLogEntry> {
  final Value<int> id;
  final Value<String> activityType;
  final Value<String> description;
  final Value<String?> metadataJson;
  final Value<DateTime> timestamp;
  final Value<int?> relatedFileId;
  final Value<int?> relatedRuleId;
  const ActivityLogCompanion({
    this.id = const Value.absent(),
    this.activityType = const Value.absent(),
    this.description = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.relatedFileId = const Value.absent(),
    this.relatedRuleId = const Value.absent(),
  });
  ActivityLogCompanion.insert({
    this.id = const Value.absent(),
    required String activityType,
    required String description,
    this.metadataJson = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.relatedFileId = const Value.absent(),
    this.relatedRuleId = const Value.absent(),
  }) : activityType = Value(activityType),
       description = Value(description);
  static Insertable<ActivityLogEntry> custom({
    Expression<int>? id,
    Expression<String>? activityType,
    Expression<String>? description,
    Expression<String>? metadataJson,
    Expression<DateTime>? timestamp,
    Expression<int>? relatedFileId,
    Expression<int>? relatedRuleId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (activityType != null) 'activity_type': activityType,
      if (description != null) 'description': description,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (timestamp != null) 'timestamp': timestamp,
      if (relatedFileId != null) 'related_file_id': relatedFileId,
      if (relatedRuleId != null) 'related_rule_id': relatedRuleId,
    });
  }

  ActivityLogCompanion copyWith({
    Value<int>? id,
    Value<String>? activityType,
    Value<String>? description,
    Value<String?>? metadataJson,
    Value<DateTime>? timestamp,
    Value<int?>? relatedFileId,
    Value<int?>? relatedRuleId,
  }) {
    return ActivityLogCompanion(
      id: id ?? this.id,
      activityType: activityType ?? this.activityType,
      description: description ?? this.description,
      metadataJson: metadataJson ?? this.metadataJson,
      timestamp: timestamp ?? this.timestamp,
      relatedFileId: relatedFileId ?? this.relatedFileId,
      relatedRuleId: relatedRuleId ?? this.relatedRuleId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (activityType.present) {
      map['activity_type'] = Variable<String>(activityType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (relatedFileId.present) {
      map['related_file_id'] = Variable<int>(relatedFileId.value);
    }
    if (relatedRuleId.present) {
      map['related_rule_id'] = Variable<int>(relatedRuleId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityLogCompanion(')
          ..write('id: $id, ')
          ..write('activityType: $activityType, ')
          ..write('description: $description, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('timestamp: $timestamp, ')
          ..write('relatedFileId: $relatedFileId, ')
          ..write('relatedRuleId: $relatedRuleId')
          ..write(')'))
        .toString();
  }
}

class $FilesFtsTable extends FilesFts
    with TableInfo<$FilesFtsTable, FilesFtsEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FilesFtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  @override
  late final GeneratedColumn<int> fileId = GeneratedColumn<int>(
    'file_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [fileId, content, fileName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'files_fts';
  @override
  VerificationContext validateIntegrity(
    Insertable<FilesFtsEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('file_id')) {
      context.handle(
        _fileIdMeta,
        fileId.isAcceptableOrUnknown(data['file_id']!, _fileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fileIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  FilesFtsEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FilesFtsEntry(
      fileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
    );
  }

  @override
  $FilesFtsTable createAlias(String alias) {
    return $FilesFtsTable(attachedDatabase, alias);
  }
}

class FilesFtsEntry extends DataClass implements Insertable<FilesFtsEntry> {
  final int fileId;
  final String content;
  final String fileName;
  const FilesFtsEntry({
    required this.fileId,
    required this.content,
    required this.fileName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['file_id'] = Variable<int>(fileId);
    map['content'] = Variable<String>(content);
    map['file_name'] = Variable<String>(fileName);
    return map;
  }

  FilesFtsCompanion toCompanion(bool nullToAbsent) {
    return FilesFtsCompanion(
      fileId: Value(fileId),
      content: Value(content),
      fileName: Value(fileName),
    );
  }

  factory FilesFtsEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FilesFtsEntry(
      fileId: serializer.fromJson<int>(json['fileId']),
      content: serializer.fromJson<String>(json['content']),
      fileName: serializer.fromJson<String>(json['fileName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'fileId': serializer.toJson<int>(fileId),
      'content': serializer.toJson<String>(content),
      'fileName': serializer.toJson<String>(fileName),
    };
  }

  FilesFtsEntry copyWith({int? fileId, String? content, String? fileName}) =>
      FilesFtsEntry(
        fileId: fileId ?? this.fileId,
        content: content ?? this.content,
        fileName: fileName ?? this.fileName,
      );
  FilesFtsEntry copyWithCompanion(FilesFtsCompanion data) {
    return FilesFtsEntry(
      fileId: data.fileId.present ? data.fileId.value : this.fileId,
      content: data.content.present ? data.content.value : this.content,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FilesFtsEntry(')
          ..write('fileId: $fileId, ')
          ..write('content: $content, ')
          ..write('fileName: $fileName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(fileId, content, fileName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FilesFtsEntry &&
          other.fileId == this.fileId &&
          other.content == this.content &&
          other.fileName == this.fileName);
}

class FilesFtsCompanion extends UpdateCompanion<FilesFtsEntry> {
  final Value<int> fileId;
  final Value<String> content;
  final Value<String> fileName;
  final Value<int> rowid;
  const FilesFtsCompanion({
    this.fileId = const Value.absent(),
    this.content = const Value.absent(),
    this.fileName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FilesFtsCompanion.insert({
    required int fileId,
    required String content,
    required String fileName,
    this.rowid = const Value.absent(),
  }) : fileId = Value(fileId),
       content = Value(content),
       fileName = Value(fileName);
  static Insertable<FilesFtsEntry> custom({
    Expression<int>? fileId,
    Expression<String>? content,
    Expression<String>? fileName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (fileId != null) 'file_id': fileId,
      if (content != null) 'content': content,
      if (fileName != null) 'file_name': fileName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FilesFtsCompanion copyWith({
    Value<int>? fileId,
    Value<String>? content,
    Value<String>? fileName,
    Value<int>? rowid,
  }) {
    return FilesFtsCompanion(
      fileId: fileId ?? this.fileId,
      content: content ?? this.content,
      fileName: fileName ?? this.fileName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (fileId.present) {
      map['file_id'] = Variable<int>(fileId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FilesFtsCompanion(')
          ..write('fileId: $fileId, ')
          ..write('content: $content, ')
          ..write('fileName: $fileName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$FiloDatabase extends GeneratedDatabase {
  _$FiloDatabase(QueryExecutor e) : super(e);
  $FiloDatabaseManager get managers => $FiloDatabaseManager(this);
  late final $FilesIndexTable filesIndex = $FilesIndexTable(this);
  late final $ExtractedTextTable extractedText = $ExtractedTextTable(this);
  late final $ImageLabelsTable imageLabels = $ImageLabelsTable(this);
  late final $EmbeddingsTable embeddings = $EmbeddingsTable(this);
  late final $RulesTable rules = $RulesTable(this);
  late final $RuleExecutionLogTable ruleExecutionLog = $RuleExecutionLogTable(
    this,
  );
  late final $ActivityLogTable activityLog = $ActivityLogTable(this);
  late final $FilesFtsTable filesFts = $FilesFtsTable(this);
  late final FilesDao filesDao = FilesDao(this as FiloDatabase);
  late final SearchDao searchDao = SearchDao(this as FiloDatabase);
  late final RulesDao rulesDao = RulesDao(this as FiloDatabase);
  late final ActivityLogDao activityLogDao = ActivityLogDao(
    this as FiloDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    filesIndex,
    extractedText,
    imageLabels,
    embeddings,
    rules,
    ruleExecutionLog,
    activityLog,
    filesFts,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'files_index',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('extracted_text', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'files_index',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('image_labels', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'files_index',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('embeddings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'rules',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('rule_execution_log', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'files_index',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('rule_execution_log', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'files_index',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('activity_log', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'rules',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('activity_log', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$FilesIndexTableCreateCompanionBuilder =
    FilesIndexCompanion Function({
      Value<int> id,
      required String uri,
      required String normalizedName,
      required String mime,
      required int size,
      required DateTime createdAt,
      required DateTime modifiedAt,
      Value<String?> parentUri,
      required String checksum,
      Value<bool> isIndexed,
      Value<DateTime?> lastIndexedAt,
    });
typedef $$FilesIndexTableUpdateCompanionBuilder =
    FilesIndexCompanion Function({
      Value<int> id,
      Value<String> uri,
      Value<String> normalizedName,
      Value<String> mime,
      Value<int> size,
      Value<DateTime> createdAt,
      Value<DateTime> modifiedAt,
      Value<String?> parentUri,
      Value<String> checksum,
      Value<bool> isIndexed,
      Value<DateTime?> lastIndexedAt,
    });

final class $$FilesIndexTableReferences
    extends BaseReferences<_$FiloDatabase, $FilesIndexTable, FileIndexEntry> {
  $$FilesIndexTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ExtractedTextTable, List<ExtractedTextEntry>>
  _extractedTextRefsTable(_$FiloDatabase db) => MultiTypedResultKey.fromTable(
    db.extractedText,
    aliasName: $_aliasNameGenerator(db.filesIndex.id, db.extractedText.fileId),
  );

  $$ExtractedTextTableProcessedTableManager get extractedTextRefs {
    final manager = $$ExtractedTextTableTableManager(
      $_db,
      $_db.extractedText,
    ).filter((f) => f.fileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_extractedTextRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ImageLabelsTable, List<ImageLabel>>
  _imageLabelsRefsTable(_$FiloDatabase db) => MultiTypedResultKey.fromTable(
    db.imageLabels,
    aliasName: $_aliasNameGenerator(db.filesIndex.id, db.imageLabels.fileId),
  );

  $$ImageLabelsTableProcessedTableManager get imageLabelsRefs {
    final manager = $$ImageLabelsTableTableManager(
      $_db,
      $_db.imageLabels,
    ).filter((f) => f.fileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_imageLabelsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EmbeddingsTable, List<Embedding>>
  _embeddingsRefsTable(_$FiloDatabase db) => MultiTypedResultKey.fromTable(
    db.embeddings,
    aliasName: $_aliasNameGenerator(db.filesIndex.id, db.embeddings.fileId),
  );

  $$EmbeddingsTableProcessedTableManager get embeddingsRefs {
    final manager = $$EmbeddingsTableTableManager(
      $_db,
      $_db.embeddings,
    ).filter((f) => f.fileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_embeddingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $RuleExecutionLogTable,
    List<RuleExecutionLogEntry>
  >
  _ruleExecutionLogRefsTable(_$FiloDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.ruleExecutionLog,
        aliasName: $_aliasNameGenerator(
          db.filesIndex.id,
          db.ruleExecutionLog.fileId,
        ),
      );

  $$RuleExecutionLogTableProcessedTableManager get ruleExecutionLogRefs {
    final manager = $$RuleExecutionLogTableTableManager(
      $_db,
      $_db.ruleExecutionLog,
    ).filter((f) => f.fileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _ruleExecutionLogRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ActivityLogTable, List<ActivityLogEntry>>
  _activityLogRefsTable(_$FiloDatabase db) => MultiTypedResultKey.fromTable(
    db.activityLog,
    aliasName: $_aliasNameGenerator(
      db.filesIndex.id,
      db.activityLog.relatedFileId,
    ),
  );

  $$ActivityLogTableProcessedTableManager get activityLogRefs {
    final manager = $$ActivityLogTableTableManager(
      $_db,
      $_db.activityLog,
    ).filter((f) => f.relatedFileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_activityLogRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FilesIndexTableFilterComposer
    extends Composer<_$FiloDatabase, $FilesIndexTable> {
  $$FilesIndexTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uri => $composableBuilder(
    column: $table.uri,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mime => $composableBuilder(
    column: $table.mime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentUri => $composableBuilder(
    column: $table.parentUri,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checksum => $composableBuilder(
    column: $table.checksum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isIndexed => $composableBuilder(
    column: $table.isIndexed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastIndexedAt => $composableBuilder(
    column: $table.lastIndexedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> extractedTextRefs(
    Expression<bool> Function($$ExtractedTextTableFilterComposer f) f,
  ) {
    final $$ExtractedTextTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.extractedText,
      getReferencedColumn: (t) => t.fileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExtractedTextTableFilterComposer(
            $db: $db,
            $table: $db.extractedText,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> imageLabelsRefs(
    Expression<bool> Function($$ImageLabelsTableFilterComposer f) f,
  ) {
    final $$ImageLabelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.imageLabels,
      getReferencedColumn: (t) => t.fileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImageLabelsTableFilterComposer(
            $db: $db,
            $table: $db.imageLabels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> embeddingsRefs(
    Expression<bool> Function($$EmbeddingsTableFilterComposer f) f,
  ) {
    final $$EmbeddingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.embeddings,
      getReferencedColumn: (t) => t.fileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmbeddingsTableFilterComposer(
            $db: $db,
            $table: $db.embeddings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ruleExecutionLogRefs(
    Expression<bool> Function($$RuleExecutionLogTableFilterComposer f) f,
  ) {
    final $$RuleExecutionLogTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ruleExecutionLog,
      getReferencedColumn: (t) => t.fileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RuleExecutionLogTableFilterComposer(
            $db: $db,
            $table: $db.ruleExecutionLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> activityLogRefs(
    Expression<bool> Function($$ActivityLogTableFilterComposer f) f,
  ) {
    final $$ActivityLogTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activityLog,
      getReferencedColumn: (t) => t.relatedFileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivityLogTableFilterComposer(
            $db: $db,
            $table: $db.activityLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FilesIndexTableOrderingComposer
    extends Composer<_$FiloDatabase, $FilesIndexTable> {
  $$FilesIndexTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uri => $composableBuilder(
    column: $table.uri,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mime => $composableBuilder(
    column: $table.mime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentUri => $composableBuilder(
    column: $table.parentUri,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checksum => $composableBuilder(
    column: $table.checksum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isIndexed => $composableBuilder(
    column: $table.isIndexed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastIndexedAt => $composableBuilder(
    column: $table.lastIndexedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FilesIndexTableAnnotationComposer
    extends Composer<_$FiloDatabase, $FilesIndexTable> {
  $$FilesIndexTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uri =>
      $composableBuilder(column: $table.uri, builder: (column) => column);

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mime =>
      $composableBuilder(column: $table.mime, builder: (column) => column);

  GeneratedColumn<int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
    column: $table.modifiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parentUri =>
      $composableBuilder(column: $table.parentUri, builder: (column) => column);

  GeneratedColumn<String> get checksum =>
      $composableBuilder(column: $table.checksum, builder: (column) => column);

  GeneratedColumn<bool> get isIndexed =>
      $composableBuilder(column: $table.isIndexed, builder: (column) => column);

  GeneratedColumn<DateTime> get lastIndexedAt => $composableBuilder(
    column: $table.lastIndexedAt,
    builder: (column) => column,
  );

  Expression<T> extractedTextRefs<T extends Object>(
    Expression<T> Function($$ExtractedTextTableAnnotationComposer a) f,
  ) {
    final $$ExtractedTextTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.extractedText,
      getReferencedColumn: (t) => t.fileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExtractedTextTableAnnotationComposer(
            $db: $db,
            $table: $db.extractedText,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> imageLabelsRefs<T extends Object>(
    Expression<T> Function($$ImageLabelsTableAnnotationComposer a) f,
  ) {
    final $$ImageLabelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.imageLabels,
      getReferencedColumn: (t) => t.fileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ImageLabelsTableAnnotationComposer(
            $db: $db,
            $table: $db.imageLabels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> embeddingsRefs<T extends Object>(
    Expression<T> Function($$EmbeddingsTableAnnotationComposer a) f,
  ) {
    final $$EmbeddingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.embeddings,
      getReferencedColumn: (t) => t.fileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmbeddingsTableAnnotationComposer(
            $db: $db,
            $table: $db.embeddings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ruleExecutionLogRefs<T extends Object>(
    Expression<T> Function($$RuleExecutionLogTableAnnotationComposer a) f,
  ) {
    final $$RuleExecutionLogTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ruleExecutionLog,
      getReferencedColumn: (t) => t.fileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RuleExecutionLogTableAnnotationComposer(
            $db: $db,
            $table: $db.ruleExecutionLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> activityLogRefs<T extends Object>(
    Expression<T> Function($$ActivityLogTableAnnotationComposer a) f,
  ) {
    final $$ActivityLogTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activityLog,
      getReferencedColumn: (t) => t.relatedFileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivityLogTableAnnotationComposer(
            $db: $db,
            $table: $db.activityLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FilesIndexTableTableManager
    extends
        RootTableManager<
          _$FiloDatabase,
          $FilesIndexTable,
          FileIndexEntry,
          $$FilesIndexTableFilterComposer,
          $$FilesIndexTableOrderingComposer,
          $$FilesIndexTableAnnotationComposer,
          $$FilesIndexTableCreateCompanionBuilder,
          $$FilesIndexTableUpdateCompanionBuilder,
          (FileIndexEntry, $$FilesIndexTableReferences),
          FileIndexEntry,
          PrefetchHooks Function({
            bool extractedTextRefs,
            bool imageLabelsRefs,
            bool embeddingsRefs,
            bool ruleExecutionLogRefs,
            bool activityLogRefs,
          })
        > {
  $$FilesIndexTableTableManager(_$FiloDatabase db, $FilesIndexTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FilesIndexTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FilesIndexTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FilesIndexTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uri = const Value.absent(),
                Value<String> normalizedName = const Value.absent(),
                Value<String> mime = const Value.absent(),
                Value<int> size = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> modifiedAt = const Value.absent(),
                Value<String?> parentUri = const Value.absent(),
                Value<String> checksum = const Value.absent(),
                Value<bool> isIndexed = const Value.absent(),
                Value<DateTime?> lastIndexedAt = const Value.absent(),
              }) => FilesIndexCompanion(
                id: id,
                uri: uri,
                normalizedName: normalizedName,
                mime: mime,
                size: size,
                createdAt: createdAt,
                modifiedAt: modifiedAt,
                parentUri: parentUri,
                checksum: checksum,
                isIndexed: isIndexed,
                lastIndexedAt: lastIndexedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uri,
                required String normalizedName,
                required String mime,
                required int size,
                required DateTime createdAt,
                required DateTime modifiedAt,
                Value<String?> parentUri = const Value.absent(),
                required String checksum,
                Value<bool> isIndexed = const Value.absent(),
                Value<DateTime?> lastIndexedAt = const Value.absent(),
              }) => FilesIndexCompanion.insert(
                id: id,
                uri: uri,
                normalizedName: normalizedName,
                mime: mime,
                size: size,
                createdAt: createdAt,
                modifiedAt: modifiedAt,
                parentUri: parentUri,
                checksum: checksum,
                isIndexed: isIndexed,
                lastIndexedAt: lastIndexedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FilesIndexTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                extractedTextRefs = false,
                imageLabelsRefs = false,
                embeddingsRefs = false,
                ruleExecutionLogRefs = false,
                activityLogRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (extractedTextRefs) db.extractedText,
                    if (imageLabelsRefs) db.imageLabels,
                    if (embeddingsRefs) db.embeddings,
                    if (ruleExecutionLogRefs) db.ruleExecutionLog,
                    if (activityLogRefs) db.activityLog,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (extractedTextRefs)
                        await $_getPrefetchedData<
                          FileIndexEntry,
                          $FilesIndexTable,
                          ExtractedTextEntry
                        >(
                          currentTable: table,
                          referencedTable: $$FilesIndexTableReferences
                              ._extractedTextRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FilesIndexTableReferences(
                                db,
                                table,
                                p0,
                              ).extractedTextRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (imageLabelsRefs)
                        await $_getPrefetchedData<
                          FileIndexEntry,
                          $FilesIndexTable,
                          ImageLabel
                        >(
                          currentTable: table,
                          referencedTable: $$FilesIndexTableReferences
                              ._imageLabelsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FilesIndexTableReferences(
                                db,
                                table,
                                p0,
                              ).imageLabelsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (embeddingsRefs)
                        await $_getPrefetchedData<
                          FileIndexEntry,
                          $FilesIndexTable,
                          Embedding
                        >(
                          currentTable: table,
                          referencedTable: $$FilesIndexTableReferences
                              ._embeddingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FilesIndexTableReferences(
                                db,
                                table,
                                p0,
                              ).embeddingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ruleExecutionLogRefs)
                        await $_getPrefetchedData<
                          FileIndexEntry,
                          $FilesIndexTable,
                          RuleExecutionLogEntry
                        >(
                          currentTable: table,
                          referencedTable: $$FilesIndexTableReferences
                              ._ruleExecutionLogRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FilesIndexTableReferences(
                                db,
                                table,
                                p0,
                              ).ruleExecutionLogRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (activityLogRefs)
                        await $_getPrefetchedData<
                          FileIndexEntry,
                          $FilesIndexTable,
                          ActivityLogEntry
                        >(
                          currentTable: table,
                          referencedTable: $$FilesIndexTableReferences
                              ._activityLogRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FilesIndexTableReferences(
                                db,
                                table,
                                p0,
                              ).activityLogRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.relatedFileId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FilesIndexTableProcessedTableManager =
    ProcessedTableManager<
      _$FiloDatabase,
      $FilesIndexTable,
      FileIndexEntry,
      $$FilesIndexTableFilterComposer,
      $$FilesIndexTableOrderingComposer,
      $$FilesIndexTableAnnotationComposer,
      $$FilesIndexTableCreateCompanionBuilder,
      $$FilesIndexTableUpdateCompanionBuilder,
      (FileIndexEntry, $$FilesIndexTableReferences),
      FileIndexEntry,
      PrefetchHooks Function({
        bool extractedTextRefs,
        bool imageLabelsRefs,
        bool embeddingsRefs,
        bool ruleExecutionLogRefs,
        bool activityLogRefs,
      })
    >;
typedef $$ExtractedTextTableCreateCompanionBuilder =
    ExtractedTextCompanion Function({
      Value<int> id,
      required int fileId,
      required String content,
      Value<double?> confidence,
      Value<String?> ocrEngineVersion,
      Value<DateTime> extractedAt,
    });
typedef $$ExtractedTextTableUpdateCompanionBuilder =
    ExtractedTextCompanion Function({
      Value<int> id,
      Value<int> fileId,
      Value<String> content,
      Value<double?> confidence,
      Value<String?> ocrEngineVersion,
      Value<DateTime> extractedAt,
    });

final class $$ExtractedTextTableReferences
    extends
        BaseReferences<
          _$FiloDatabase,
          $ExtractedTextTable,
          ExtractedTextEntry
        > {
  $$ExtractedTextTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FilesIndexTable _fileIdTable(_$FiloDatabase db) =>
      db.filesIndex.createAlias(
        $_aliasNameGenerator(db.extractedText.fileId, db.filesIndex.id),
      );

  $$FilesIndexTableProcessedTableManager get fileId {
    final $_column = $_itemColumn<int>('file_id')!;

    final manager = $$FilesIndexTableTableManager(
      $_db,
      $_db.filesIndex,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExtractedTextTableFilterComposer
    extends Composer<_$FiloDatabase, $ExtractedTextTable> {
  $$ExtractedTextTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ocrEngineVersion => $composableBuilder(
    column: $table.ocrEngineVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get extractedAt => $composableBuilder(
    column: $table.extractedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FilesIndexTableFilterComposer get fileId {
    final $$FilesIndexTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileId,
      referencedTable: $db.filesIndex,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesIndexTableFilterComposer(
            $db: $db,
            $table: $db.filesIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExtractedTextTableOrderingComposer
    extends Composer<_$FiloDatabase, $ExtractedTextTable> {
  $$ExtractedTextTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ocrEngineVersion => $composableBuilder(
    column: $table.ocrEngineVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get extractedAt => $composableBuilder(
    column: $table.extractedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FilesIndexTableOrderingComposer get fileId {
    final $$FilesIndexTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileId,
      referencedTable: $db.filesIndex,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesIndexTableOrderingComposer(
            $db: $db,
            $table: $db.filesIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExtractedTextTableAnnotationComposer
    extends Composer<_$FiloDatabase, $ExtractedTextTable> {
  $$ExtractedTextTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ocrEngineVersion => $composableBuilder(
    column: $table.ocrEngineVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get extractedAt => $composableBuilder(
    column: $table.extractedAt,
    builder: (column) => column,
  );

  $$FilesIndexTableAnnotationComposer get fileId {
    final $$FilesIndexTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileId,
      referencedTable: $db.filesIndex,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesIndexTableAnnotationComposer(
            $db: $db,
            $table: $db.filesIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExtractedTextTableTableManager
    extends
        RootTableManager<
          _$FiloDatabase,
          $ExtractedTextTable,
          ExtractedTextEntry,
          $$ExtractedTextTableFilterComposer,
          $$ExtractedTextTableOrderingComposer,
          $$ExtractedTextTableAnnotationComposer,
          $$ExtractedTextTableCreateCompanionBuilder,
          $$ExtractedTextTableUpdateCompanionBuilder,
          (ExtractedTextEntry, $$ExtractedTextTableReferences),
          ExtractedTextEntry,
          PrefetchHooks Function({bool fileId})
        > {
  $$ExtractedTextTableTableManager(_$FiloDatabase db, $ExtractedTextTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExtractedTextTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExtractedTextTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExtractedTextTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fileId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<double?> confidence = const Value.absent(),
                Value<String?> ocrEngineVersion = const Value.absent(),
                Value<DateTime> extractedAt = const Value.absent(),
              }) => ExtractedTextCompanion(
                id: id,
                fileId: fileId,
                content: content,
                confidence: confidence,
                ocrEngineVersion: ocrEngineVersion,
                extractedAt: extractedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fileId,
                required String content,
                Value<double?> confidence = const Value.absent(),
                Value<String?> ocrEngineVersion = const Value.absent(),
                Value<DateTime> extractedAt = const Value.absent(),
              }) => ExtractedTextCompanion.insert(
                id: id,
                fileId: fileId,
                content: content,
                confidence: confidence,
                ocrEngineVersion: ocrEngineVersion,
                extractedAt: extractedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExtractedTextTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fileId,
                                referencedTable: $$ExtractedTextTableReferences
                                    ._fileIdTable(db),
                                referencedColumn: $$ExtractedTextTableReferences
                                    ._fileIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExtractedTextTableProcessedTableManager =
    ProcessedTableManager<
      _$FiloDatabase,
      $ExtractedTextTable,
      ExtractedTextEntry,
      $$ExtractedTextTableFilterComposer,
      $$ExtractedTextTableOrderingComposer,
      $$ExtractedTextTableAnnotationComposer,
      $$ExtractedTextTableCreateCompanionBuilder,
      $$ExtractedTextTableUpdateCompanionBuilder,
      (ExtractedTextEntry, $$ExtractedTextTableReferences),
      ExtractedTextEntry,
      PrefetchHooks Function({bool fileId})
    >;
typedef $$ImageLabelsTableCreateCompanionBuilder =
    ImageLabelsCompanion Function({
      Value<int> id,
      required int fileId,
      required String label,
      required double confidence,
      Value<String?> modelVersion,
      Value<DateTime> labeledAt,
    });
typedef $$ImageLabelsTableUpdateCompanionBuilder =
    ImageLabelsCompanion Function({
      Value<int> id,
      Value<int> fileId,
      Value<String> label,
      Value<double> confidence,
      Value<String?> modelVersion,
      Value<DateTime> labeledAt,
    });

final class $$ImageLabelsTableReferences
    extends BaseReferences<_$FiloDatabase, $ImageLabelsTable, ImageLabel> {
  $$ImageLabelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FilesIndexTable _fileIdTable(_$FiloDatabase db) =>
      db.filesIndex.createAlias(
        $_aliasNameGenerator(db.imageLabels.fileId, db.filesIndex.id),
      );

  $$FilesIndexTableProcessedTableManager get fileId {
    final $_column = $_itemColumn<int>('file_id')!;

    final manager = $$FilesIndexTableTableManager(
      $_db,
      $_db.filesIndex,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ImageLabelsTableFilterComposer
    extends Composer<_$FiloDatabase, $ImageLabelsTable> {
  $$ImageLabelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get labeledAt => $composableBuilder(
    column: $table.labeledAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FilesIndexTableFilterComposer get fileId {
    final $$FilesIndexTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileId,
      referencedTable: $db.filesIndex,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesIndexTableFilterComposer(
            $db: $db,
            $table: $db.filesIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ImageLabelsTableOrderingComposer
    extends Composer<_$FiloDatabase, $ImageLabelsTable> {
  $$ImageLabelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get labeledAt => $composableBuilder(
    column: $table.labeledAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FilesIndexTableOrderingComposer get fileId {
    final $$FilesIndexTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileId,
      referencedTable: $db.filesIndex,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesIndexTableOrderingComposer(
            $db: $db,
            $table: $db.filesIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ImageLabelsTableAnnotationComposer
    extends Composer<_$FiloDatabase, $ImageLabelsTable> {
  $$ImageLabelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get labeledAt =>
      $composableBuilder(column: $table.labeledAt, builder: (column) => column);

  $$FilesIndexTableAnnotationComposer get fileId {
    final $$FilesIndexTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileId,
      referencedTable: $db.filesIndex,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesIndexTableAnnotationComposer(
            $db: $db,
            $table: $db.filesIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ImageLabelsTableTableManager
    extends
        RootTableManager<
          _$FiloDatabase,
          $ImageLabelsTable,
          ImageLabel,
          $$ImageLabelsTableFilterComposer,
          $$ImageLabelsTableOrderingComposer,
          $$ImageLabelsTableAnnotationComposer,
          $$ImageLabelsTableCreateCompanionBuilder,
          $$ImageLabelsTableUpdateCompanionBuilder,
          (ImageLabel, $$ImageLabelsTableReferences),
          ImageLabel,
          PrefetchHooks Function({bool fileId})
        > {
  $$ImageLabelsTableTableManager(_$FiloDatabase db, $ImageLabelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImageLabelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImageLabelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImageLabelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fileId = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<String?> modelVersion = const Value.absent(),
                Value<DateTime> labeledAt = const Value.absent(),
              }) => ImageLabelsCompanion(
                id: id,
                fileId: fileId,
                label: label,
                confidence: confidence,
                modelVersion: modelVersion,
                labeledAt: labeledAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fileId,
                required String label,
                required double confidence,
                Value<String?> modelVersion = const Value.absent(),
                Value<DateTime> labeledAt = const Value.absent(),
              }) => ImageLabelsCompanion.insert(
                id: id,
                fileId: fileId,
                label: label,
                confidence: confidence,
                modelVersion: modelVersion,
                labeledAt: labeledAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ImageLabelsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fileId,
                                referencedTable: $$ImageLabelsTableReferences
                                    ._fileIdTable(db),
                                referencedColumn: $$ImageLabelsTableReferences
                                    ._fileIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ImageLabelsTableProcessedTableManager =
    ProcessedTableManager<
      _$FiloDatabase,
      $ImageLabelsTable,
      ImageLabel,
      $$ImageLabelsTableFilterComposer,
      $$ImageLabelsTableOrderingComposer,
      $$ImageLabelsTableAnnotationComposer,
      $$ImageLabelsTableCreateCompanionBuilder,
      $$ImageLabelsTableUpdateCompanionBuilder,
      (ImageLabel, $$ImageLabelsTableReferences),
      ImageLabel,
      PrefetchHooks Function({bool fileId})
    >;
typedef $$EmbeddingsTableCreateCompanionBuilder =
    EmbeddingsCompanion Function({
      Value<int> id,
      required int fileId,
      required Uint8List vector,
      required int dim,
      required String modelVersion,
      Value<String?> quantizationLevel,
      Value<DateTime> createdAt,
    });
typedef $$EmbeddingsTableUpdateCompanionBuilder =
    EmbeddingsCompanion Function({
      Value<int> id,
      Value<int> fileId,
      Value<Uint8List> vector,
      Value<int> dim,
      Value<String> modelVersion,
      Value<String?> quantizationLevel,
      Value<DateTime> createdAt,
    });

final class $$EmbeddingsTableReferences
    extends BaseReferences<_$FiloDatabase, $EmbeddingsTable, Embedding> {
  $$EmbeddingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FilesIndexTable _fileIdTable(_$FiloDatabase db) =>
      db.filesIndex.createAlias(
        $_aliasNameGenerator(db.embeddings.fileId, db.filesIndex.id),
      );

  $$FilesIndexTableProcessedTableManager get fileId {
    final $_column = $_itemColumn<int>('file_id')!;

    final manager = $$FilesIndexTableTableManager(
      $_db,
      $_db.filesIndex,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EmbeddingsTableFilterComposer
    extends Composer<_$FiloDatabase, $EmbeddingsTable> {
  $$EmbeddingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get vector => $composableBuilder(
    column: $table.vector,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dim => $composableBuilder(
    column: $table.dim,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quantizationLevel => $composableBuilder(
    column: $table.quantizationLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FilesIndexTableFilterComposer get fileId {
    final $$FilesIndexTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileId,
      referencedTable: $db.filesIndex,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesIndexTableFilterComposer(
            $db: $db,
            $table: $db.filesIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmbeddingsTableOrderingComposer
    extends Composer<_$FiloDatabase, $EmbeddingsTable> {
  $$EmbeddingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get vector => $composableBuilder(
    column: $table.vector,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dim => $composableBuilder(
    column: $table.dim,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quantizationLevel => $composableBuilder(
    column: $table.quantizationLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FilesIndexTableOrderingComposer get fileId {
    final $$FilesIndexTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileId,
      referencedTable: $db.filesIndex,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesIndexTableOrderingComposer(
            $db: $db,
            $table: $db.filesIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmbeddingsTableAnnotationComposer
    extends Composer<_$FiloDatabase, $EmbeddingsTable> {
  $$EmbeddingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<Uint8List> get vector =>
      $composableBuilder(column: $table.vector, builder: (column) => column);

  GeneratedColumn<int> get dim =>
      $composableBuilder(column: $table.dim, builder: (column) => column);

  GeneratedColumn<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quantizationLevel => $composableBuilder(
    column: $table.quantizationLevel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$FilesIndexTableAnnotationComposer get fileId {
    final $$FilesIndexTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileId,
      referencedTable: $db.filesIndex,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesIndexTableAnnotationComposer(
            $db: $db,
            $table: $db.filesIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmbeddingsTableTableManager
    extends
        RootTableManager<
          _$FiloDatabase,
          $EmbeddingsTable,
          Embedding,
          $$EmbeddingsTableFilterComposer,
          $$EmbeddingsTableOrderingComposer,
          $$EmbeddingsTableAnnotationComposer,
          $$EmbeddingsTableCreateCompanionBuilder,
          $$EmbeddingsTableUpdateCompanionBuilder,
          (Embedding, $$EmbeddingsTableReferences),
          Embedding,
          PrefetchHooks Function({bool fileId})
        > {
  $$EmbeddingsTableTableManager(_$FiloDatabase db, $EmbeddingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmbeddingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmbeddingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmbeddingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fileId = const Value.absent(),
                Value<Uint8List> vector = const Value.absent(),
                Value<int> dim = const Value.absent(),
                Value<String> modelVersion = const Value.absent(),
                Value<String?> quantizationLevel = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EmbeddingsCompanion(
                id: id,
                fileId: fileId,
                vector: vector,
                dim: dim,
                modelVersion: modelVersion,
                quantizationLevel: quantizationLevel,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fileId,
                required Uint8List vector,
                required int dim,
                required String modelVersion,
                Value<String?> quantizationLevel = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EmbeddingsCompanion.insert(
                id: id,
                fileId: fileId,
                vector: vector,
                dim: dim,
                modelVersion: modelVersion,
                quantizationLevel: quantizationLevel,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EmbeddingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fileId,
                                referencedTable: $$EmbeddingsTableReferences
                                    ._fileIdTable(db),
                                referencedColumn: $$EmbeddingsTableReferences
                                    ._fileIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EmbeddingsTableProcessedTableManager =
    ProcessedTableManager<
      _$FiloDatabase,
      $EmbeddingsTable,
      Embedding,
      $$EmbeddingsTableFilterComposer,
      $$EmbeddingsTableOrderingComposer,
      $$EmbeddingsTableAnnotationComposer,
      $$EmbeddingsTableCreateCompanionBuilder,
      $$EmbeddingsTableUpdateCompanionBuilder,
      (Embedding, $$EmbeddingsTableReferences),
      Embedding,
      PrefetchHooks Function({bool fileId})
    >;
typedef $$RulesTableCreateCompanionBuilder =
    RulesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      required String conditionsJson,
      required String actionsJson,
      Value<bool> isEnabled,
      Value<int> priority,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> lastExecutedAt,
    });
typedef $$RulesTableUpdateCompanionBuilder =
    RulesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String> conditionsJson,
      Value<String> actionsJson,
      Value<bool> isEnabled,
      Value<int> priority,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> lastExecutedAt,
    });

final class $$RulesTableReferences
    extends BaseReferences<_$FiloDatabase, $RulesTable, Rule> {
  $$RulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $RuleExecutionLogTable,
    List<RuleExecutionLogEntry>
  >
  _ruleExecutionLogRefsTable(_$FiloDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.ruleExecutionLog,
        aliasName: $_aliasNameGenerator(
          db.rules.id,
          db.ruleExecutionLog.ruleId,
        ),
      );

  $$RuleExecutionLogTableProcessedTableManager get ruleExecutionLogRefs {
    final manager = $$RuleExecutionLogTableTableManager(
      $_db,
      $_db.ruleExecutionLog,
    ).filter((f) => f.ruleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _ruleExecutionLogRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ActivityLogTable, List<ActivityLogEntry>>
  _activityLogRefsTable(_$FiloDatabase db) => MultiTypedResultKey.fromTable(
    db.activityLog,
    aliasName: $_aliasNameGenerator(db.rules.id, db.activityLog.relatedRuleId),
  );

  $$ActivityLogTableProcessedTableManager get activityLogRefs {
    final manager = $$ActivityLogTableTableManager(
      $_db,
      $_db.activityLog,
    ).filter((f) => f.relatedRuleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_activityLogRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RulesTableFilterComposer extends Composer<_$FiloDatabase, $RulesTable> {
  $$RulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conditionsJson => $composableBuilder(
    column: $table.conditionsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actionsJson => $composableBuilder(
    column: $table.actionsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastExecutedAt => $composableBuilder(
    column: $table.lastExecutedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ruleExecutionLogRefs(
    Expression<bool> Function($$RuleExecutionLogTableFilterComposer f) f,
  ) {
    final $$RuleExecutionLogTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ruleExecutionLog,
      getReferencedColumn: (t) => t.ruleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RuleExecutionLogTableFilterComposer(
            $db: $db,
            $table: $db.ruleExecutionLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> activityLogRefs(
    Expression<bool> Function($$ActivityLogTableFilterComposer f) f,
  ) {
    final $$ActivityLogTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activityLog,
      getReferencedColumn: (t) => t.relatedRuleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivityLogTableFilterComposer(
            $db: $db,
            $table: $db.activityLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RulesTableOrderingComposer
    extends Composer<_$FiloDatabase, $RulesTable> {
  $$RulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conditionsJson => $composableBuilder(
    column: $table.conditionsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actionsJson => $composableBuilder(
    column: $table.actionsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastExecutedAt => $composableBuilder(
    column: $table.lastExecutedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RulesTableAnnotationComposer
    extends Composer<_$FiloDatabase, $RulesTable> {
  $$RulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get conditionsJson => $composableBuilder(
    column: $table.conditionsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actionsJson => $composableBuilder(
    column: $table.actionsJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastExecutedAt => $composableBuilder(
    column: $table.lastExecutedAt,
    builder: (column) => column,
  );

  Expression<T> ruleExecutionLogRefs<T extends Object>(
    Expression<T> Function($$RuleExecutionLogTableAnnotationComposer a) f,
  ) {
    final $$RuleExecutionLogTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ruleExecutionLog,
      getReferencedColumn: (t) => t.ruleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RuleExecutionLogTableAnnotationComposer(
            $db: $db,
            $table: $db.ruleExecutionLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> activityLogRefs<T extends Object>(
    Expression<T> Function($$ActivityLogTableAnnotationComposer a) f,
  ) {
    final $$ActivityLogTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activityLog,
      getReferencedColumn: (t) => t.relatedRuleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivityLogTableAnnotationComposer(
            $db: $db,
            $table: $db.activityLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RulesTableTableManager
    extends
        RootTableManager<
          _$FiloDatabase,
          $RulesTable,
          Rule,
          $$RulesTableFilterComposer,
          $$RulesTableOrderingComposer,
          $$RulesTableAnnotationComposer,
          $$RulesTableCreateCompanionBuilder,
          $$RulesTableUpdateCompanionBuilder,
          (Rule, $$RulesTableReferences),
          Rule,
          PrefetchHooks Function({
            bool ruleExecutionLogRefs,
            bool activityLogRefs,
          })
        > {
  $$RulesTableTableManager(_$FiloDatabase db, $RulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> conditionsJson = const Value.absent(),
                Value<String> actionsJson = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastExecutedAt = const Value.absent(),
              }) => RulesCompanion(
                id: id,
                name: name,
                description: description,
                conditionsJson: conditionsJson,
                actionsJson: actionsJson,
                isEnabled: isEnabled,
                priority: priority,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastExecutedAt: lastExecutedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                required String conditionsJson,
                required String actionsJson,
                Value<bool> isEnabled = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastExecutedAt = const Value.absent(),
              }) => RulesCompanion.insert(
                id: id,
                name: name,
                description: description,
                conditionsJson: conditionsJson,
                actionsJson: actionsJson,
                isEnabled: isEnabled,
                priority: priority,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastExecutedAt: lastExecutedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$RulesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({ruleExecutionLogRefs = false, activityLogRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ruleExecutionLogRefs) db.ruleExecutionLog,
                    if (activityLogRefs) db.activityLog,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ruleExecutionLogRefs)
                        await $_getPrefetchedData<
                          Rule,
                          $RulesTable,
                          RuleExecutionLogEntry
                        >(
                          currentTable: table,
                          referencedTable: $$RulesTableReferences
                              ._ruleExecutionLogRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RulesTableReferences(
                                db,
                                table,
                                p0,
                              ).ruleExecutionLogRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ruleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (activityLogRefs)
                        await $_getPrefetchedData<
                          Rule,
                          $RulesTable,
                          ActivityLogEntry
                        >(
                          currentTable: table,
                          referencedTable: $$RulesTableReferences
                              ._activityLogRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RulesTableReferences(
                                db,
                                table,
                                p0,
                              ).activityLogRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.relatedRuleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RulesTableProcessedTableManager =
    ProcessedTableManager<
      _$FiloDatabase,
      $RulesTable,
      Rule,
      $$RulesTableFilterComposer,
      $$RulesTableOrderingComposer,
      $$RulesTableAnnotationComposer,
      $$RulesTableCreateCompanionBuilder,
      $$RulesTableUpdateCompanionBuilder,
      (Rule, $$RulesTableReferences),
      Rule,
      PrefetchHooks Function({bool ruleExecutionLogRefs, bool activityLogRefs})
    >;
typedef $$RuleExecutionLogTableCreateCompanionBuilder =
    RuleExecutionLogCompanion Function({
      Value<int> id,
      required int ruleId,
      required int fileId,
      required String status,
      Value<String?> errorMessage,
      Value<DateTime> executedAt,
      Value<int?> durationMs,
    });
typedef $$RuleExecutionLogTableUpdateCompanionBuilder =
    RuleExecutionLogCompanion Function({
      Value<int> id,
      Value<int> ruleId,
      Value<int> fileId,
      Value<String> status,
      Value<String?> errorMessage,
      Value<DateTime> executedAt,
      Value<int?> durationMs,
    });

final class $$RuleExecutionLogTableReferences
    extends
        BaseReferences<
          _$FiloDatabase,
          $RuleExecutionLogTable,
          RuleExecutionLogEntry
        > {
  $$RuleExecutionLogTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RulesTable _ruleIdTable(_$FiloDatabase db) => db.rules.createAlias(
    $_aliasNameGenerator(db.ruleExecutionLog.ruleId, db.rules.id),
  );

  $$RulesTableProcessedTableManager get ruleId {
    final $_column = $_itemColumn<int>('rule_id')!;

    final manager = $$RulesTableTableManager(
      $_db,
      $_db.rules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ruleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FilesIndexTable _fileIdTable(_$FiloDatabase db) =>
      db.filesIndex.createAlias(
        $_aliasNameGenerator(db.ruleExecutionLog.fileId, db.filesIndex.id),
      );

  $$FilesIndexTableProcessedTableManager get fileId {
    final $_column = $_itemColumn<int>('file_id')!;

    final manager = $$FilesIndexTableTableManager(
      $_db,
      $_db.filesIndex,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RuleExecutionLogTableFilterComposer
    extends Composer<_$FiloDatabase, $RuleExecutionLogTable> {
  $$RuleExecutionLogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get executedAt => $composableBuilder(
    column: $table.executedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  $$RulesTableFilterComposer get ruleId {
    final $$RulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.rules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RulesTableFilterComposer(
            $db: $db,
            $table: $db.rules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FilesIndexTableFilterComposer get fileId {
    final $$FilesIndexTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileId,
      referencedTable: $db.filesIndex,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesIndexTableFilterComposer(
            $db: $db,
            $table: $db.filesIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RuleExecutionLogTableOrderingComposer
    extends Composer<_$FiloDatabase, $RuleExecutionLogTable> {
  $$RuleExecutionLogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get executedAt => $composableBuilder(
    column: $table.executedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$RulesTableOrderingComposer get ruleId {
    final $$RulesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.rules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RulesTableOrderingComposer(
            $db: $db,
            $table: $db.rules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FilesIndexTableOrderingComposer get fileId {
    final $$FilesIndexTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileId,
      referencedTable: $db.filesIndex,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesIndexTableOrderingComposer(
            $db: $db,
            $table: $db.filesIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RuleExecutionLogTableAnnotationComposer
    extends Composer<_$FiloDatabase, $RuleExecutionLogTable> {
  $$RuleExecutionLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get executedAt => $composableBuilder(
    column: $table.executedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  $$RulesTableAnnotationComposer get ruleId {
    final $$RulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.rules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RulesTableAnnotationComposer(
            $db: $db,
            $table: $db.rules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FilesIndexTableAnnotationComposer get fileId {
    final $$FilesIndexTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fileId,
      referencedTable: $db.filesIndex,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesIndexTableAnnotationComposer(
            $db: $db,
            $table: $db.filesIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RuleExecutionLogTableTableManager
    extends
        RootTableManager<
          _$FiloDatabase,
          $RuleExecutionLogTable,
          RuleExecutionLogEntry,
          $$RuleExecutionLogTableFilterComposer,
          $$RuleExecutionLogTableOrderingComposer,
          $$RuleExecutionLogTableAnnotationComposer,
          $$RuleExecutionLogTableCreateCompanionBuilder,
          $$RuleExecutionLogTableUpdateCompanionBuilder,
          (RuleExecutionLogEntry, $$RuleExecutionLogTableReferences),
          RuleExecutionLogEntry,
          PrefetchHooks Function({bool ruleId, bool fileId})
        > {
  $$RuleExecutionLogTableTableManager(
    _$FiloDatabase db,
    $RuleExecutionLogTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RuleExecutionLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RuleExecutionLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RuleExecutionLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ruleId = const Value.absent(),
                Value<int> fileId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> executedAt = const Value.absent(),
                Value<int?> durationMs = const Value.absent(),
              }) => RuleExecutionLogCompanion(
                id: id,
                ruleId: ruleId,
                fileId: fileId,
                status: status,
                errorMessage: errorMessage,
                executedAt: executedAt,
                durationMs: durationMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ruleId,
                required int fileId,
                required String status,
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> executedAt = const Value.absent(),
                Value<int?> durationMs = const Value.absent(),
              }) => RuleExecutionLogCompanion.insert(
                id: id,
                ruleId: ruleId,
                fileId: fileId,
                status: status,
                errorMessage: errorMessage,
                executedAt: executedAt,
                durationMs: durationMs,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RuleExecutionLogTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ruleId = false, fileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ruleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ruleId,
                                referencedTable:
                                    $$RuleExecutionLogTableReferences
                                        ._ruleIdTable(db),
                                referencedColumn:
                                    $$RuleExecutionLogTableReferences
                                        ._ruleIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (fileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fileId,
                                referencedTable:
                                    $$RuleExecutionLogTableReferences
                                        ._fileIdTable(db),
                                referencedColumn:
                                    $$RuleExecutionLogTableReferences
                                        ._fileIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RuleExecutionLogTableProcessedTableManager =
    ProcessedTableManager<
      _$FiloDatabase,
      $RuleExecutionLogTable,
      RuleExecutionLogEntry,
      $$RuleExecutionLogTableFilterComposer,
      $$RuleExecutionLogTableOrderingComposer,
      $$RuleExecutionLogTableAnnotationComposer,
      $$RuleExecutionLogTableCreateCompanionBuilder,
      $$RuleExecutionLogTableUpdateCompanionBuilder,
      (RuleExecutionLogEntry, $$RuleExecutionLogTableReferences),
      RuleExecutionLogEntry,
      PrefetchHooks Function({bool ruleId, bool fileId})
    >;
typedef $$ActivityLogTableCreateCompanionBuilder =
    ActivityLogCompanion Function({
      Value<int> id,
      required String activityType,
      required String description,
      Value<String?> metadataJson,
      Value<DateTime> timestamp,
      Value<int?> relatedFileId,
      Value<int?> relatedRuleId,
    });
typedef $$ActivityLogTableUpdateCompanionBuilder =
    ActivityLogCompanion Function({
      Value<int> id,
      Value<String> activityType,
      Value<String> description,
      Value<String?> metadataJson,
      Value<DateTime> timestamp,
      Value<int?> relatedFileId,
      Value<int?> relatedRuleId,
    });

final class $$ActivityLogTableReferences
    extends
        BaseReferences<_$FiloDatabase, $ActivityLogTable, ActivityLogEntry> {
  $$ActivityLogTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FilesIndexTable _relatedFileIdTable(_$FiloDatabase db) =>
      db.filesIndex.createAlias(
        $_aliasNameGenerator(db.activityLog.relatedFileId, db.filesIndex.id),
      );

  $$FilesIndexTableProcessedTableManager? get relatedFileId {
    final $_column = $_itemColumn<int>('related_file_id');
    if ($_column == null) return null;
    final manager = $$FilesIndexTableTableManager(
      $_db,
      $_db.filesIndex,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_relatedFileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RulesTable _relatedRuleIdTable(_$FiloDatabase db) =>
      db.rules.createAlias(
        $_aliasNameGenerator(db.activityLog.relatedRuleId, db.rules.id),
      );

  $$RulesTableProcessedTableManager? get relatedRuleId {
    final $_column = $_itemColumn<int>('related_rule_id');
    if ($_column == null) return null;
    final manager = $$RulesTableTableManager(
      $_db,
      $_db.rules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_relatedRuleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ActivityLogTableFilterComposer
    extends Composer<_$FiloDatabase, $ActivityLogTable> {
  $$ActivityLogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  $$FilesIndexTableFilterComposer get relatedFileId {
    final $$FilesIndexTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedFileId,
      referencedTable: $db.filesIndex,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesIndexTableFilterComposer(
            $db: $db,
            $table: $db.filesIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RulesTableFilterComposer get relatedRuleId {
    final $$RulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedRuleId,
      referencedTable: $db.rules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RulesTableFilterComposer(
            $db: $db,
            $table: $db.rules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivityLogTableOrderingComposer
    extends Composer<_$FiloDatabase, $ActivityLogTable> {
  $$ActivityLogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  $$FilesIndexTableOrderingComposer get relatedFileId {
    final $$FilesIndexTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedFileId,
      referencedTable: $db.filesIndex,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesIndexTableOrderingComposer(
            $db: $db,
            $table: $db.filesIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RulesTableOrderingComposer get relatedRuleId {
    final $$RulesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedRuleId,
      referencedTable: $db.rules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RulesTableOrderingComposer(
            $db: $db,
            $table: $db.rules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivityLogTableAnnotationComposer
    extends Composer<_$FiloDatabase, $ActivityLogTable> {
  $$ActivityLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  $$FilesIndexTableAnnotationComposer get relatedFileId {
    final $$FilesIndexTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedFileId,
      referencedTable: $db.filesIndex,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FilesIndexTableAnnotationComposer(
            $db: $db,
            $table: $db.filesIndex,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RulesTableAnnotationComposer get relatedRuleId {
    final $$RulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedRuleId,
      referencedTable: $db.rules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RulesTableAnnotationComposer(
            $db: $db,
            $table: $db.rules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivityLogTableTableManager
    extends
        RootTableManager<
          _$FiloDatabase,
          $ActivityLogTable,
          ActivityLogEntry,
          $$ActivityLogTableFilterComposer,
          $$ActivityLogTableOrderingComposer,
          $$ActivityLogTableAnnotationComposer,
          $$ActivityLogTableCreateCompanionBuilder,
          $$ActivityLogTableUpdateCompanionBuilder,
          (ActivityLogEntry, $$ActivityLogTableReferences),
          ActivityLogEntry,
          PrefetchHooks Function({bool relatedFileId, bool relatedRuleId})
        > {
  $$ActivityLogTableTableManager(_$FiloDatabase db, $ActivityLogTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> activityType = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> metadataJson = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int?> relatedFileId = const Value.absent(),
                Value<int?> relatedRuleId = const Value.absent(),
              }) => ActivityLogCompanion(
                id: id,
                activityType: activityType,
                description: description,
                metadataJson: metadataJson,
                timestamp: timestamp,
                relatedFileId: relatedFileId,
                relatedRuleId: relatedRuleId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String activityType,
                required String description,
                Value<String?> metadataJson = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int?> relatedFileId = const Value.absent(),
                Value<int?> relatedRuleId = const Value.absent(),
              }) => ActivityLogCompanion.insert(
                id: id,
                activityType: activityType,
                description: description,
                metadataJson: metadataJson,
                timestamp: timestamp,
                relatedFileId: relatedFileId,
                relatedRuleId: relatedRuleId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ActivityLogTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({relatedFileId = false, relatedRuleId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (relatedFileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.relatedFileId,
                                    referencedTable:
                                        $$ActivityLogTableReferences
                                            ._relatedFileIdTable(db),
                                    referencedColumn:
                                        $$ActivityLogTableReferences
                                            ._relatedFileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (relatedRuleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.relatedRuleId,
                                    referencedTable:
                                        $$ActivityLogTableReferences
                                            ._relatedRuleIdTable(db),
                                    referencedColumn:
                                        $$ActivityLogTableReferences
                                            ._relatedRuleIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$ActivityLogTableProcessedTableManager =
    ProcessedTableManager<
      _$FiloDatabase,
      $ActivityLogTable,
      ActivityLogEntry,
      $$ActivityLogTableFilterComposer,
      $$ActivityLogTableOrderingComposer,
      $$ActivityLogTableAnnotationComposer,
      $$ActivityLogTableCreateCompanionBuilder,
      $$ActivityLogTableUpdateCompanionBuilder,
      (ActivityLogEntry, $$ActivityLogTableReferences),
      ActivityLogEntry,
      PrefetchHooks Function({bool relatedFileId, bool relatedRuleId})
    >;
typedef $$FilesFtsTableCreateCompanionBuilder =
    FilesFtsCompanion Function({
      required int fileId,
      required String content,
      required String fileName,
      Value<int> rowid,
    });
typedef $$FilesFtsTableUpdateCompanionBuilder =
    FilesFtsCompanion Function({
      Value<int> fileId,
      Value<String> content,
      Value<String> fileName,
      Value<int> rowid,
    });

class $$FilesFtsTableFilterComposer
    extends Composer<_$FiloDatabase, $FilesFtsTable> {
  $$FilesFtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get fileId => $composableBuilder(
    column: $table.fileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FilesFtsTableOrderingComposer
    extends Composer<_$FiloDatabase, $FilesFtsTable> {
  $$FilesFtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get fileId => $composableBuilder(
    column: $table.fileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FilesFtsTableAnnotationComposer
    extends Composer<_$FiloDatabase, $FilesFtsTable> {
  $$FilesFtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get fileId =>
      $composableBuilder(column: $table.fileId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);
}

class $$FilesFtsTableTableManager
    extends
        RootTableManager<
          _$FiloDatabase,
          $FilesFtsTable,
          FilesFtsEntry,
          $$FilesFtsTableFilterComposer,
          $$FilesFtsTableOrderingComposer,
          $$FilesFtsTableAnnotationComposer,
          $$FilesFtsTableCreateCompanionBuilder,
          $$FilesFtsTableUpdateCompanionBuilder,
          (
            FilesFtsEntry,
            BaseReferences<_$FiloDatabase, $FilesFtsTable, FilesFtsEntry>,
          ),
          FilesFtsEntry,
          PrefetchHooks Function()
        > {
  $$FilesFtsTableTableManager(_$FiloDatabase db, $FilesFtsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FilesFtsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FilesFtsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FilesFtsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> fileId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FilesFtsCompanion(
                fileId: fileId,
                content: content,
                fileName: fileName,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int fileId,
                required String content,
                required String fileName,
                Value<int> rowid = const Value.absent(),
              }) => FilesFtsCompanion.insert(
                fileId: fileId,
                content: content,
                fileName: fileName,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FilesFtsTableProcessedTableManager =
    ProcessedTableManager<
      _$FiloDatabase,
      $FilesFtsTable,
      FilesFtsEntry,
      $$FilesFtsTableFilterComposer,
      $$FilesFtsTableOrderingComposer,
      $$FilesFtsTableAnnotationComposer,
      $$FilesFtsTableCreateCompanionBuilder,
      $$FilesFtsTableUpdateCompanionBuilder,
      (
        FilesFtsEntry,
        BaseReferences<_$FiloDatabase, $FilesFtsTable, FilesFtsEntry>,
      ),
      FilesFtsEntry,
      PrefetchHooks Function()
    >;

class $FiloDatabaseManager {
  final _$FiloDatabase _db;
  $FiloDatabaseManager(this._db);
  $$FilesIndexTableTableManager get filesIndex =>
      $$FilesIndexTableTableManager(_db, _db.filesIndex);
  $$ExtractedTextTableTableManager get extractedText =>
      $$ExtractedTextTableTableManager(_db, _db.extractedText);
  $$ImageLabelsTableTableManager get imageLabels =>
      $$ImageLabelsTableTableManager(_db, _db.imageLabels);
  $$EmbeddingsTableTableManager get embeddings =>
      $$EmbeddingsTableTableManager(_db, _db.embeddings);
  $$RulesTableTableManager get rules =>
      $$RulesTableTableManager(_db, _db.rules);
  $$RuleExecutionLogTableTableManager get ruleExecutionLog =>
      $$RuleExecutionLogTableTableManager(_db, _db.ruleExecutionLog);
  $$ActivityLogTableTableManager get activityLog =>
      $$ActivityLogTableTableManager(_db, _db.activityLog);
  $$FilesFtsTableTableManager get filesFts =>
      $$FilesFtsTableTableManager(_db, _db.filesFts);
}
