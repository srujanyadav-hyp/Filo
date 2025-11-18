
# FILO — FEATURE SPECIFICATIONS (ULTRA-EXPANDED)

Each feature is described with functional, technical, UX, edge-case, and data requirements.

---

# FEATURE 1 — FILE INDEXING ENGINE
## Goal
Create a structured index of every file.

## Inputs
- SAF URI  
- Metadata  
- OCR text  
- Image labels  
- Embeddings  

## Processing Pipeline (Ultra Detail)
1. **Metadata Normalization**
2. **MIME inference**
3. **Thumbnail extraction**
4. **OCR text extraction**
5. **Image labeling model**
6. **Vector embedding generator**
7. **FTS5 insertion**
8. **Index integrity check**

## Outputs
- Updated `files_index` table entry
- New rows in `extracted_text`, `image_labels`, `embeddings`

## Failure Modes
- SAF inaccessible → retry 3 times  
- Unsupported file → metadata-only entry  

---

# FEATURE 2 — RULE BUILDER
## Types of rule creation
- Manual  
- AI-assisted  

### Rule JSON Schema (ULTRA EXPANDED)
```
{
  "id": "rule_id",
  "trigger": {...},
  "conditions": [...],
  "actions": [...],
  "metadata": {
      "created_at": timestamp,
      "created_by": "ai/manual",
      "safety_class": "low/medium/high"
  }
}
```

### Actions supported:
- move  
- rename  
- add_tag  
- notify  

### Validation Layers:
1. Schema  
2. Safety check  
3. AI reasoning critique  
4. Preview examples  

---

# FEATURE 3 — SEARCH
## Modes:
- Keyword  
- Semantic  
- Hybrid  

## Ranking Layers (Ultra Detail)
- tf-idf keyword score  
- embedding cosine score  
- recency bonus  
- file-type bias (text > image)  

---

# FEATURE 4 — FILE DETAIL VIEW
Shows:
- Preview  
- Metadata  
- Text extracted  
- Tags  
- Activity history  

---

# FEATURE 5 — ACTIVITY LOG
Stores:
- Which rule ran  
- What file changed  
- Pre/post URIs  
