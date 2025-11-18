
# FILO — DESIGN TOKENS (ULTRA–ULTRA EXPANDED)

This is the FINAL canonical token source for design, engineering, and build agent integration.

---

# 1. COLOR SYSTEM (FULL DETAIL)

## 1.1 Primary Colors
| Token | Hex | Role |
|-------|------|------|
| primary.900 | #0A0F1F | Deep background, dark mode |
| primary.800 | #0F172A | Card container backdrop |
| primary.700 | #152240 | Gradient bottom |
| primary.600 | #1E3A8A | Gradient highlight |

## 1.2 Accent Colors
- accent.teal.500: #06B6D4  
- accent.teal.300: #5EEBF7  

---

# 2. TYPOGRAPHY SPEC (FULL MATRIX)

### Headings
- xl: 28sp 700
- l: 22sp 600
- m: 18sp 600
- s: 16sp 600

### Body
- l: 16sp 400
- m: 14sp 400
- sm: 13sp 400

### Caption
- 12sp 400
- letter spacing: +0.3

---

# 3. ELEVATION SYSTEM

| Level | y-offset | blur | opacity |
|--------|----------|-------|----------|
| low | 2 | 4 | 10% |
| medium | 6 | 12 | 14% |
| high | 12 | 24 | 18% |
| splash | 18 | 30 | 25% |

---

# 4. GRADIENT LANGUAGE
```
gradient.primary:
  start: #0F172A (brightness +4%)
  end: #1E3A8A (brightness -3%)
  angle: 38 degrees
  blendMode: soft-light
```

---

# 5. SPACING & LAYOUT MATRIX
Defines the entire app spacing mathematically:

```
2, 4, 6, 8, 12, 16, 24, 32, 48, 64dp
```

Every FILO screen must align to these exact increments.

