
# FILO — SEARCH ARCHITECTURE (ULTRA-EXPANDED)

## 1. LAYERS
1. Preprocessing  
2. Keyword FTS search  
3. Semantic embeddings search  
4. Filter layer  
5. Ranking fusion  
6. Result formatter  

---

## 2. KEYWORD SEARCH
### Technology
SQLite FTS5 with:
- unicode61 tokenizer  
- trigram indexing  
- ranking by BM25  

---

## 3. SEMANTIC SEARCH
### Embedding model (on-device optional)
384-D vector  
Stored in compact binary format  

### Similarity
Cosine similarity:
```
dot(v1, v2) / (||v1|| * ||v2||)
```

---

## 4. MERGE LOGIC
Final score:
```
0.55 * keyword + 0.35 * semantic + 0.10 * recency
```

---

# 5. INDEX WARMING
Upon launching:
- SQLite page cache primed  
- Embedding table memory map prepared  
