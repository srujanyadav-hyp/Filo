
# FILO — ULTRA–ULTRA EXPANDED DEVELOPER ONBOARDING GUIDE

This document prepares a new engineer (or AI build agent) to work on FILO with zero missing context.

---

# 1. DEVELOPMENT PHILOSOPHY

FILO is engineered with 4 core principles:

1. **Determinism**  
   No random behavior anywhere. Every module produces the same output given the same input.

2. **Predictable Architecture**  
   Code organization and folder structure follow strict conventions.

3. **Safety First**  
   Especially for automation features. No rule executes without validation.

4. **Maintainability at Scale**  
   Every module built today must be maintainable 2 years later by a new engineer.

---

# 2. SYSTEM REQUIREMENTS

### Software:
- Flutter 3.24+
- Dart 3+
- Android SDK 34
- Java 17
- Gradle 8
- Kotlin 1.9+
- SQLite FTS5 support

### Hardware:
- 8GB RAM minimum (16GB recommended)
- 20GB free disk

---

# 3. GETTING STARTED

## 3.1 Clone the repository
```
git clone https://github.com/.../filo.git
cd filo
```

## 3.2 Install dependencies
```
flutter pub get
```

## 3.3 Set up Android environment
- Install Android Studio
- Enable SDK 34
- Install NDK 25.1

## 3.4 Run the app
```
flutter run
```

---

# 4. PROJECT RULES FOR EVERY CONTRIBUTOR

### 4.1 Mandatory Before Any Commit
- Format Dart & Kotlin
- Run all tests
- Check for schema drift
- Verify native plugins compile

### 4.2 Code Review Requirements
- No untyped JSON maps
- No async gaps in rule engine
- All rule schema changes must update docs
- No TODOs allowed in production code

---

# 5. DEBUGGING GUIDELINES

### Debug Indexing:
- `adb logcat | grep FiloIndex`
### Debug Rules:
- `adb logcat | grep FiloRuleEngine`
### Debug Native Plugins:
- Use breakpoints in Android Studio Kotlin module

---

# 6. DEVELOPER MINDSET
Engineers must understand:
- SAF limitations
- Native plugin boundaries
- File automation risk levels
- Agent mode constraints

This document ensures a new developer reaches expertise in **24 hours** instead of weeks.

