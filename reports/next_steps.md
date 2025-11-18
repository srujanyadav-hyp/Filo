# FILO v0 — NEXT STEPS & EXECUTION PLAN

**Generated:** 2025-11-18  
**Agent Mode:** Evidence-Based Action Planning  
**Status:** Awaiting Human Approval to Proceed

---

## OVERVIEW

This document provides the exact sequence of branches, commits, and commands required to transform the current repository (0% FILO implementation) into a buildable FILO v0 application per specifications.

---

## PHASE 1: FOUNDATION (CRITICAL BLOCKERS)

**Estimated Time:** 4-6 hours  
**Must Complete Before:** Any feature development

---

### STEP 1.1: Initialize Git Repository

**Branch Name:** `init/git-repository-20251118`  
**Issue:** No git repository exists (fatal blocker)  
**Evidence:** `git status` → `fatal: not a git repository`

**Commands to Execute:**
```powershell
# Initialize git repository
cd C:\Users\SRUJAN\Desktop\realworld\filo
git init

# Add all existing files
git add .

# Initial commit
git commit -m "chore: initial commit - Flutter template with FILO specs

- Fresh Flutter 3.27.2 project template
- 31 specification files in FILO_app_deatils/
- Build logs and reports from initial audit
- Zero FILO implementation (baseline)

Refs: spec/master_spec_ultra.md"

# Rename default branch to main
git branch -m main
```

**Verification Steps:**
1. Run `git status` → should show "On branch main, nothing to commit, working tree clean"
2. Run `git log` → should show initial commit
3. Create `.gitignore` if not exists with standard Flutter entries

**Expected Output Files:**
- `.git/` directory created
- Git repository functional

**Next Action:** Proceed to Step 1.2 only after git repository verified

---

### STEP 1.2: Add Core Dependencies

**Branch Name:** `deps/add-core-dependencies-audit-20251118`  
**Issue:** Missing all critical dependencies (Drift, Riverpod, freezed, etc.)  
**Evidence:** `pubspec.yaml` contains only `cupertino_icons`

**Commands to Execute:**
```powershell
# Create feature branch
git checkout -b deps/add-core-dependencies-audit-20251118

# Edit pubspec.yaml (manual step or use script)
# See "pubspec.yaml Changes" section below

# Fetch dependencies
flutter pub get

# Verify no conflicts
flutter pub outdated

# Stage changes
git add pubspec.yaml pubspec.lock

# Commit
git commit -m "deps: add core dependencies for FILO v0

Added dependencies:
- drift ^2.20.0 + drift_dev + build_runner + sqlite3_flutter_libs
- flutter_riverpod ^2.6.0 + riverpod_annotation + riverpod_generator
- freezed ^2.5.0 + freezed_annotation + json_annotation + json_serializable
- go_router ^13.0.0
- path_provider ^2.1.0
- mime ^1.0.0

Dev dependencies:
- mocktail ^1.0.0
- golden_toolkit ^0.15.0

Refs: spec/database_schema_ultra.md spec/architecture_diagram_ultra.md spec/testing_and_ci_ultra_ultra.md"

# Push branch
git push -u origin deps/add-core-dependencies-audit-20251118
```

**pubspec.yaml Changes:**
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  
  # State Management
  flutter_riverpod: ^2.6.0
  riverpod_annotation: ^2.6.0
  
  # Database
  drift: ^2.20.0
  sqlite3_flutter_libs: ^0.5.24
  path_provider: ^2.1.0
  path: ^1.9.0
  
  # Serialization
  freezed_annotation: ^2.5.0
  json_annotation: ^4.9.0
  
  # Navigation
  go_router: ^13.0.0
  
  # File handling
  mime: ^1.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  
  # Code generation
  build_runner: ^2.4.0
  drift_dev: ^2.20.0
  riverpod_generator: ^2.6.0
  freezed: ^2.5.0
  json_serializable: ^6.9.0
  
  # Testing
  mocktail: ^1.0.0
  golden_toolkit: ^0.15.0
  integration_test:
    sdk: flutter
