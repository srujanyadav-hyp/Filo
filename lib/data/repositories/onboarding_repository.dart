// FILO Onboarding Repository
// Per Phase 5 Task 2: Track first-run status

import 'package:shared_preferences/shared_preferences.dart';

/// Repository for onboarding state management
///
/// Tracks whether user has completed onboarding flow.
/// Uses SharedPreferences for persistence.
class OnboardingRepository {
  static const String _onboardingCompleteKey = 'onboarding_complete';

  /// Check if user has completed onboarding
  Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompleteKey) ?? false;
  }

  /// Mark onboarding as complete
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompleteKey, true);
  }

  /// Reset onboarding status (for testing)
  Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_onboardingCompleteKey);
  }
}
