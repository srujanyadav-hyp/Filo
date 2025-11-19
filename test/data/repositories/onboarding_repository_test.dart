// FILO Onboarding Repository Tests
// Per Phase 5 Task 2: Test onboarding persistence

import 'package:flutter_test/flutter_test.dart';
import 'package:filo/data/repositories/onboarding_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('OnboardingRepository Tests', () {
    late OnboardingRepository repository;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      repository = OnboardingRepository();
    });

    test('isOnboardingComplete returns false by default', () async {
      final isComplete = await repository.isOnboardingComplete();
      expect(isComplete, isFalse);
    });

    test('completeOnboarding sets status to true', () async {
      await repository.completeOnboarding();
      final isComplete = await repository.isOnboardingComplete();
      expect(isComplete, isTrue);
    });

    test('isOnboardingComplete persists across instances', () async {
      await repository.completeOnboarding();

      // Create new repository instance
      final newRepository = OnboardingRepository();
      final isComplete = await newRepository.isOnboardingComplete();

      expect(isComplete, isTrue);
    });

    test('resetOnboarding clears completion status', () async {
      await repository.completeOnboarding();
      expect(await repository.isOnboardingComplete(), isTrue);

      await repository.resetOnboarding();
      expect(await repository.isOnboardingComplete(), isFalse);
    });

    test('resetOnboarding on fresh install does not throw', () async {
      expect(() => repository.resetOnboarding(), returnsNormally);
    });

    test('multiple completeOnboarding calls are idempotent', () async {
      await repository.completeOnboarding();
      await repository.completeOnboarding();
      await repository.completeOnboarding();

      final isComplete = await repository.isOnboardingComplete();
      expect(isComplete, isTrue);
    });

    test('completion status persists in SharedPreferences', () async {
      await repository.completeOnboarding();

      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getBool('onboarding_complete');

      expect(stored, isTrue);
    });

    test('reset removes key from SharedPreferences', () async {
      await repository.completeOnboarding();
      await repository.resetOnboarding();

      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getBool('onboarding_complete');

      expect(stored, isNull);
    });
  });
}