```

**Verification Steps:**
1. `flutter pub get` → succeeds without errors
2. `flutter analyze` → no new errors introduced
3. `flutter test` → existing test still passes

**Expected Output Files:**
- `pubspec.yaml` updated
- `pubspec.lock` updated with all dependencies
- Dependencies cached in `.pub-cache`

**Create PR:** Yes, title: `[DEPS] Add core dependencies for FILO v0`  
**Next Action:** Merge PR after review, then proceed to Step 1.3

---

### STEP 1.3: Create Folder Structure

**Branch Name:** `structure/scaffold-project-audit-20251118`  
**Issue:** Missing 100% of spec-required folder structure  
**Evidence:** `/lib` contains only `main.dart`

**Commands to Execute:**
```powershell
# Create feature branch
git checkout main
git pull
git checkout -b structure/scaffold-project-audit-20251118

# Create all required directories
mkdir -p lib/core/errors
mkdir -p lib/core/utils
mkdir -p lib/core/logging
mkdir -p lib/core/constants
mkdir -p lib/core/platform

mkdir -p lib/features/indexing/domain
mkdir -p lib/features/indexing/data
mkdir -p lib/features/indexing/presentation

mkdir -p lib/features/rules/domain
mkdir -p lib/features/rules/data
mkdir -p lib/features/rules/presentation

mkdir -p lib/features/search/domain
mkdir -p lib/features/search/data
mkdir -p lib/features/search/presentation

mkdir -p lib/features/files/domain
mkdir -p lib/features/files/data
mkdir -p lib/features/files/presentation

mkdir -p lib/features/settings/domain
mkdir -p lib/features/settings/data
mkdir -p lib/features/settings/presentation

mkdir -p lib/features/activity_log/domain
mkdir -p lib/features/activity_log/data
mkdir -p lib/features/activity_log/presentation

mkdir -p lib/data/db/tables
mkdir -p lib/data/db/daos
mkdir -p lib/data/models
mkdir -p lib/data/repository

mkdir -p lib/presentation/widgets
mkdir -p lib/presentation/screens
mkdir -p lib/presentation/theme

mkdir -p test/unit
mkdir -p test/widget
mkdir -p test/integration
mkdir -p test/data

mkdir -p android/app/src/main/kotlin/com/filo/plugins

# Create placeholder README.md files explaining each directory
# (scripted or manual step)

# Stage all new directories (with .gitkeep files)
git add .

# Commit
git commit -m "structure: create FILO v0 folder structure

Created directory structure per spec:
- /lib/core (errors, utils, logging, constants, platform)
- /lib/features (indexing, rules, search, files, settings, activity_log)
- /lib/data (db, models, repository)
- /lib/presentation (widgets, screens, theme)
- /test (unit, widget, integration, data)
- /android/app/src/main/kotlin/com/filo/plugins

Each directory contains README.md documenting its purpose.

Refs: spec/folder_structure_ultra_ultra.md spec/architecture_diagram_ultra.md"

# Push branch
git push -u origin structure/scaffold-project-audit-20251118
```

**Helper Script (create_structure.ps1):**
```powershell
# Create directory with .gitkeep and README.md
function New-ProjectDir {
    param($Path, $Description)
    New-Item -ItemType Directory -Force -Path $Path | Out-Null
    Set-Content -Path "$Path/.gitkeep" -Value ""
    Set-Content -Path "$Path/README.md" -Value "# $Path`n`n$Description"
}

# Execute for all directories
# (full script omitted for brevity)
```

**Verification Steps:**
1. Verify all directories exist: `Get-ChildItem -Recurse -Directory lib/`
2. `flutter analyze` → no errors (empty directories are fine)
3. `git status` → shows all new directories staged

**Expected Output:**
- Complete folder structure matching spec/folder_structure_ultra_ultra.md
- Placeholder README.md in each directory

**Create PR:** Yes, title: `[STRUCTURE] Create FILO v0 folder structure`  
**Next Action:** Merge PR, then proceed to Step 1.4

---

### STEP 1.4: Setup State Management (Riverpod)

**Branch Name:** `core/state-management-audit-20251118`  
**Issue:** No Riverpod setup, app uses default setState  
**Evidence:** No ProviderScope in main.dart

**Commands to Execute:**
```powershell
git checkout main
git pull
git checkout -b core/state-management-audit-20251118

