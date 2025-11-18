// Database Provider - Riverpod provider for FiloDatabase
// Refs: architecture_diagram_ultra.md

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/db/database.dart';

/// Global database provider
final databaseProvider = Provider<FiloDatabase>((ref) {
  final database = FiloDatabase();
  ref.onDispose(() => database.close());
  return database;
});
