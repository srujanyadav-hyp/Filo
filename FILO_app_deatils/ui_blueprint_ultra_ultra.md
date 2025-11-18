
# FILO — UI BLUEPRINT (ULTRA–ULTRA EXPANDED EDITION)

This is the deepest form of the FILO UI Specification:  
Pixel-level, behavioral-level, state-level, accessibility-level, interaction-level, and perception-level detail.

---

# 1. GLOBAL DESIGN SYSTEM (FULL SPEC)

## 1.1 Grid Architecture
- Base width: **360dp**
- Safe area paddings:
  - Top: 24dp
  - Bottom: 16dp
  - Horizontal: 16dp
- Vertical Rhythm: **8dp baseline grid**
- Column System:
  - 4 columns
  - 12dp gutters
  - Column width: 82dp

## 1.2 UI Scale Definitions
- Compact Mode (< 360dp): reduce spacing -2dp
- Default Mode (360–400dp): standard
- Expanded Mode (>400dp): increase spacing +4dp and widen content to max 640dp

---

# 2. COMPONENT BLUEPRINTS (HYPER-DETAILED)

## 2.1 Search Bar (Complete Anatomy)
### Dimensions
- Height: **48dp**
- Radius: **12dp**
- Leading icon: **20dp**
- Trailing icon (clear): **20dp**
- Text baseline offset: **center-aligned to container height**

### States (Full)
| State | BG Color | Shadow | Placeholder | Cursor | Animation |
|-------|----------|--------|-------------|--------|-----------|
| Idle | neutral.100 | none | 60% opacity | hidden | none |
| Focused | white | 2dp mid shadow | 40% opacity | visible (accent teal) | fade+shadow 180ms |
| Filled | white | subtle | hidden | active | fade 80ms |

### Interaction Rules
- Clear button appears after ≥1 character typed
- When typing begins, bar expands horizontally by +4dp (spring animation)
- When losing focus, returns to original width over 180ms

---

## 2.2 File Card (Ultra Expanded)
### Layout Grid
```
|IMG(72x72)| 12dp | VStack(title, meta)            | 12dp | ⋮ (48dp hitbox)|
```

### Title Rules
- Weight: medium
- Max lines: **1**
- Ellipsis: trailing
- Color: neutral.900

### Subtitle Rules
- Contains:
  - Modified date
  - File size OR detected tags
- Max lines: 2
- Line height: 16dp

### Hover / Press responsiveness
- Press:
  - Scale: 1 → 0.96 (120ms easeOut)
  - Shadow: increase to mid elevation (120ms)

### Accessibility Labels
```
"File: <filename>, modified on <date>, size <x>"
```

---

# 3. MOTION SYSTEM (FULL PHYSICS)

## 3.1 Device Motion Budget
- 60fps requirement
- GPU Overdraw target: under 3 layers
- Avoid blur filters

## 3.2 Transition Specifications
### Screen Push Transition
- Incoming:
  - opacity: 0 → 1 (280ms)
  - translateX: 24 → 0dp (280ms)
- Outgoing:
  - opacity: 1 → 0 (140ms)

### Bottom Sheet
- Start: translateY(100%)
- End: translateY(0)
- Duration: 260ms
- Curve: cubic-bezier(0.16,1,0.3,1)

---

# 4. COLOR BEHAVIOR RULES (ADVANCED)

## 4.1 Gradient Dynamics
Primary gradient must adapt brightness based on:
- Screen contrast
- Device theme (light/dark)
- Component layering

### Gradient algorithm
```
start = lighten(#0F172A, 4%)
end = darken(#1E3A8A, 3%)
angle = 37deg ± 3deg for parallax realism
```

---

# 5. ICONOGRAPHY SPEC

## 5.1 Icon Weights
- Filled icons: for primary actions
- Outlined icons: for secondary actions
- Stroke width: 1.75dp

## 5.2 Touch Areas
- Visual icon: 20–24dp
- Required hitbox: **48dp**

---

# 6. ERROR STATES (ULTRA)

### Empty Search
```
Illustration: 240dp
Title: “No matches”
Message: “Try a different keyword or enable semantic search”
CTA (optional): “Enable semantic search”
```

### Indexing Failure
- Banner: persistent at top
- Height: 56dp
- Icon: danger triangle
- Actions: “Retry Index” / “Details”

---

# 7. SCREEN BLUEPRINT INDEX
All screens in this group have their own ULTRA documents:
- onboarding  
- home_shelf  
- file_detail  
- rule_builder  
- rule_preview  
- search_results  
- settings  
- activity_log  