# Modify main.dart to add ProviderScope
# See "main.dart Changes" section below

# Create provider observer for debugging
# Create lib/core/providers/provider_observer.dart

# Verify app runs
flutter run --debug

# Commit changes
git add .
git commit -m "core: initialize Riverpod state management

Changes:
- Wrapped app with ProviderScope
- Created FiloProviderObserver for debugging
- Set up provider directory structure

Refs: spec/architecture_diagram_ultra.md spec/coding_standards_ultra_ultra.md"

git push -u origin core/state-management-audit-20251118
```

**main.dart Changes:**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filo/core/providers/provider_observer.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [FiloProviderObserver()],
      child: const MyApp(),
    ),
  );
}

// Rest of MyApp class remains unchanged for now
```

**lib/core/providers/provider_observer.dart:**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filo/core/logging/logger.dart';

class FiloProviderObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // TODO: Replace with proper logger when implemented
    print('[Provider] ${provider.name ?? provider.runtimeType} updated');
  }

  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    // TODO: Replace with proper error handling
    print('[Provider ERROR] ${provider.name ?? provider.runtimeType}: $error');
  }
}
```

**Verification Steps:**
1. `flutter run` → app launches successfully
2. Hot reload works
3. No errors in console

**Create PR:** Yes, title: `[CORE] Setup Riverpod state management`  
**Next Action:** Merge PR, then proceed to Phase 2

---

## PHASE 2: DATA LAYER (HIGH PRIORITY)

**Estimated Time:** 12-16 hours  
**Dependencies:** Phase 1 complete

---

### STEP 2.1: Implement Drift Database Schema

**Branch Name:** `data/database-schema-audit-20251118`  
**Issue:** No database, 0/8 tables implemented  
**Evidence:** No Drift code exists

**Commands to Execute:**
```powershell
git checkout main
git pull
git checkout -b data/database-schema-audit-20251118

# Create database.dart with all 8 tables
# Create individual table definition files
# Create DAOs for each table
# See detailed implementation below

# Generate Drift code
flutter pub run build_runner build --delete-conflicting-outputs

# Write unit tests for database
# Create test/data/database_test.dart

# Run tests
flutter test

# Commit
git add .
git commit -m "data: implement Drift database schema with 8 tables

Tables implemented:
1. files_index (primary file metadata)
2. extracted_text (OCR results)
3. image_labels (ML-generated labels)
4. embeddings (vector embeddings for semantic search)
5. rules (automation rules)
6. rule_execution_log (audit trail)
7. activity_log (user-facing history)
8. FTS5 virtual table for full-text search

DAOs implemented for all tables.
Tests: 25 unit tests, 95% coverage achieved.

Refs: spec/database_schema_ultra.md"

git push -u origin data/database-schema-audit-20251118
```

**Key Implementation Files:**

**lib/data/db/database.dart:**
```dart
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    FilesIndex,
    ExtractedText,
    ImageLabels,
    Embeddings,
    Rules,
    RuleExecutionLog,
    ActivityLog,
  ],
  daos: [
    FilesDao,
    SearchDao,
    RulesDao,
    ActivityLogDao,
  ],
)
class FiloDatabase extends _$FiloDatabase {
  FiloDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      // Create FTS5 table manually
      await customStatement('''
        CREATE VIRTUAL TABLE files_fts USING fts5(
          file_id, 
          normalized_name, 
          extracted_text,
          content=files_index
        )
      ''');
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'filo.db'));
    return NativeDatabase(file);
  });
}
```

**lib/data/db/tables/files_index_table.dart:**
```dart
import 'package:drift/drift.dart';

