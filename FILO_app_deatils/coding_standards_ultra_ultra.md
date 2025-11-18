
# FILO — ULTRA–ULTRA EXPANDED CODING STANDARDS

This is the enforced coding rulebook for FILO.

---

# 1. DART STANDARDS

## 1.1 Naming
- Classes: `PascalCase`
- Variables: `camelCase`
- Constants: `SCREAMING_CASE`
- Private members: `_underscorePrefix`

## 1.2 Prohibited
- Dynamic types
- Untyped JSON
- Non-final model fields
- Fat widgets (>200 LOC)
- Business logic in Widgets

---

# 2. FLUTTER STANDARDS

### Widgets must:
- Be pure functions when possible
- Never include side effects
- Never mutate state directly
- Use Riverpod for state management

### Layout rules:
- Padding multiples: 4, 8, 12, 16, 24
- No layout magic numbers

---

# 3. KOTLIN STANDARDS

### Required:
- All functions must be explicit about return types
- All async operations inside coroutines
- No blocking calls on main thread
- SAF operations wrapped with retry logic

### Naming conventions:
- Plugins: `Filo<FileType>Plugin`
- Workers: `Filo<FileType>Worker`

---

# 4. DATABASE (DRIFT) STANDARDS

### Mandatory Policy:
- Every column must specify:
  - type
  - nullability
  - index
  - default
  - constraint

### No raw SQL unless absolutely needed.

---

# 5. COMMENTING POLICY

### Allowed:
- Explaining complex logic
- Documenting rule engine behavior
- Constraints & limitations

### Not Allowed:
- Obvious comments like:  
  `// this increments x`  
