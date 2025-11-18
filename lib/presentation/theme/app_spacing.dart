// FILO App Spacing
// Refs: design_tokens_ultra_ultra.md section 5 (Spacing & Layout Matrix)

/// Spacing system for FILO app matching design_tokens_ultra_ultra.md
/// All values in dp (density-independent pixels)
///
/// Rule: "Every FILO screen must align to these exact increments"
class AppSpacing {
  AppSpacing._(); // Private constructor to prevent instantiation

  // SPACING SCALE (design_tokens_ultra_ultra.md section 5)
  // Only use: 2, 4, 6, 8, 12, 16, 24, 32, 48, 64 dp increments

  static const double xs = 2.0;
  static const double sm = 4.0;
  static const double md = 6.0;
  static const double lg = 8.0;
  static const double xl = 12.0;
  static const double xxl = 16.0;
  static const double xxxl = 24.0;
  static const double huge = 32.0;
  static const double massive = 48.0;
  static const double gigantic = 64.0;

  // COMMON PADDING PRESETS
  static const double paddingSmall = lg; // 8dp
  static const double paddingMedium = xxl; // 16dp
  static const double paddingLarge = xxxl; // 24dp

  // COMMON SPACING BETWEEN ELEMENTS
  static const double spaceBetweenCards = xl; // 12dp (per home_shelf_ultra.md)
  static const double spaceBetweenSections =
      xxxl; // 24dp (per home_shelf_ultra.md)
  static const double spaceSmall = lg; // 8dp
  static const double spaceMedium = xxl; // 16dp
  static const double spaceLarge = xxxl; // 24dp
}