@DataClassName('FileIndexEntry')
class FilesIndex extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uri => text().unique()();
  TextColumn get normalizedName => text()();
  TextColumn get mime => text()();
  IntColumn get size => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get modifiedAt => dateTime()();
  TextColumn get parentUri => text().nullable()();
  TextColumn get checksum => text()();
}
```

**(Continue with similar table definitions for all 8 tables)**

**Verification Steps:**
1. `flutter pub run build_runner build` → succeeds, generates .g.dart files
2. `flutter analyze` → no errors
3. `flutter test test/data/` → all database tests pass
4. Coverage report shows 95%+ for DAO code

**Create PR:** Yes, title: `[DATA] Implement Drift database schema with 8 tables`  
**Next Action:** Merge PR after review, then proceed to Step 2.2

---

### STEP 2.2: Create Data Models with Freezed

**Branch Name:** `data/models-freezed-audit-20251118`  
**Issue:** No immutable domain models  
**Evidence:** No model classes exist

**Commands to Execute:**
```powershell
git checkout main
git pull
git checkout -b data/models-freezed-audit-20251118

# Create freezed models for all domain entities
# See implementation section below

# Generate freezed code
flutter pub run build_runner build --delete-conflicting-outputs

# Write unit tests for models
flutter test

# Commit
git add .
git commit -m "data: create freezed domain models

Models created:
- FileMetadata
- Rule (with Condition, Action submodels)
- SearchResult
- ActivityLogEntry

All models are immutable with copyWith, equality, toString.
JSON serialization configured.

Refs: spec/coding_standards_ultra_ultra.md spec/feature_specs_ultra.md"

git push -u origin data/models-freezed-audit-20251118
```

**Example Model (lib/data/models/rule.dart):**
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rule.freezed.dart';
part 'rule.g.dart';

@freezed
class Rule with _$Rule {
  const factory Rule({
    required String id,
    required String name,
    required Trigger trigger,
    required List<Condition> conditions,
    required List<Action> actions,
    required RuleMetadata metadata,
  }) = _Rule;

  factory Rule.fromJson(Map<String, dynamic> json) => _$RuleFromJson(json);
}

// Continue with Trigger, Condition, Action, RuleMetadata...
```

**Create PR:** Yes  
**Next Action:** Merge PR, then proceed to Phase 3

---

## PHASE 3: NATIVE PLUGINS (HIGH PRIORITY)

**Estimated Time:** 24-32 hours  
**Dependencies:** Phase 1 complete

---

### STEP 3.1: Implement SAF Plugin (FiloSafPlugin.kt)

**Branch Name:** `native/saf-plugin-audit-20251118`  
**Issue:** No SAF plugin, cannot access Android Storage Access Framework  
**Evidence:** No Kotlin plugins exist

**Commands to Execute:**
```powershell
git checkout main
git pull
git checkout -b native/saf-plugin-audit-20251118

# Create FiloSafPlugin.kt
# Create Flutter platform channel
# Implement all SAF operations per spec
# Write Android instrumentation tests
# See implementation below

# Test on Android device/emulator
flutter run

# Commit
git add .
git commit -m "native: implement SAF plugin for file access

Implemented:
- SAF folder picker with persistable permissions
- Document tree traversal
- Safe file move operations
- Filename conflict resolution
- Platform channel integration with Flutter

Android tests: 18 instrumentation tests, 85% coverage

Refs: spec/native_plugin_spec_ultra.md"

git push -u origin native/saf-plugin-audit-20251118
```

**Implementation:**

**android/app/src/main/kotlin/com/filo/plugins/FiloSafPlugin.kt:**
```kotlin
package com.filo.plugins

import android.app.Activity
import android.content.Intent
import android.net.Uri
import androidx.documentfile.provider.DocumentFile
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class FiloSafPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener {

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private val REQUEST_CODE_PICK_FOLDER = 1001

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "com.filo/saf")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "pickFolder" -> pickFolder(result)
            "persistPermission" -> persistPermission(call, result)
            "listDocuments" -> listDocuments(call, result)
            "moveDocument" -> moveDocument(call, result)
            else -> result.notImplemented()
        }
    }

    private fun pickFolder(result: MethodChannel.Result) {
        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE).apply {
            flags = Intent.FLAG_GRANT_READ_URI_PERMISSION or
                    Intent.FLAG_GRANT_WRITE_URI_PERMISSION or
                    Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION
        }
        activity?.startActivityForResult(intent, REQUEST_CODE_PICK_FOLDER)
        // Store result for later callback
    }

    // Continue with other methods...

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    // ActivityAware implementation...
}
```

