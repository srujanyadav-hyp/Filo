# FILO — PHASE 4 IMPLEMENTATION PLAN

**Generated:** 2025-11-19  
**Current App Completion:** 58%  
**Target App Completion:** 85%+  
**Audit Reference:** `/reports/completion_audit.md`

---

## PHASE 4 OBJECTIVE

Complete all P1 blockers and polish P0 features to production-ready state following strict evidence-based methodology from completion audit.

**Execution Order:**
1. P1 Blockers (F7, F8, F10, F9) - Sequential implementation
2. P0 TODO Closures (17 items) - Grouped by feature
3. P0 Test Coverage (UI + Integration tests)
4. P0 UI Polish (pixel-accuracy fixes)

---

## TASK BREAKDOWN — EXACT EXECUTION ORDER

### TASK 1: F7 — FILE INDEXING ENGINE ⚠️ **[BLOCKER]**

**Priority:** P1  
**Current Completion:** 0%  
**Target Completion:** 100%  
**Branch:** `feature/F7-file-indexing-engine-20251119-1230`

#### Spec References
- `feature_specs_ultra.md` lines 1-30 (FEATURE 1 — FILE INDEXING ENGINE)
- `master_spec_ultra.md` section 4.1 (Initial Indexing)
- `master_spec_ultra.md` section 5.1 (Performance: < 15s for 1k files)

#### Implementation Requirements

**8-Step Pipeline (Exact Order):**

1. **SAF URI Read** (Step 1)
   - Input: Storage Access Framework URI
   - Output: File stream + basic metadata
   - Error: Retry 3 times, fallback to metadata-only entry
   - File: `lib/core/indexing/file_reader.dart`

2. **Metadata Normalization** (Step 2)
   - Extract: filename, MIME type, size, created_at, modified_at
   - Generate checksum (SHA256)
   - Store in `FilesIndexCompanion`
   - File: `lib/core/indexing/metadata_extractor.dart`

3. **MIME Inference** (Step 3)
   - Use package `mime` for content-based detection
   - Fallback to extension mapping
   - File: `lib/core/indexing/mime_detector.dart`

4. **OCR Text Extraction** (Step 4)
   - For images/PDFs: Use Google ML Kit Text Recognition
   - Store in `extracted_text` table with confidence score
   - Skip for non-text files
   - File: `lib/core/indexing/ocr_processor.dart`

5. **ML Image Labeling** (Step 5)
   - For images: Use Google ML Kit Image Labeling
   - Store top 5 labels in `image_labels` table
   - Skip for non-image files
   - File: `lib/core/indexing/image_labeler.dart`

6. **Vector Embedding Generation** (Step 6)
   - For text content: Generate 384-dim vector using mini embedding model
   - Store in `embeddings` table as Uint8List blob
   - Placeholder: Random vector if ONNX not ready
   - File: `lib/core/indexing/embedding_generator.dart`

7. **FTS5 Insertion** (Step 7)
   - Insert normalized_name + extracted_content into `files_fts` table
   - Enable full-text search
   - File: `lib/data/db/daos/files_dao.dart` (add `insertIntoFts` method)

8. **Index Integrity Check** (Step 8)
   - Verify all foreign keys valid
   - Mark `is_indexed = true` in `files_index`
   - Log to `activity_log` with type `file_indexed`
   - File: `lib/core/indexing/index_finalizer.dart`

**Required Files (New):**
- `lib/core/indexing/file_indexing_service.dart` - Main orchestrator
- `lib/core/indexing/file_reader.dart` - Step 1
- `lib/core/indexing/metadata_extractor.dart` - Step 2
- `lib/core/indexing/mime_detector.dart` - Step 3
- `lib/core/indexing/ocr_processor.dart` - Step 4
- `lib/core/indexing/image_labeler.dart` - Step 5
- `lib/core/indexing/embedding_generator.dart` - Step 6
- `lib/core/indexing/index_finalizer.dart` - Step 8

