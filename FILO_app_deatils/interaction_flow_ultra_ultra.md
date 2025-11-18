
# FILO — INTERACTION FLOW (ULTRA–ULTRA EXPANDED)

Here we define complete behavioral logic.

---

# 1. ONBOARDING DECISION GRAPH

```
(Start)
  ↓
Splash
  ↓
Is first launch?
  Yes → Intro
  No → Home
```

During SAF selection:
```
User taps Select Folder
  ↓
System File Picker
  ↓
Did user grant URI?
  Yes → Persist Permission → Indexing
  No → Retry Modal → Back to Start
```

---

# 2. RULE BUILDER DECISION GRAPH

### Natural Language Path
```
User enters text → Validate length (>4) → Generate AI rule → Validate JSON → Show explanation → Allow edits → Preview → Enable
```

### Manual Path
```
Add Condition → Add Action → Review JSON → Preview → Enable
```

---

# 3. SEARCH FLOW (ADVANCED)

### Multi-Phase Search
1. Phase 1 (0–60ms): FTS keyword results  
2. Phase 2 (100–350ms): semantic search returns vectors  
3. Phase 3: fuse & re-rank  

---

# 4. FILE DETAIL FLOW

Actions:
- Rename (via naming AI)
- Move (via SAF)
- View extracted text
- View labels
- View history
- Share

