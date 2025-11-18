
# FILO — Data Flow Diagrams (Ultra-Expanded)

## 1. INDEXING PIPELINE

User selects folder
  → SAF permission persisted
  → Worker scans folder tree
  → Push metadata
  → Generate extraction tasks
     → OCR pipeline
     → Labeling pipeline
     → Embedding pipeline
  → DB write
  → UI refresh

## 2. RULE EXECUTION PIPELINE
Trigger event
 → candidate fetch
 → condition evaluation
 → action graph
 → execution batches
 → rollback on failure
 → audit write
...

