
# FILO — ANIMATION SYSTEM (ULTRA–ULTRA EXPANDED)

This file contains:
- motion laws
- timing curves
- animation tokens
- physics equations
- sequencing guidelines

---

# 1. MOTION LAW

## 1.1 No abrupt jumps
Any movement > 2dp must be animated.

## 1.2 Timing physics
```
springForce = -k * displacement
dampingForce = -c * velocity
combined = springForce + dampingForce
```

k = 180  
c = 0.78  

Equivalent to Flutter’s:
```
SpringType.criticallyDamped
```

---

# 2. TRANSITIONS — ULTRA DETAIL

### File Card Entry
- alpha: 0 →1 over 220ms
- translateY: 12 → 0dp
- stagger: 40ms per item

### FAB
- start scale: 0.92
- end scale: 1.00
- curve: easeOutCubic

---

# 3. INTERACTIVE MOTION

### Long Press Ripple
- radius: 24dp → 88dp
- opacity: 0.15 → 0
- duration: 260ms