**Required Dependencies:**
```yaml
google_ml_kit: ^0.18.0
mime: ^1.0.5
crypto: ^3.0.3
```

**Required Tests:**
- `test/core/indexing/file_reader_test.dart` - SAF read + retry logic
- `test/core/indexing/metadata_extractor_test.dart` - Normalization + checksum
- `test/core/indexing/ocr_processor_test.dart` - Text extraction + confidence
- `test/core/indexing/image_labeler_test.dart` - Label extraction
- `test/core/indexing/embedding_generator_test.dart` - Vector generation
- `test/core/indexing/file_indexing_service_test.dart` - Full pipeline integration

**Acceptance Criteria (8 items):**
1. ✅ Reads SAF URI successfully
2. ✅ Extracts metadata (name, MIME, size, dates, checksum)
3. ✅ OCR extracts text from images/PDFs with confidence > 0.7
4. ✅ ML labels images with top 5 labels
5. ✅ Generates 384-dim embeddings
6. ✅ Inserts into FTS5 table
7. ✅ Marks is_indexed = true
8. ✅ Logs file_indexed activity

**Performance Target:**
- < 15s for 1000 files (per spec)
- < 150ms per file average

**Error Handling:**
- SAF inaccessible → retry 3x → metadata-only entry
- OCR failure → skip, continue pipeline
- ML failure → skip, continue pipeline
- Embedding failure → use zero vector

**Evidence to Generate:**
- `/build_logs/phase4/feature_F7_indexing_performance.log` - Timing for 100 files
- `/build_logs/phase4/feature_F7_test_results.log` - All tests passing
- `/build_logs/phase4/feature_F7_evidence.json` - Completion breakdown

---

### TASK 2: F8 — RULE BUILDER LOGIC (JSON ENGINE) ⚠️ **[BLOCKER]**

**Priority:** P1  
**Current Completion:** 0%  
**Target Completion:** 100%  
**Branch:** `feature/F8-rule-builder-logic-20251119-1400`

#### Spec References
- `feature_specs_ultra.md` lines 31-80 (FEATURE 2 — RULE BUILDER)
- `rule_engine_ultra.md` (full file)
- `master_spec_ultra.md` section 4.3 (Rule Execution Lifecycle)

#### Implementation Requirements

**Rule JSON Schema (from spec):**
```json
{
  "id": "rule_123",
  "name": "Move Invoices",
  "trigger": "file_added",
  "conditions": {
    "operator": "AND",
    "rules": [
      {"field": "content", "operator": "contains", "value": "invoice"},
      {"field": "mime", "operator": "equals", "value": "application/pdf"}
    ]
  },
  "actions": [
    {"type": "move", "destination": "/storage/Documents/Invoices"},
    {"type": "add_tag", "tag": "invoice"}
  ],
  "metadata": {
    "created_at": "2025-11-19T12:30:00Z",
    "created_by": "manual",
    "safety_class": "low"
  }
}
```

**Condition Operators (ALL must be supported):**
- String: `contains`, `equals`, `starts_with`, `ends_with`, `regex`
- Date: `before`, `after`, `between`
- File Type: `is_pdf`, `is_image`, `is_document`
- Directory: `in_directory`, `not_in_directory`
- Size: `greater_than`, `less_than`
- Logical: `AND`, `OR`, `NOT`

**Action Types (ALL must be supported):**
- `move` - Move file to destination URI
- `rename` - Rename with pattern (e.g., "Invoice_{date}.pdf")
- `add_tag` - Add tag to file metadata
- `notify` - Show notification

**Required Files (New):**
- `lib/core/rules/rule_engine.dart` - Main evaluator
- `lib/core/rules/condition_evaluator.dart` - Condition matching logic
- `lib/core/rules/action_executor.dart` - Action dispatcher
- `lib/core/rules/rule_validator.dart` - JSON schema validation
- `lib/core/rules/rule_parser.dart` - Parse JSON to Rule object
- `lib/data/models/rule_model.dart` - Dart model for Rule JSON
- `lib/data/models/condition_model.dart` - Dart model for Conditions
- `lib/data/models/action_model.dart` - Dart model for Actions

