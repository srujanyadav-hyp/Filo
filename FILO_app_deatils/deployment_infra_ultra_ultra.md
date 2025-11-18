
# FILO — ULTRA–ULTRA EXPANDED DEPLOYMENT INFRASTRUCTURE SPEC

This is the full infrastructure definition covering Android distribution, signing, backend optional integration, telemetry, crash processing, and release channel management.

---

# 1. ANDROID DEPLOYMENT TARGETS

### Build Variants
- **debug**  
- **release**  
- **benchmark** (with additional tracing)

### Supported architectures:
- arm64-v8a  
- armeabi-v7a  
- x86_64 (optional)  

APK size target: **< 32 MB**

---

# 2. SIGNING INFRASTRUCTURE

## 2.1 Keystore Requirements
- Type: JKS  
- Algorithm: RSA 4096  
- Validity: 10 years  
- Stored encrypted inside CI secrets  

## 2.2 Signing Steps
1. `keytool –genkeypair`  
2. Store keystore  
3. Add keystore pass in CI secrets  
4. Configure `key.properties`  

---

# 3. OPTIONAL BACKEND DEPLOYMENT (SUPABASE)

### Used for:
- AI failover  
- rule validation logs  
- analytics (errors only)  
- config rollout  

### Tables:
1. app_settings  
2. ai_logs  
3. rule_validation_logs  

### Policies:
- RLS enabled  
- Only service role may write  

---

# 4. RELEASE CHANNELS

### Alpha
- Internal testers only  
- Logs enabled  
- Crashlytics debug  

### Beta
- External testers  
- Limited telemetry  

### Production
- Full rollout  
- All experimental flags disabled  

---

# 5. FULL TELEMETRY PIPELINE

### Events to Capture:
- rule execution failures  
- indexing errors  
- plugin exceptions  
- AI failovers  
- SQL errors  
- slow searches (>300ms)  

Stored in:
- Crashlytics  
- Internal log DB (local)  

