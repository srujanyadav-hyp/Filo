# FILO — PHASE 5 IMPLEMENTATION PLAN

**Generated:** 2025-11-20  
**Current App Completion:** 87%  
**Target App Completion:** 95%+  
**Phase 4 Completion Status:** ✅ Complete (58% → 87%)

---

## PHASE 5 OBJECTIVE

Complete remaining P0 features (Settings, Onboarding) and establish production-ready polish for 95%+ app completion. Focus on user preferences, first-run experience, and final integrations.

**Execution Order:**
1. F11 - Settings Screen (P0)
2. F13 - Onboarding Flow (P0)
3. Database DAO Integration (Complete remaining)
4. Performance Optimization & Polish
5. Phase 5 Summary & Final Audit

---

## TASK BREAKDOWN — EXACT EXECUTION ORDER

### TASK 1: F11 — SETTINGS SCREEN ⚠️ **[P0]**

**Priority:** P0  
**Current Completion:** 0%  
**Target Completion:** 100%  
**Branch:** `feature/F11-settings-screen-20251120-0100`

#### Spec References
- `screens/settings_ultra.md` (full file)
- `ui_blueprint_ultra_ultra.md` settings section
- `master_spec_ultra.md` section 7 (Settings & Preferences)

#### Implementation Requirements

**Screen Layout (Per spec):**
1. **Header** - "Settings" title + back button
2. **Account Section** - User profile (deferred - no auth yet)
3. **Indexing Preferences** - Schedule, auto-index toggle
4. **Search Preferences** - Default search mode (Text/Visual/Semantic)
5. **Appearance** - Theme toggle (Light/Dark/System)
6. **Storage** - Cache management, index stats
7. **About** - App version, licenses, credits

**Settings Data Model:**
```dart
class AppSettings {
  // Indexing
  bool autoIndexEnabled;
  String indexSchedule; // 'manual', 'daily', 'weekly'
  
  // Search
  String defaultSearchMode; // 'text', 'visual', 'semantic'
  
  // Appearance
  String themeMode; // 'light', 'dark', 'system'
  
  // Storage
  int cacheSizeMB;
  int indexedFilesCount;
}
```

**Required Files (New):**
- `lib/presentation/screens/settings_screen.dart` - Main settings screen
- `lib/presentation/widgets/settings_section.dart` - Section container
- `lib/presentation/widgets/settings_tile.dart` - Individual setting item
- `lib/data/models/app_settings.dart` - Settings data model
- `lib/data/repositories/settings_repository.dart` - Settings persistence (SharedPreferences)

**Settings Categories (7 sections):**

1. **Account** (Placeholder)
   - Profile picture + name
   - "Sign in to sync" button (disabled with "Coming soon")

2. **Indexing**
   - Auto-index toggle
   - Schedule dropdown: Manual, Daily, Weekly
   - "Re-index all files" button

3. **Search**
   - Default search mode: Text, Visual, Semantic
   - "Clear search history" button

4. **Appearance**
   - Theme mode: Light, Dark, System
   - Preview updates instantly

5. **Storage**
   - Cache size display (MB)
   - Indexed files count
   - "Clear cache" button
   - "Clear index" button (with confirmation)

6. **Notifications**
   - Enable notifications toggle
   - Rule execution alerts toggle

7. **About**
   - App version (from pubspec.yaml)
   - "Licenses" button → shows LicensePage
   - "Privacy Policy" button
   - "Terms of Service" button

**Required Tests:**
- `test/presentation/screens/settings_screen_test.dart` - 15+ widget tests
- `test/data/repositories/settings_repository_test.dart` - 10+ unit tests

**Acceptance Criteria (8 items):**
1. ✅ Renders all 7 settings sections
2. ✅ Toggle switches work (auto-index, theme, notifications)
3. ✅ Dropdown selections persist (schedule, search mode)
4. ✅ Theme changes apply immediately
5. ✅ Storage stats display correctly
6. ✅ Clear cache/index with confirmation dialogs
7. ✅ Settings persist across app restarts
8. ✅ Navigation back to home works

**Dependencies:**
```yaml
shared_preferences: ^2.2.2  # Settings persistence
```

**Design Token Compliance:**
- Uses AppColors, AppSpacing, AppTypography
- ListTile height: 56dp
- Section spacing: 24dp
- Icon size: 24dp

**Evidence to Generate:**
- `/build_logs/phase5/feature_F11_evidence.json`
- `/build_logs/phase5/feature_F11_test_results.log`

---

### TASK 2: F13 — ONBOARDING FLOW ⚠️ **[P0]**

**Priority:** P0  
**Current Completion:** 0%  
**Target Completion:** 100%  
**Branch:** `feature/F13-onboarding-flow-20251120-0200`

#### Spec References
- `screens/onboarding_ultra.md` (full file)
- `ui_blueprint_ultra_ultra.md` onboarding section
- `master_spec_ultra.md` section 8 (First Run Experience)

#### Implementation Requirements

**3-Screen Flow:**

**Screen 1: Welcome**
- Hero illustration
- "Welcome to FILO" title
- "Your intelligent file organizer" subtitle
- "Next" button

**Screen 2: Features**
- 3 feature cards:
  * Smart Search (icon + description)
  * Auto-organize (icon + description)
  * Rule Automation (icon + description)
- Page indicators (3 dots)
- "Next" button + "Skip" text button

**Screen 3: Permissions**
- Storage permission illustration
- "Allow Storage Access" title
- "FILO needs access to organize your files" explanation
- "Grant Permission" button
- "Skip for now" text button (proceeds with limited functionality)