**Required Tests:**
- `test/core/rules/condition_evaluator_test.dart` - All operators (50+ test cases)
- `test/core/rules/action_executor_test.dart` - All action types
- `test/core/rules/rule_validator_test.dart` - Schema validation
- `test/core/rules/rule_engine_test.dart` - Full lifecycle integration

**Acceptance Criteria (10 items):**
1. ✅ Parses Rule JSON to Dart objects
2. ✅ Validates JSON schema (rejects malformed rules)
3. ✅ Evaluates AND/OR/NOT conditions correctly
4. ✅ Supports all string operators (contains, equals, starts_with, ends_with, regex)
5. ✅ Supports all date operators (before, after, between)
6. ✅ Supports all file type operators (is_pdf, is_image, is_document)
7. ✅ Supports directory operators (in_directory, not_in_directory)
8. ✅ Executes move action (updates URI in DB)
9. ✅ Executes add_tag action (stores in metadata)
10. ✅ Logs rule_executed to activity_log with success/failure status

**Performance Target:**
- < 50ms per rule evaluation (per spec)

**Safety Requirements:**
- NO destructive actions (no delete, no overwrite)
- All actions must be atomic (rollback on failure)
- Preview mode: dry-run without execution

**Evidence to Generate:**
- `/build_logs/phase4/feature_F8_rule_performance.log` - 1000 rule evaluations
- `/build_logs/phase4/feature_F8_test_results.log` - All tests passing
- `/build_logs/phase4/feature_F8_evidence.json` - Completion breakdown

---

### TASK 3: F10 — SEMANTIC SEARCH (EMBEDDINGS) ⚠️ **[BLOCKER]**

**Priority:** P1  
**Current Completion:** 0%  
**Target Completion:** 100%  
**Branch:** `feature/F10-semantic-search-20251119-1600`

#### Spec References
- `feature_specs_ultra.md` lines 81-120 (FEATURE 3 — SEARCH)
- `search_architecture_ultra.md` (full file)
- `master_spec_ultra.md` section 5.1 (Performance: < 300ms search response)

#### Implementation Requirements

**Search Modes (from spec):**
1. **Keyword** (already implemented in F5)
2. **Semantic** (NEW - use embeddings)
3. **Hybrid** (NEW - combine keyword + semantic with re-ranking)

**Ranking Layers (from spec):**
- tf-idf keyword score (weight: 0.4)
- embedding cosine similarity score (weight: 0.4)
- recency bonus (weight: 0.1)
- file-type bias (text > image) (weight: 0.1)

**Embedding Strategy:**
- Model: `all-MiniLM-L6-v2` (384 dimensions)
- Deployment: ONNX Runtime or fallback to mock vectors
- Query: Generate embedding for search query → cosine similarity with all file embeddings
- Re-rank: Combine with FTS5 keyword scores

**Required Files (New):**
- `lib/core/search/semantic_search_service.dart` - Main service
- `lib/core/search/embedding_model.dart` - ONNX model wrapper
- `lib/core/search/vector_similarity.dart` - Cosine similarity calculator
- `lib/core/search/hybrid_ranker.dart` - Score combiner
- `lib/data/db/daos/search_dao.dart` - Add `semanticSearch` and `hybridSearch` methods

**Required Dependencies:**
```yaml
onnxruntime: ^1.16.0  # or fallback to mock
vector_math: ^2.1.4
```

**Required Tests:**
- `test/core/search/embedding_model_test.dart` - Model loading + inference
- `test/core/search/vector_similarity_test.dart` - Cosine similarity calculations
- `test/core/search/hybrid_ranker_test.dart` - Score combination logic
- `test/core/search/semantic_search_service_test.dart` - Full semantic search flow

