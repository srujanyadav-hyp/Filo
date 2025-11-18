
# FILO — ULTRA–ULTRA EXPANDED TESTING & CI SYSTEM

This document defines the FULL test philosophy, execution layers, CI/CD automation behavior, failure logic, performance guards, and code quality gates for FILO.

---

# 1. TEST PHILOSOPHY (FOUNDATION LEVEL)

FILO’s test system follows 7 principles:

1. **Determinism**  
   - All unit tests MUST produce identical results on all machines.
   - AI tests MUST be run with temperature=0 and strict-schema mode.

2. **Isolation**  
   - Tests may not depend on remote APIs.
   - All filesystem operations must be mocked with in-memory FS.

3. **Atomicity**  
   - Rule engine tests must validate atomic execution (no partial operations).

4. **Performance Boundaries**  
   - Indexing functions must complete under 45ms for 100 files in test mode.
   - FTS search queries must complete under 20ms.

5. **Coverage Discipline**  
   - Rule engine → 100% branch coverage  
   - Drift database DAOs → 95%  
   - Native Kotlin Plugins → 80%  
   - Flutter UI → snapshot testing for all screens  

6. **Security & Safety Testing**  
   - Destructive rule creation tests  
   - Unsafe trigger detection tests  
   - SAF permission error handling tests  

7. **Continuous Verification**  
   - Every PR MUST run full pipeline before merge.

---

# 2. FULL TEST PYRAMID

## 2.1 UNIT TESTS (Largest Volume)

### Coverage Areas
- Rule Condition Matching  
- Rule Action Planning  
- Naming Engine Generation  
- Semantic Search Normalizers  
- OCR Text Merger Logic  
- Drift Schema Constraints  
- Embedding Normalization  

### Required Data Fixtures
- 100 synthetic filenames  
- MIME variant dataset  
- OCR realistic noisy text samples  
- Duplicate file simulations  

Expected count: **600+ tests**

---

## 2.2 WIDGET TESTS (UI Behavior)

### Must cover:
- Search bar behavior  
- FAB expansion animation  
- File card rendering correctness  
- Rule Builder Stepper state transitions  
- Settings toggles logic  
- Error banners behavior  

---

## 2.3 INTEGRATION TESTS

### Must simulate:
- SAF → Indexer → DB → UI render  
- Rule execution end-to-end  
- Search hybrid execution  
- Native plugin → Flutter bridge calls  

---

## 2.4 NATIVE KOTLIN TESTS

### Test categories:
- SAF path resolution  
- DocumentFile tree traversal  
- Move+Rename operations  
- WorkerManager scheduling  
- MediaStore listeners  

---

# 3. CI SYSTEM (ULTRA EXPANDED)

## 3.1 GITHUB ACTIONS PIPELINE STAGES

1. **Setup Stage**
   - Install Flutter  
   - Install Java 17  
   - Install Android Commandline tools  
   - Cache: pub + gradle + build intermediates  

2. **Static Checks**
   - `flutter analyze`  
   - `dart format`  
   - Kotlin linter (ktlint)  

3. **Test Stage**
   - Dart Unit  
   - Dart Widget  
   - Integration tests (headless emulator)  
   - Kotlin tests (Gradle `testDebugUnitTest`)  

4. **Build Stage**
   - Debug APK  
   - Release APK  
   - AAB bundle  
   - ABI-split APKs  

5. **Artifact Stage**
   - Upload all builds  
   - Attach coverage reports  
   - Generate test summary  

6. **Notification Stage**
   - PR status badges  
   - Slack/Discord optional integration  

---

# 4. FAILURE CONDITIONS
Pipeline fails if:
- any test fails  
- any linter error  
- DB migration causes schema drift  
- native plugin fails compilation  
- rule engine unsafe-action test fails  
- build takes > 25 minutes (performance guard)  

