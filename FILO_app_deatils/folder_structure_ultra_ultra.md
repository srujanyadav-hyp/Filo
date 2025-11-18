
# FILO — ULTRA–ULTRA EXPANDED FOLDER STRUCTURE

This defines EXACTLY how all files in the project must be structured.

---

# 1. ROOT DIRECTORY

```
/filo
   /android
   /lib
   /test
   /assets
   /docs
   /scripts
   pubspec.yaml
```

---

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

---

# 3. PLUGIN & NATIVE

```
/android/app/src/main/kotlin/com/filo
   /plugins
      FiloSafPlugin.kt
      FiloOcrPlugin.kt
      FiloImageLabeler.kt
      FiloWorker.kt
```

---

# 4. TESTS

```
/test
   /unit
   /widget
   /integration
   /data
```

All folders must follow this hierarchy **exactly** for the build agent to reason well.