**Acceptance Criteria (6 items):**
1. ✅ Loads ONNX model (or mock fallback)
2. ✅ Generates 384-dim embedding for query string
3. ✅ Calculates cosine similarity with all file embeddings
4. ✅ Returns top-k results sorted by similarity
5. ✅ Hybrid search combines keyword + semantic scores
6. ✅ Response time < 300ms for 1000 files

**Performance Target:**
- < 300ms search response (per spec)
- < 50ms embedding generation for query

**Fallback Strategy:**
- If ONNX fails to load: Use mock random vectors (mark as "placeholder mode")
- If embeddings table empty: Fall back to keyword-only search

**Evidence to Generate:**
- `/build_logs/phase4/feature_F10_search_performance.log` - 100 queries timing
- `/build_logs/phase4/feature_F10_test_results.log` - All tests passing
- `/build_logs/phase4/feature_F10_evidence.json` - Completion breakdown

---

### TASK 4: F9 — RULE BUILDER SCREEN UI

**Priority:** P2  
**Current Completion:** 0%  
**Target Completion:** 100%  
**Branch:** `feature/F9-rule-builder-screen-20251119-1800`

#### Spec References
- `ui_blueprint_ultra_ultra.md` section on Rule Builder
- `screens/rule_builder_ultra.md` (full file)
- `interaction_flow_ultra_ultra.md` section 4 (Rule Creation Flow)

#### Implementation Requirements

**Screen Layout:**
1. **Header** - "Create Rule" title + Save/Cancel buttons
2. **Rule Name Input** - Text field (max 50 chars)
3. **Trigger Selector** - Dropdown (file_added, file_modified, manual)
4. **Conditions Builder** - Drag-drop condition blocks
5. **Actions Builder** - Drag-drop action blocks
6. **Preview Panel** - Shows affected files (dry-run)

**Condition Block Types:**
- String condition (field + operator + value)
- Date condition (field + operator + date picker)
- File type condition (checkboxes)
- Directory condition (folder picker)
- Logical operator (AND/OR button)

**Action Block Types:**
- Move action (destination picker)
- Rename action (pattern input with variables)
- Add tag action (tag input)
- Notify action (message input)

**Required Files (New):**
- `lib/presentation/screens/rule_builder_screen.dart` - Main screen
- `lib/presentation/widgets/condition_block_widget.dart` - Condition block
- `lib/presentation/widgets/action_block_widget.dart` - Action block
- `lib/presentation/widgets/rule_preview_widget.dart` - Preview panel

**Required Tests:**
- `test/presentation/screens/rule_builder_screen_test.dart` - UI widget tests
- `test/presentation/widgets/condition_block_widget_test.dart` - Condition block tests
- `test/presentation/widgets/action_block_widget_test.dart` - Action block tests

**Acceptance Criteria (8 items):**
1. ✅ Renders rule name input
2. ✅ Renders trigger selector dropdown
3. ✅ Adds/removes condition blocks
4. ✅ Adds/removes action blocks
5. ✅ Validates rule before save (calls RuleValidator)
6. ✅ Shows preview with affected files count
7. ✅ Saves rule to DB via RulesDao
8. ✅ Navigates back to home on save

**Design Token Compliance:**
- Uses AppColors, AppSpacing, AppTypography
- Matches design_tokens_ultra_ultra.md exactly
- Animations: 180ms scale 1→1.02 on focus

**Evidence to Generate:**
- `/build_logs/phase4/feature_F9_ui_evidence.json` - Property-based pixel accuracy
- `/build_logs/phase4/feature_F9_test_results.log` - All tests passing
- `/build_logs/phase4/feature_F9_evidence.json` - Completion breakdown

---

## TASK 5-21: P0 TODO CLOSURES (17 ITEMS)

**Branch Naming:** `fix/todos-<feature>-<date>`

### Group 1: Home Screen TODOs (8 items)
**Branch:** `fix/todos-home-screen-20251119-2000`

