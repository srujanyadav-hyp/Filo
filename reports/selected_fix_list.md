# FILO — SELECTED FIX LIST (TOP 5 PRIORITY)

**Generated:** 2025-11-18  
**Phase:** 2 Implementation  
**Mode:** Evidence-Based, Deterministic Execution  
**Source:** `/reports/initial_gap_analysis.md` Priority List

---

## SELECTION CRITERIA

Selected the top 5 fixes that are:
1. ✅ Fully unambiguous (exact spec requirements)
2. ✅ Do NOT require architectural decisions
3. ✅ Safe to implement (no destructive operations)
4. ✅ Have clear evidence and validation criteria
5. ✅ Are critical blockers for all subsequent work

---

## FIX 1: INITIALIZE GIT REPOSITORY

**Priority:** 1 (CRITICAL BLOCKER)  
**Status:** NOT STARTED  
**Severity:** FATAL - Blocks all PR-based workflow

### Spec Reference
- **File:** Workflow requirement (implicit in all specs requiring PR-based development)
- **Lines:** N/A (fundamental requirement)
- **Evidence from repo_health.md (lines 15-30):**
```
## GIT STATUS

**CRITICAL BLOCKER DETECTED:**

```
fatal: not a git repository (or any of the parent directories): .git
```

**Evidence:** Command `git status` executed in `C:\Users\SRUJAN\Desktop\realworld\filo` returned fatal error.

**Impact:** 
- Cannot track changes
- Cannot create branches for fixes
- Cannot create pull requests
- Version control completely absent
```

### Code Path Affected
- **Path:** `C:\Users\SRUJAN\Desktop\realworld\filo/.git/` (does not exist)
- **Current State:** No `.git` directory
- **Required State:** Initialized git repository with initial commit

### Exact Implementation Steps
1. Execute: `git init`
2. Create `.gitignore` with Flutter standard entries
3. Execute: `git add .`
4. Execute: `git commit -m "chore: initial commit - Flutter template with FILO specs"`
5. Execute: `git branch -m main`
6. Verify: `git status` shows clean working tree

### Branch Name
`init/git-repository-20251118-1430`

### Acceptance Criteria
- [ ] `.git/` directory exists
- [ ] `git status` returns success (not fatal error)
- [ ] Initial commit exists with all current files
- [ ] Branch is named `main`
- [ ] `.gitignore` file contains standard Flutter entries

### Estimated Effort
10 minutes

---

## FIX 2: ADD CORE DEPENDENCIES

**Priority:** 2 (CRITICAL BLOCKER)  
**Status:** NOT STARTED  
**Severity:** CRITICAL - Required for all FILO features

### Spec Reference
- **File:** `database_schema_ultra.md`, `architecture_diagram_ultra.md`, `coding_standards_ultra_ultra.md`
- **Lines:** 
  - database_schema_ultra.md: Full file (requires Drift)
  - architecture_diagram_ultra.md: Line 8 "Presentation (Flutter Widgets + Riverpod)"
  - coding_standards_ultra_ultra.md: Line 32 "Use Riverpod for state management"

**Evidence from database_schema_ultra.md:**
```markdown
## 1. SCHEMA PHILOSOPHY
The database schema is optimized for:
- fast FTS searches,
- incremental updates,
- atomic rule execution,
```

**Evidence from architecture_diagram_ultra.md:**
```markdown
## 1. SYSTEM OVERVIEW
FILO is a hybrid Flutter + Native Android automation engine. The system is divided into 6 core layers:
1. Presentation (Flutter Widgets + Riverpod)
2. Domain (Business logic & rule engine)
3. Data Layer (Repositories, Drift DAO)
```

### Code Path Affected
- **Path:** `pubspec.yaml` lines 31-45 (dependencies section)
- **Current State:** Only contains `cupertino_icons: ^1.0.8`
- **Required State:** Must include drift, riverpod, freezed, go_router, path_provider

### Exact Dependencies to Add

**Production Dependencies:**
```yaml
  # State Management (required by architecture_diagram_ultra.md line 8)
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.6.1
  
  # Database (required by database_schema_ultra.md)
  drift: ^2.20.3
  sqlite3_flutter_libs: ^0.5.24
  path_provider: ^2.1.5
  path: ^1.9.0
  
  # Serialization (required by coding_standards_ultra_ultra.md)
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  
  # Navigation
  go_router: ^14.6.2
  
  # File handling
  mime: ^2.0.0
```

