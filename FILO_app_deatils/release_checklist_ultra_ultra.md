
# FILO — ULTRA–ULTRA EXPANDED RELEASE CHECKLIST

This is the authoritative list of steps required before publishing a release.

---

# 1. PRE-BUILD VALIDATION

### Must verify:
- All tests 100% passed  
- Rule engine preview safety fully verified  
- Indexing stress tests done (10k files)  
- Search load test passed  
- Native plugin compiled without warnings  
- DB migrations verified  

---

# 2. ARTIFACTS REQUIRED
- Release APK  
- AAB bundle  
- ABI split APKs  
- Mapping.txt (for crash de-sobfuscation)  
- Coverage report  
- Raw logs  

---

# 3. PLAY STORE REQUIREMENTS

### Graphics
- 1080×1920 screenshots  
- 1024×500 feature graphic  
- 512×512 icon  

### Metadata
- Title: FILO  
- Short desc: “Smart file automation & search engine.”  
- Full desc (≥800 chars)  

---

# 4. POST-RELEASE MONITORING

Within first 48 hours:
- Crash-free rate > 99%  
- AI rule errors < 0.05%  
- Indexing failures < 0.01%  
- No ANRs allowed  