| Line | File | TODO | Implementation |
|------|------|------|----------------|
| 31 | home_screen.dart | Navigate to settings | Push to SettingsScreen (F12 - defer to Phase 5) |
| 80 | home_screen.dart | Add files action | Launch file picker, call FileIndexingService |
| 87 | home_screen.dart | Navigate to rules | Push to RuleBuilderScreen (F9) |
| 94 | home_screen.dart | Browse files | Navigate to file browser (Phase 5) |
| 202 | home_screen.dart | Show file options menu | Show bottom sheet with Open/Share/Delete/Info |
| 253 | home_screen.dart | Navigate to folder view | Navigate to folder detail screen (Phase 5) |
| 306 | home_screen.dart | Add quick action | Launch file picker modal |
| N/A | home_screen.dart | Fix folder icon size | Change from 48dp to 56dp (UI audit finding) |
| N/A | home_screen.dart | Add count badge | Show file count badge on folder cards (UI audit finding) |

**Tests Required:**
- `test/presentation/screens/home_screen_widget_test.dart` - Widget interactions
- `test/presentation/widgets/file_card_widget_test.dart` - Card press animations
- `test/presentation/widgets/quick_action_button_test.dart` - Button callbacks

### Group 2: File Detail TODOs (3 items)
**Branch:** `fix/todos-file-detail-20251119-2100`

| Line | File | TODO | Implementation |
|------|------|------|----------------|
| 42 | file_detail_screen.dart | Share file | Use share_plus package |
| 48 | file_detail_screen.dart | Show options menu | Bottom sheet with Rename/Move/Delete |
| 224 | file_detail_screen.dart | Open file | Use open_file package |
| 241 | file_detail_screen.dart | Apply rules | Show rule picker, execute selected rule |

**Tests Required:**
- `test/presentation/screens/file_detail_screen_test.dart` - All action buttons

### Group 3: Activity Log TODOs (1 item)
**Branch:** `fix/todos-activity-log-20251119-2130`

| Line | File | TODO | Implementation |
|------|------|------|----------------|
| 314 | activity_log_screen.dart | Implement undo logic | Based on activity type: rule_executed → revert file move/rename |

**Tests Required:**
- `test/presentation/screens/activity_log_screen_test.dart` - Undo logic

### Group 4: Search Results TODOs (5 items)
**Branch:** `fix/todos-search-results-20251119-2200`

| Line | File | TODO | Implementation |
|------|------|------|----------------|
| 244 | search_results_screen.dart | Load tags from metadata | Query metadata JSON field |
| 334 | search_results_screen.dart | Open file | Use open_file package |
| 342 | search_results_screen.dart | Share file | Use share_plus package |
| 350 | search_results_screen.dart | Apply rules | Show rule picker, execute selected rule |
| 358 | search_results_screen.dart | Delete file | Confirm dialog + SAF delete |
| N/A | search_results_screen.dart | Add relevance score % | Show FTS score + semantic score in badge |
| N/A | search_results_screen.dart | Add filter chips | Type filter chips (All, Documents, Images, etc.) |

**Tests Required:**
- `test/presentation/screens/search_results_screen_test.dart` - All file actions
- `test/core/search/search_integration_test.dart` - Full search flow

---

## TASK 22-25: P0 UI TESTS (4 SCREENS)

**Branch:** `test/ui-coverage-all-screens-20251119-2300`

### Required Tests (Missing from audit)
1. **Home Screen Widget Tests**
   - File: `test/presentation/screens/home_screen_widget_test.dart`
   - Coverage: Search bar focus, file card press, quick action buttons, folder grid
   - Expected: 15+ test cases

2. **File Detail Screen Widget Tests**
   - File: `test/presentation/screens/file_detail_screen_widget_test.dart`
   - Coverage: Preview rendering, metadata table, action buttons, tags
   - Expected: 10+ test cases

3. **Activity Log Screen Widget Tests**
   - File: `test/presentation/screens/activity_log_screen_widget_test.dart`
   - Coverage: Filter dropdown, activity cards, undo button, empty state
   - Expected: 12+ test cases