**Dev Dependencies:**
```yaml
  # Code generation
  build_runner: ^2.4.13
  drift_dev: ^2.20.3
  riverpod_generator: ^2.6.2
  freezed: ^2.5.7
  json_serializable: ^6.9.2
  
  # Testing
  mocktail: ^1.0.4
  integration_test:
    sdk: flutter
```

### Branch Name
`deps/add-core-dependencies-audit-20251118-1430`

### Acceptance Criteria
- [ ] `pubspec.yaml` contains all required dependencies
- [ ] `flutter pub get` succeeds without errors
- [ ] `flutter analyze` shows no new errors
- [ ] `flutter test` still passes (1 existing test)
- [ ] `pubspec.lock` updated with all dependencies

### Estimated Effort
30 minutes

---

## FIX 3: CREATE FOLDER STRUCTURE

**Priority:** 3 (CRITICAL BLOCKER)  
**Status:** NOT STARTED  
**Severity:** CRITICAL - Required for all subsequent code organization

### Spec Reference
- **File:** `folder_structure_ultra_ultra.md`
- **Lines:** 12-38 (LIB STRUCTURE IN DETAIL)

**Evidence from spec (lines 12-38):**
```markdown
# 2. LIB STRUCTURE IN DETAIL

```
/lib
   /core
      /errors
      /utils
      /logging
      /constants

   /features
      /indexing
      /rules
      /search
      /files
      /settings
      /activity_log

   /data
      /db
      /models
      /repository

   /presentation
      /widgets
      /screens
      /theme
```
```

**Evidence from spec (lines 44-52):**
```markdown
# 3. PLUGIN & NATIVE

```
/android/app/src/main/kotlin/com/filo
   /plugins
      FiloSafPlugin.kt
      FiloOcrPlugin.kt
      FiloImageLabeler.kt
      FiloWorker.kt
```
```

**Evidence from spec (lines 58-64):**
```markdown
# 4. TESTS

```
/test
   /unit
   /widget
   /integration
   /data
```
```

### Code Path Affected
- **Path:** `lib/` directory (currently contains only `main.dart`)
- **Path:** `test/` directory (currently contains only `widget_test.dart`)
- **Path:** `android/app/src/main/kotlin/com/filo/` (does not exist)
- **Current State:** Minimal Flutter template structure
- **Required State:** Complete folder hierarchy per spec

### Exact Directories to Create

**Flutter/Dart:**
```
lib/core/errors/
lib/core/utils/
lib/core/logging/
lib/core/constants/
lib/core/platform/
lib/features/indexing/domain/
lib/features/indexing/data/
lib/features/indexing/presentation/
lib/features/rules/domain/
lib/features/rules/data/
lib/features/rules/presentation/
lib/features/search/domain/
lib/features/search/data/
lib/features/search/presentation/
lib/features/files/domain/
lib/features/files/data/
lib/features/files/presentation/
lib/features/settings/domain/
lib/features/settings/data/
lib/features/settings/presentation/
lib/features/activity_log/domain/
lib/features/activity_log/data/
lib/features/activity_log/presentation/
lib/data/db/tables/
lib/data/db/daos/
lib/data/models/
lib/data/repository/
lib/presentation/widgets/
lib/presentation/screens/
lib/presentation/theme/
test/unit/
test/widget/
test/integration/
test/data/
```

**Android/Kotlin:**
```
android/app/src/main/kotlin/com/filo/plugins/
```

### Branch Name
`structure/scaffold-project-audit-20251118-1430`

### Acceptance Criteria
- [ ] All 35 directories exist under `lib/`
- [ ] All 4 test directories exist under `test/`
- [ ] Kotlin plugin directory exists
- [ ] Each directory contains `.gitkeep` file (to track empty dirs)
- [ ] Each directory contains `README.md` documenting its purpose
- [ ] `flutter analyze` shows no errors
- [ ] Directory structure matches spec exactly

### Estimated Effort
1 hour

---

## FIX 4: IMPLEMENT DRIFT DATABASE SCHEMA

