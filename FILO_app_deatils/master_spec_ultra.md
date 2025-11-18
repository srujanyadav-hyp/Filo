
# FILO — MASTER SPECIFICATION (ULTRA-EXPANDED EDITION)

## 1. PRODUCT PURPOSE — FULL VISION
FILO is a device-level automation and semantic file organization system designed for Android. It handles:
- Intelligent file indexing  
- Deep metadata extraction  
- On-device AI-assisted classification  
- Natural language rule creation  
- File automation workflows  
- Hyper-fast hybrid search  
- Fully offline capability (except optional AI tasks)

This spec describes FILO as if it were a production-grade system used by millions.

---

## 2. USER ARCHETYPES — FULL DETAIL
### 2.1 Professionals
- Thousands of documents (payslips, invoices, offers)
- Needs instant search across text, metadata, OCR

### 2.2 Students
- PDFs, images, screenshots, notes  
- Want automated folder structuring

### 2.3 Creators
- Media-heavy: 20k+ images  
- Need tagging & semantic search by concepts

---

## 3. CORE PROBLEMS SOLVED
### Problem 1 — File clutter
FILO automates:
- Moving files
- Categorizing based on content
- Renaming consistently

### Problem 2 — Slow file search
FILO indexes:
- Filename  
- Metadata  
- OCR text  
- AI-generated tags  
- Embeddings  

### Problem 3 — Manual workflow creation is hard
FILO uses AI to:
- Convert natural sentences → Rule JSON
- Validate automation logic
- Simulate matches

---

## 4. HIGH-LEVEL SYSTEM BEHAVIOR
### 4.1 Initial Indexing
- Scans SAF-selected directory
- Extracts metadata from every file
- Runs OCR & image labeling
- Generates embeddings
- Stores results in Drift DB

### 4.2 Incremental Indexing
- MediaStore listener detects changes
- File watcher updates the index

### 4.3 Rule Execution Lifecycle
```
Trigger → Condition Matching → Action Plan → Atomic Execution → Logging → UI updates
```

---

## 5. GUARANTEES
### 5.1 Performance
- < 300ms: Search response time  
- < 50ms: Rule condition evaluation  
- < 15s: Cold start indexing of 1k files  

### 5.2 Safety
- No destructive actions in v0  
- No auto-delete  
- All automation requires preview  

---

## 6. OUT-OF-SCOPE (EXPLICIT)
- Cloud sync  
- Multi-device merge  
- AI image generation  
- Media editing  

---

## 7. VERSION 0 REQUIREMENTS — FULL LIST
- Indexing  
- Search  
- Rules  
- Rule AI assistance  
- File detail view  
- Activity log  
- Persisted storage  
- Error handling  
- Background workers  
- Native Kotlin plugins  

