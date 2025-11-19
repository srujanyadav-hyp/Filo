// FILO App Colors
// Refs: design_tokens_ultra_ultra.md (full file)

import 'package:flutter/material.dart';

/// Complete color system for FILO app matching design_tokens_ultra_ultra.md
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // PRIMARY COLORS (design_tokens_ultra_ultra.md section 1.1)
  /// #0A0F1F — Deep background, dark mode
  static const Color primary900 = Color(0xFF0A0F1F);

  /// #0F172A — Card container backdrop
  static const Color primary800 = Color(0xFF0F172A);

  /// #152240 — Gradient bottom
  static const Color primary700 = Color(0xFF152240);

  /// #1E3A8A — Gradient highlight
  static const Color primary600 = Color(0xFF1E3A8A);

  // ACCENT COLORS (design_tokens_ultra_ultra.md section 1.2)
  /// #06B6D4 — Primary action (teal)
  static const Color accentTeal500 = Color(0xFF06B6D4);

  /// #5EEBF7 — Highlights (light teal)
  static const Color accentTeal300 = Color(0xFF5EEBF7);

  // SEMANTIC COLORS (inferred from common UI patterns)
  /// Error/destructive actions
  static const Color error = Color(0xFFEF4444);

  /// Success states
  static const Color success = Color(0xFF10B981);

  /// Warning states
  static const Color warning = Color(0xFFF59E0B);

  /// Info states
  static const Color info = accentTeal500;

  // SURFACE COLORS (derived from primary palette)
  /// Deepest background (primary900)
  static const Color background = primary900;

  /// Card surfaces (primary800)
  static const Color surface = primary800;

  /// Elevated surfaces (primary700)
  static const Color surfaceElevated = primary700;

  // TEXT COLORS
  /// Primary text on dark backgrounds
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Secondary/muted text
  static const Color textSecondary = Color(0xFFCBD5E1);

  /// Disabled text
  static const Color textDisabled = Color(0xFF64748B);

  /// Border color for dividers and outlines
  static const Color border = Color(0xFF334155);

  // GRADIENT COLORS (design_tokens_ultra_ultra.md section 4)
  /// Gradient start: #0F172A with +4% brightness
  static const Color gradientStart = Color(0xFF131C33);

  /// Gradient end: #1E3A8A with -3% brightness
  static const Color gradientEnd = Color(0xFF1C3780);
}