**Priority:** 4 (CRITICAL BLOCKER)  
**Status:** NOT STARTED  
**Severity:** CRITICAL - Foundation for all data operations

### Spec Reference
- **File:** `database_schema_ultra.md`
- **Lines:** 10-35 (TABLES DETAILED)

**Evidence from spec (lines 10-25):**
```markdown
## 2. TABLES (DETAILED)
### files_index
- id (PK)
- uri
- normalized_name
- mime
- size
- created_at
- modified_at
- parent_uri
- checksum
...

### extracted_text
- file_id
- text
- confidence
- ocr_engine_version
```

**Evidence from spec (lines 27-35):**
```markdown
### embeddings
- file_id
- vector (binary)
- dim
- model_version
- quantization_level
...
```

### Code Path Affected
- **Path:** `lib/data/db/database.dart` (does not exist)
- **Path:** `lib/data/db/tables/*.dart` (none exist)
- **Path:** `lib/data/db/daos/*.dart` (none exist)
- **Current State:** No database code
- **Required State:** Complete Drift database with 8 tables

### Tables to Implement

1. **files_index** - Primary file metadata
2. **extracted_text** - OCR results
3. **image_labels** - ML-generated labels
4. **embeddings** - Vector embeddings
5. **rules** - Automation rules
6. **rule_execution_log** - Audit trail
7. **activity_log** - User-facing history
8. **files_fts** - FTS5 virtual table

### Exact Implementation Required

**Files to create:**
1. `lib/data/db/database.dart` - Main Drift database class
2. `lib/data/db/tables/files_index_table.dart` - Files table definition
3. `lib/data/db/tables/extracted_text_table.dart` - OCR text table
4. `lib/data/db/tables/image_labels_table.dart` - Image labels table
5. `lib/data/db/tables/embeddings_table.dart` - Embeddings table
6. `lib/data/db/tables/rules_table.dart` - Rules table
7. `lib/data/db/tables/rule_execution_log_table.dart` - Execution log
8. `lib/data/db/tables/activity_log_table.dart` - Activity log
9. `lib/data/db/daos/files_dao.dart` - Files DAO
10. `lib/data/db/daos/search_dao.dart` - Search DAO
11. `lib/data/db/daos/rules_dao.dart` - Rules DAO
12. `lib/data/db/daos/activity_log_dao.dart` - Activity DAO
13. `test/data/database_test.dart` - Database unit tests

### Branch Name
`data/database-schema-audit-20251118-1430`

### Acceptance Criteria
- [ ] All 8 tables defined per spec
- [ ] All 4 DAOs implemented
- [ ] `flutter pub run build_runner build` succeeds
- [ ] `.g.dart` files generated
- [ ] Database migrations defined
- [ ] FTS5 virtual table created
- [ ] 25+ unit tests written
- [ ] Tests achieve 95%+ coverage on DAO code
- [ ] `flutter analyze` shows no errors
- [ ] `flutter test` passes all tests

### Estimated Effort
8 hours

---

## FIX 5: SETUP RIVERPOD STATE MANAGEMENT

**Priority:** 5 (CRITICAL BLOCKER)  
**Status:** NOT STARTED  
**Severity:** CRITICAL - Required for all feature state management

### Spec Reference
- **File:** `architecture_diagram_ultra.md`
- **Lines:** 8 "Presentation (Flutter Widgets + Riverpod)"
- **File:** `coding_standards_ultra_ultra.md`
- **Lines:** 32-38 (Flutter Standards)

**Evidence from architecture_diagram_ultra.md (line 8):**
```markdown
1. Presentation (Flutter Widgets + Riverpod)
```

**Evidence from coding_standards_ultra_ultra.md (lines 32-38):**
```markdown
# 2. FLUTTER STANDARDS

### Widgets must:
- Be pure functions when possible
- Never include side effects
- Never mutate state directly
- Use Riverpod for state management
```

### Code Path Affected
- **Path:** `lib/main.dart` lines 5-15 (main function and MyApp)
- **Path:** `lib/core/providers/provider_observer.dart` (does not exist)
- **Current State:** No ProviderScope wrapper, uses default setState
- **Required State:** App wrapped with ProviderScope, observer configured

### Exact Implementation Required