**lib/core/platform/saf_channel.dart:**
```dart
import 'package:flutter/services.dart';

class SafChannel {
  static const MethodChannel _channel = MethodChannel('com.filo/saf');

  Future<String?> pickFolder() async {
    try {
      final String? uri = await _channel.invokeMethod('pickFolder');
      return uri;
    } on PlatformException catch (e) {
      print('Failed to pick folder: ${e.message}');
      return null;
    }
  }

  Future<bool> persistPermission(String uri) async {
    try {
      final bool success = await _channel.invokeMethod('persistPermission', {'uri': uri});
      return success;
    } on PlatformException catch (e) {
      print('Failed to persist permission: ${e.message}');
      return false;
    }
  }

  // Continue with other methods...
}
```

**Create PR:** Yes, title: `[NATIVE] Implement SAF plugin`  
**Next Action:** Merge PR, test on real Android device, proceed to Step 3.2

---

### STEP 3.2: Implement OCR Plugin (FiloOcrPlugin.kt)

**Branch Name:** `native/ocr-plugin-audit-20251118`  
**Similar structure to Step 3.1, implementing MLKit TextRecognizer**

---

### STEP 3.3: Implement Image Labeling Plugin

**Branch Name:** `native/labeler-plugin-audit-20251118`  
**Similar structure, implementing MLKit ImageLabeling**

---

### STEP 3.4: Implement Background Worker Plugin

**Branch Name:** `native/worker-plugin-audit-20251118`  
**Implementing WorkManager for background indexing**

---

## PHASE 4: CORE FEATURES (HIGH PRIORITY)

**Estimated Time:** 48-64 hours  
**Dependencies:** Phase 2, Phase 3 complete

---

### STEP 4.1: File Indexing Engine

**Branch Name:** `feature/indexing-engine-audit-20251118`  
**Estimated Time:** 24 hours

**Key Tasks:**
1. Create IndexingService orchestrating 8-step pipeline
2. Integrate SAF plugin for file access
3. Integrate OCR plugin for text extraction
4. Integrate image labeling plugin
5. Create embedding generation service
6. Implement FTS5 indexing
7. Add background worker for incremental indexing
8. Write 80+ unit tests

---

### STEP 4.2: Search Implementation

**Branch Name:** `feature/search-hybrid-audit-20251118`  
**Estimated Time:** 20 hours

**Key Tasks:**
1. Implement keyword search with FTS5 + BM25
2. Implement semantic search with embeddings + cosine similarity
3. Create hybrid ranker (0.55 keyword + 0.35 semantic + 0.10 recency)
4. Add search result caching
5. Implement index warming
6. Write 60+ unit tests including performance tests

---

### STEP 4.3: Rule Engine

**Branch Name:** `feature/rule-engine-audit-20251118`  
**Estimated Time:** 32 hours

**Key Tasks:**
1. Implement condition evaluation engine (9 condition types)
2. Implement action executor with atomicity
3. Create safety analyzer (3-level classification)
4. Build rule preview simulator
5. Integrate AI service for natural language → rule JSON
6. Add rule execution logging
7. Write 120+ unit tests targeting 100% branch coverage

---

## PHASE 5: UI IMPLEMENTATION (MEDIUM PRIORITY)

**Estimated Time:** 32-40 hours  
**Dependencies:** Phase 4 complete

---

### STEP 5.1: Design System

**Branch Name:** `ui/design-system-audit-20251118`  
**Estimated Time:** 8 hours

**Key Tasks:**
1. Create color token system (app_colors.dart)
2. Create typography scale (app_typography.dart)
3. Create spacing constants (app_spacing.dart)
4. Create elevation presets (app_elevation.dart)
5. Build complete ThemeData (app_theme.dart)
6. Replace default theme in main.dart

---

### STEP 5.2: Widget Library

**Branch Name:** `ui/widgets-library-audit-20251118`  
**Estimated Time:** 12 hours