**Post-Onboarding:**
- Set `first_run_complete = true` in SharedPreferences
- Navigate to HomeScreen
- Show "Welcome! Tap + to add files" snackbar

**Required Files (New):**
- `lib/presentation/screens/onboarding_screen.dart` - PageView with 3 pages
- `lib/presentation/widgets/onboarding_page.dart` - Individual page widget
- `lib/presentation/widgets/feature_card.dart` - Feature highlight card
- `lib/data/repositories/onboarding_repository.dart` - Track completion status

**Page Transitions:**
- Swipe left/right
- Animated page indicators
- Skip button on pages 1-2
- 300ms transition duration

**Required Tests:**
- `test/presentation/screens/onboarding_screen_test.dart` - 12+ widget tests
- `test/data/repositories/onboarding_repository_test.dart` - 5+ unit tests

**Acceptance Criteria (7 items):**
1. ✅ Renders 3 onboarding pages
2. ✅ Swipe navigation works
3. ✅ Page indicators update correctly
4. ✅ Skip button navigates to home
5. ✅ Permission request on page 3
6. ✅ Completion status persists
7. ✅ Only shows on first run

**Dependencies:**
- Uses existing `permission_handler` package

**Design Token Compliance:**
- Hero illustration size: 240dp × 240dp
- Title: AppTypography.headingL
- Body: AppTypography.bodyM
- Button height: 48dp
- Page indicator size: 8dp

**Evidence to Generate:**
- `/build_logs/phase5/feature_F13_evidence.json`
- `/build_logs/phase5/feature_F13_test_results.log`

---

### TASK 3: DATABASE DAO INTEGRATION

**Priority:** P1 (Support for existing features)  
**Branch:** `fix/dao-integration-20251120-0300`

#### Missing Integrations

**Home Screen:**
- Load recent files from FilesDao
- Display actual file counts in folder categories

**Search Results:**
- Integrate with SemanticSearchService from F10
- Load tags from FileMetadataDao

**Rule Builder:**
- Save rules via RulesDao
- Load existing rules for editing

**Activity Log:**
- Real undo operations via ActionExecutor

**Required Files to Update:**
- `lib/presentation/screens/home_screen.dart` - Add FilesDao
- `lib/presentation/screens/search_results_screen.dart` - Add SemanticSearchService
- `lib/presentation/screens/rule_builder_screen.dart` - Complete save/load
- `lib/presentation/screens/activity_log_screen.dart` - Real undo logic

**Acceptance Criteria:**
1. ✅ Home loads real file data
2. ✅ Search uses F10 semantic service
3. ✅ Rules save to database
4. ✅ Activity log shows real activities
5. ✅ Undo operations work

---

### TASK 4: PERFORMANCE OPTIMIZATION & POLISH

**Priority:** P1  
**Branch:** `perf/optimization-pass-20251120-0400`

#### Optimization Areas

**1. Search Performance**
- Profile semantic search for 10k+ files
- Optimize vector similarity calculations
- Add result caching (LRU cache, 100 entries)

**2. Indexing Performance**
- Batch processing for bulk indexing
- Progress indicators for long operations
- Background isolate for heavy computation

**3. UI Responsiveness**
- Image loading optimization
- List view performance (lazy loading)
- Animation performance audit

**4. Memory Management**
- Profile memory usage
- Fix any memory leaks
- Optimize image caching

**Performance Targets:**
- App cold start: <2s
- Search response: <200ms
- Indexing throughput: >100 files/min
- Scroll FPS: 60fps maintained
- Memory usage: <150MB baseline

**Required Tools:**
- Flutter DevTools profiler
- `flutter analyze --no-fatal-infos`
- `flutter test --coverage`

---

### TASK 5: PHASE 5 SUMMARY & FINAL AUDIT

**Branch:** `docs/phase5-summary-20251120-0500`

**Actions:**
1. Run full test suite: `flutter test`
2. Generate coverage report: `flutter test --coverage`
3. Update `/reports/completion_audit.md`:
   - F11: 0% → 100%
   - F13: 0% → 100%
   - Total App Completion: 87% → 95%+
4. Create `/reports/phase5_summary.md` with:
   - All PR links
   - Updated completion %
   - Performance benchmarks
   - Test coverage report
   - Production readiness checklist

---

## BRANCH NAMING CONVENTION

```
feature/F<id>-<description>-YYYYMMDD-HHMM
fix/<description>-YYYYMMDD-HHMM
perf/<description>-YYYYMMDD-HHMM
docs/<description>-YYYYMMDD-HHMM
```

---

## SUCCESS CRITERIA FOR PHASE 5

| Metric | Current | Target | Method |
|--------|---------|--------|--------|
| Feature Completion | 77% (10/13) | 92%+ (12/13) | F11, F13 implemented |
| Total App Completion | 87% | 95%+ | All categories improved |
| Test Coverage | 84% (180 tests) | 90%+ (200+ tests) | +20 new tests |
| Performance | Baseline | Optimized | <2s cold start |
| P0 Features Complete | 10/12 | 12/12 | Settings + Onboarding |

---

## EXECUTION START

**NEXT IMMEDIATE ACTION:**  
Create branch `feature/F11-settings-screen-20251120-0100` and begin implementing Task 1 (Settings Screen).

**Estimated Timeline:**
- Task 1 (F11 Settings): 1-2 days
- Task 2 (F13 Onboarding): 1 day
- Task 3 (DAO Integration): 1-2 days
- Task 4 (Performance): 1-2 days
- Task 5 (Summary): 1 day

**Total Phase 5 Duration:** 5-8 days

---

**STATUS:** ✅ Plan complete. Ready to execute Task 1.