**Files to create/modify:**
1. Modify `lib/main.dart` - Wrap app with ProviderScope
2. Create `lib/core/providers/provider_observer.dart` - Custom observer
3. Create `lib/core/providers/README.md` - Document provider structure

**main.dart changes:**
- Import `flutter_riverpod`
- Wrap `MyApp` with `ProviderScope`
- Add `FiloProviderObserver` to observers

### Branch Name
`core/state-management-audit-20251118-1430`

### Acceptance Criteria
- [ ] `main.dart` imports `flutter_riverpod`
- [ ] App wrapped with `ProviderScope`
- [ ] `FiloProviderObserver` created and registered
- [ ] Provider directory structure documented
- [ ] `flutter run` succeeds
- [ ] Hot reload works
- [ ] No console errors
- [ ] `flutter analyze` shows no errors

### Estimated Effort
2 hours

---

## EXECUTION SEQUENCE

These 5 fixes MUST be implemented in the exact order listed above due to dependencies:

1. **Fix 1 (Git Init)** - Required before any PR can be created
2. **Fix 2 (Dependencies)** - Required before code generation (Fix 4)
3. **Fix 3 (Folder Structure)** - Required before placing any code
4. **Fix 4 (Database)** - Requires Fix 2 (Drift dependency) and Fix 3 (folder structure)
5. **Fix 5 (Riverpod)** - Requires Fix 2 (Riverpod dependency)

---

## VALIDATION RULES

For each fix, the following MUST be verified:

### Pre-Implementation
- [ ] Spec reference validated (file exists, lines accurate)
- [ ] Evidence quoted is exact match from spec
- [ ] No ambiguities in requirements

### During Implementation
- [ ] Code matches spec exactly (no improvements, no creativity)
- [ ] All file paths follow spec structure
- [ ] No assumptions made

### Post-Implementation
- [ ] `flutter pub get` succeeds
- [ ] `flutter analyze` produces no new errors
- [ ] `flutter test` passes all tests
- [ ] Build logs saved to `/build_logs/<branch>-*.log`
- [ ] Coverage meets or exceeds targets

### PR Requirements
- [ ] Title format: `[WIP] fix(<area>): <summary>`
- [ ] Body includes exact spec quotes
- [ ] Body includes exact code line references
- [ ] Body includes pre/post build logs
- [ ] Body includes test results and coverage
- [ ] PR marked as DRAFT
- [ ] Agent does NOT merge (human only)

---

## BLOCKED/DEFERRED ITEMS

The following were considered but NOT selected for Phase 2:

- **Native Plugins (SAF, OCR, etc.)** - Require Android development environment setup and external dependencies (MLKit)
- **Search Implementation** - Requires database (Fix 4) to be merged first
- **Rule Engine** - Requires database (Fix 4) to be merged first
- **UI Screens** - Require design system and state management to be merged first
- **CI/CD Pipeline** - Can be implemented later, not blocking development

These will be addressed in Phase 3 after the critical blockers are resolved.

---

## STATUS TRACKING

| Fix | Status | Branch | PR | Merged |
|-----|--------|--------|----|----|
| 1. Git Init | ✅ ALREADY COMPLETE | N/A | N/A | Yes (pre-existing) |
| 2. Dependencies | ✅ MERGED | deps/add-core-dependencies-audit-20251118-1435 | Merged | Yes |
| 3. Folder Structure | ✅ MERGED | structure/scaffold-project-audit-20251118-1509 | Merged | Yes |
| 4. Database Schema | 🔄 IN PROGRESS | data/database-schema-audit-20251118-1515 | - | - |
| 5. Riverpod Setup | NOT STARTED | - | - | - |

**Last Updated:** 2025-11-18 15:09

**Note:** Fix 1 (Git Init) was already complete - repository is initialized and connected to https://github.com/srujanyadav-hyp/Filo.git

---

## NEXT ACTION

**Waiting for confirmation to proceed with Fix 1: Initialize Git Repository**

Branch to create: `init/git-repository-20251118-1430`

Commands to execute:
```powershell
git init
# Create .gitignore
git add .
git commit -m "chore: initial commit - Flutter template with FILO specs"
git branch -m main
git status  # Verify success
```

**Agent awaiting approval to begin.**
