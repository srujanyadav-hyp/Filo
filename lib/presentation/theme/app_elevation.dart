// FILO App Elevation
// Refs: design_tokens_ultra_ultra.md section 3 (Elevation System)

import 'package:flutter/material.dart';

/// Elevation system for FILO app matching design_tokens_ultra_ultra.md
class AppElevation {
  AppElevation._(); // Private constructor to prevent instantiation

  // ELEVATION LEVELS (design_tokens_ultra_ultra.md section 3)
  // Format: | Level | y-offset | blur | opacity |

  /// Level 1: elevation 1dp, shadow rgba(0,0,0,0.12)
  /// y-offset: 2, blur: 4, opacity: 10%
  static const double low = 1.0;
  static BoxShadow get shadowLow => BoxShadow(
    color: Colors.black.withOpacity(0.10),
    offset: const Offset(0, 2),
    blurRadius: 4,
  );

  /// Level 2: elevation 3dp, shadow rgba(0,0,0,0.16)
  /// y-offset: 6, blur: 12, opacity: 14%
  static const double medium = 3.0;
  static BoxShadow get shadowMedium => BoxShadow(
    color: Colors.black.withOpacity(0.14),
    offset: const Offset(0, 6),
    blurRadius: 12,
  );

  /// Level 3: elevation 6dp, shadow rgba(0,0,0,0.20)
  /// y-offset: 12, blur: 24, opacity: 18%
  static const double high = 6.0;
  static BoxShadow get shadowHigh => BoxShadow(
    color: Colors.black.withOpacity(0.18),
    offset: const Offset(0, 12),
    blurRadius: 24,
  );

  /// Level 4: elevation 8dp, shadow rgba(0,0,0,0.24)
  /// y-offset: 18, blur: 30, opacity: 25%
  static const double splash = 8.0;
  static BoxShadow get shadowSplash => BoxShadow(
    color: Colors.black.withOpacity(0.25),
    offset: const Offset(0, 18),
    blurRadius: 30,
  );

  // BOXDECORATION PRESETS

  /// BoxDecoration with low elevation shadow
  static BoxDecoration get decorationLow =>
      BoxDecoration(boxShadow: [shadowLow]);

  /// BoxDecoration with medium elevation shadow
  static BoxDecoration get decorationMedium =>
      BoxDecoration(boxShadow: [shadowMedium]);

  /// BoxDecoration with high elevation shadow
  static BoxDecoration get decorationHigh =>
      BoxDecoration(boxShadow: [shadowHigh]);

  /// BoxDecoration with splash elevation shadow
  static BoxDecoration get decorationSplash =>
      BoxDecoration(boxShadow: [shadowSplash]);
}