**Key Tasks:**
1. Implement search bar widget with animations
2. Implement file card widget with press animations
3. Implement FAB with expansion
4. Create error banners, loading indicators, empty states
5. Write widget tests for all components

---

### STEP 5.3: Screen Implementation (All 8 Screens)

**Branch Name:** `ui/screens-all-audit-20251118`  
**Estimated Time:** 20 hours

**Key Tasks:**
1. Implement all 8 screens per pixel-perfect specs
2. Add navigation with go_router
3. Implement animations per spec
4. Write widget tests and golden tests for all screens

---

## PHASE 6: TESTING & CI/CD (LOWER PRIORITY)

**Estimated Time:** 24-32 hours  
**Dependencies:** Phase 4, Phase 5 complete

---

### STEP 6.1: Comprehensive Test Suite

**Branch Name:** `test/comprehensive-test-suite-audit-20251118`  
**Estimated Time:** 40 hours (ongoing with feature development)

**Key Tasks:**
1. Achieve coverage targets: Rule engine 100%, DAOs 95%, Plugins 80%
2. Write integration tests for all workflows
3. Set up coverage reporting

---

### STEP 6.2: CI/CD Pipeline

**Branch Name:** `ci/github-actions-pipeline-audit-20251118`  
**Estimated Time:** 8 hours

**Key Tasks:**
1. Create .github/workflows/ci.yml
2. Configure pipeline stages per spec
3. Add performance guards (build <15min, tests <6min)
4. Test pipeline on feature branch

---

## PHASE 7: BUILD & RELEASE CONFIG (LOWER PRIORITY)

**Estimated Time:** 6-8 hours  
**Dependencies:** All previous phases complete

---

### STEP 7.1: Release Configuration

**Branch Name:** `build/release-configuration-audit-20251118`

**Key Tasks:**
1. Generate release keystore (secure storage)
2. Configure build.gradle.kts for signing, ABI splits
3. Set up ProGuard rules
4. Create versioning automation
5. Document signing process

---

## OVERALL TIMELINE ESTIMATE

| Phase | Description | Hours | Cumulative |
|-------|-------------|-------|------------|
| 1 | Foundation (Git, Deps, Structure, Riverpod) | 4-6 | 6 |
| 2 | Data Layer (DB, Models) | 12-16 | 22 |
| 3 | Native Plugins (SAF, OCR, Labeler, Worker) | 24-32 | 54 |
| 4 | Core Features (Indexing, Search, Rules) | 48-64 | 118 |
| 5 | UI (Design System, Widgets, Screens) | 32-40 | 158 |
| 6 | Testing & CI/CD | 24-32 | 190 |
| 7 | Build & Release Config | 6-8 | 198 |

**Total Estimated Time:** 180-240 hours (~4.5-6 weeks full-time development)

---

## CRITICAL PATH

The following steps MUST be completed in sequence before parallel development can begin:

1. Initialize Git Repository → 10 minutes
2. Add Core Dependencies → 30 minutes
3. Create Folder Structure → 1 hour
4. Setup Riverpod → 2 hours
5. Implement Database Schema → 8 hours
6. Implement SAF Plugin → 16 hours

**Critical Path Total:** ~28 hours before features can be developed in parallel

---

## RISK FACTORS

1. **Embedding Model Selection:** Requires research and decision (on-device vs API)
2. **AI Integration:** Optional backend may need architecture decision
3. **Performance Tuning:** Search and indexing performance may require optimization iterations
4. **Native Plugin Testing:** Requires physical Android devices for real-world testing
5. **Spec Ambiguities:** Some details may require clarification during implementation

---

## FINAL RECOMMENDATION

**STOP and await human approval before proceeding.**

**Questions for Human:**
1. Approve the priority order and timeline?
2. Which optional features to include in v0 (AI backend, embeddings)?
3. Confirm embedding model choice (on-device TFLite vs API)?
4. Approve branch naming convention?
5. Should agent proceed automatically with Phase 1 or wait for per-step approval?

**Agent is ready to execute Phase 1 Step 1.1 (Git Init) upon approval.**
