
# FILO — Backend API Contracts (Ultra-Expanded)

Even though FILO is offline-first, backend contracts are defined for:
- AI model gateway,
- rule validation,
- search intent parsing,
- telemetry.

## 1. RULE GENERATION ENDPOINT
POST /v1/rule/generate
Input:
{
 "text": "...",
 "context": {...}
}

Output:
{
 "rule_json": {...},
 "explanations": [...],
 "safety_level": "low/medium/high"
}

...