4. **Search Results Screen Widget Tests**
   - File: `test/presentation/screens/search_results_screen_widget_test.dart`
   - Coverage: Search input, result cards, file options modal, empty states
   - Expected: 15+ test cases

**Target Test Count:** 52+ tests (current: 41)  
**Target Test Coverage:** 80%+

---

## TASK 26: PHASE 4 SUMMARY & AUDIT UPDATE

**Branch:** `docs/phase4-summary-20251120-0000`

**Actions:**
1. Run full test suite: `flutter test`
2. Generate coverage report: `flutter test --coverage`
3. Update `/reports/completion_audit.md`:
   - F7: 0% → 100%
   - F8: 0% → 100%
   - F9: 0% → 100%
   - F10: 0% → 100%
   - F2: 68% → 95% (TODO closures + tests)
   - F3: 70% → 95% (TODO closures + tests)
   - F4: 72% → 95% (TODO closures + tests)
   - F5: 65% → 95% (TODO closures + tests)
   - Total App Completion: 58% → 85%+
4. Create `/reports/phase4_summary.md` with:
   - All PR links
   - Updated completion %
   - Performance benchmarks
   - Test coverage report
   - Next phase (F11, F12, F13)

---

## BRANCH NAMING CONVENTION

```
feature/<feature-id>-<description>-YYYYMMDD-HHMM
fix/todos-<feature>-YYYYMMDD-HHMM
test/<scope>-YYYYMMDD-HHMM
docs/<description>-YYYYMMDD-HHMM
```

**Examples:**
- `feature/F7-file-indexing-engine-20251119-1230`
- `fix/todos-home-screen-20251119-2000`
- `test/ui-coverage-all-screens-20251119-2300`
- `docs/phase4-summary-20251120-0000`

---

## PR TEMPLATE (TO BE USED FOR EACH TASK)

```markdown
## Feature: [F7 / F8 / F9 / F10 / TODO Closures / UI Tests]

### Spec References
- `feature_specs_ultra.md` lines X-Y
- `completion_audit.md` Table A, row Z

### Changes Made
- [ ] File 1: Description
- [ ] File 2: Description
- [ ] Tests: X new tests added

### Acceptance Criteria Met
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] All tests passing

### Evidence
- Build logs: `/build_logs/phase4/<branch>_*`
- Test results: `/build_logs/phase4/feature_FX_test_results.log`
- Performance: `/build_logs/phase4/feature_FX_performance.log`

### Before Merge Checklist
- [ ] `flutter analyze` - 0 errors
- [ ] `flutter test` - All passing
- [ ] `gradlew assembleDebug` - Success
- [ ] Evidence files committed
```

---

## SUCCESS CRITERIA FOR PHASE 4

| Metric | Current | Target | Method |
|--------|---------|--------|--------|
| Feature Completion | 46% (6/13) | 77% (10/13) | F7, F8, F9, F10 implemented |
| Test Coverage | 41% (41 tests) | 80%+ (95+ tests) | +52 new tests |
| Total App Completion | 58% | 85%+ | All categories improved |
| P1 Blockers | 3 | 0 | F7, F8, F10 done |
| TODOs | 17 | 0 | All closed |
| UI Pixel-Accuracy | 95% | 98%+ | Fix folder icon, add badges |

---

## EXECUTION START

**NEXT IMMEDIATE ACTION:**  
Create branch `feature/F7-file-indexing-engine-20251119-1230` and begin implementing Task 1 (File Indexing Engine).

**Estimated Timeline:**
- Task 1 (F7): 2-3 days
- Task 2 (F8): 2-3 days
- Task 3 (F10): 1-2 days
- Task 4 (F9): 1-2 days
- Tasks 5-21 (TODOs): 2-3 days
- Tasks 22-25 (Tests): 1-2 days
- Task 26 (Summary): 1 day

**Total Phase 4 Duration:** 10-16 days

---

**STATUS:** ✅ Plan complete. Ready to execute Task 1.
