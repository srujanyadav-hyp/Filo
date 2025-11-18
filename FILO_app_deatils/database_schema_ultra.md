
# FILO — Ultra-Expanded Database Schema

## 1. SCHEMA PHILOSOPHY
The database schema is optimized for:
- fast FTS searches,
- incremental updates,
- atomic rule execution,
- background-safe writes,
- large dataset stability.

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
...

### embeddings
- file_id
- vector (binary)
- dim
- model_version
- quantization_level
...

