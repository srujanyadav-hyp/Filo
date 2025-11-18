
# FILO — RULE ENGINE SPEC (ULTRA-EXPANDED)

## CORE PURPOSE
Execute automation safely, deterministically, and with full transparency.

---

# 1. INTERNAL PIPELINE
```
TriggerEvent
  → Load candidate files
  → Filter with condition tree
  → Construct Action Plan
  → Execute with atomic guarantees
  → Persist audit logs
  → Notify Flutter
```

---

# 2. CONDITION SYSTEM
### Available Condition Types
- extension  
- mime  
- folder  
- filename regex  
- OCR contains  
- image labels include  
- file size  
- created date  
- modified date  

### Evaluation Rules
- AND logic is explicit
- OR is supported via grouped condition lists
- Short-circuit evaluation

---

# 3. ACTION SYSTEM (ULTRA DETAIL)
### Action Model
- Atomic  
- Logged  
- Reversible (when possible)

### move(target)
- SAF URI → SAF URI  
- Pre-check: permissions, conflicts  
- Post-check: DB sync  

### rename(pattern)
- Uses pattern tokens: `{date}`, `{name}`, `{counter}`  

---

# 4. PREVIEW SIMULATOR
Shows:
- sample matching files  
- reasoning for match  
- risk classification  

---

# 5. SAFETY FRAMEWORK
Levels:
- low  
- medium (requires confirm)  
- high (blocked in v0)  

