// FILO Settings Repository Tests
// Per Phase 5 Task 1: Test settings persistence

import 'package:flutter_test/flutter_test.dart';
import 'package:filo/data/models/app_settings.dart';
import 'package:filo/data/repositories/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('SettingsRepository Tests', () {
    late SettingsRepository repository;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      repository = SettingsRepository();
    });

    test('loadSettings returns defaults when no data exists', () async {
      final settings = await repository.loadSettings();

      expect(settings.autoIndexEnabled, isTrue);
      expect(settings.indexSchedule, equals('manual'));
      expect(settings.defaultSearchMode, equals('text'));
      expect(settings.themeMode, equals('system'));
      expect(settings.notificationsEnabled, isFalse);
      expect(settings.ruleAlertsEnabled, isFalse);
      expect(settings.cacheSizeMB, equals(0));
      expect(settings.indexedFilesCount, equals(0));
    });

    test('saveSettings persists data to SharedPreferences', () async {
      const settings = AppSettings(
        autoIndexEnabled: false,
        indexSchedule: 'daily',
        defaultSearchMode: 'semantic',
        themeMode: 'dark',
        notificationsEnabled: true,
        ruleAlertsEnabled: true,
      );

      await repository.saveSettings(settings);

      final prefs = await SharedPreferences.getInstance();
      final savedData = prefs.getString('app_settings');
      expect(savedData, isNotNull);
      expect(savedData, contains('daily'));
      expect(savedData, contains('semantic'));
      expect(savedData, contains('dark'));
    });

    test('loadSettings retrieves saved data', () async {
      const settings = AppSettings(
        autoIndexEnabled: false,
        indexSchedule: 'weekly',
        defaultSearchMode: 'visual',
        themeMode: 'light',
      );

      await repository.saveSettings(settings);
      final loaded = await repository.loadSettings();

      expect(loaded.autoIndexEnabled, isFalse);
      expect(loaded.indexSchedule, equals('weekly'));
      expect(loaded.defaultSearchMode, equals('visual'));
      expect(loaded.themeMode, equals('light'));
    });

    test('updateAutoIndex modifies only autoIndexEnabled', () async {
      await repository.saveSettings(
        const AppSettings(autoIndexEnabled: true, indexSchedule: 'daily'),
      );

      await repository.updateAutoIndex(false);
      final updated = await repository.loadSettings();

      expect(updated.autoIndexEnabled, isFalse);
      expect(updated.indexSchedule, equals('daily')); // unchanged
    });

    test('updateIndexSchedule modifies only indexSchedule', () async {
      await repository.saveSettings(
        const AppSettings(autoIndexEnabled: true, indexSchedule: 'manual'),
      );

      await repository.updateIndexSchedule('weekly');
      final updated = await repository.loadSettings();

      expect(updated.indexSchedule, equals('weekly'));
      expect(updated.autoIndexEnabled, isTrue); // unchanged
    });

    test('updateDefaultSearchMode modifies only searchMode', () async {
      await repository.saveSettings(
        const AppSettings(defaultSearchMode: 'text', themeMode: 'system'),
      );

      await repository.updateDefaultSearchMode('semantic');
      final updated = await repository.loadSettings();

      expect(updated.defaultSearchMode, equals('semantic'));
      expect(updated.themeMode, equals('system')); // unchanged
    });

    test('updateThemeMode modifies only themeMode', () async {
      await repository.saveSettings(
        const AppSettings(themeMode: 'system', defaultSearchMode: 'text'),
      );

      await repository.updateThemeMode('dark');
      final updated = await repository.loadSettings();

      expect(updated.themeMode, equals('dark'));
      expect(updated.defaultSearchMode, equals('text')); // unchanged
    });

    test('updateNotifications modifies only notificationsEnabled', () async {
      await repository.saveSettings(
        const AppSettings(
          notificationsEnabled: false,
          ruleAlertsEnabled: false,
        ),
      );

      await repository.updateNotifications(true);
      final updated = await repository.loadSettings();

      expect(updated.notificationsEnabled, isTrue);
      expect(updated.ruleAlertsEnabled, isFalse); // unchanged
    });

    test('updateRuleAlerts modifies only ruleAlertsEnabled', () async {
      await repository.saveSettings(
        const AppSettings(notificationsEnabled: true, ruleAlertsEnabled: false),
      );

      await repository.updateRuleAlerts(true);
      final updated = await repository.loadSettings();

      expect(updated.ruleAlertsEnabled, isTrue);
      expect(updated.notificationsEnabled, isTrue); // unchanged
    });

    test('clearSettings removes all data', () async {
      await repository.saveSettings(
        const AppSettings(autoIndexEnabled: false, indexSchedule: 'daily'),
      );

      await repository.clearSettings();

      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('app_settings');
      expect(data, isNull);
    });

    test('loadSettings returns defaults after clearSettings', () async {
      await repository.saveSettings(
        const AppSettings(autoIndexEnabled: false, indexSchedule: 'daily'),
      );

      await repository.clearSettings();
      final loaded = await repository.loadSettings();

      expect(loaded.autoIndexEnabled, isTrue); // default
      expect(loaded.indexSchedule, equals('manual')); // default
    });

    test('multiple updates preserve previous changes', () async {
      await repository.updateAutoIndex(false);
      await repository.updateIndexSchedule('daily');
      await repository.updateDefaultSearchMode('semantic');
      await repository.updateThemeMode('dark');
      await repository.updateNotifications(true);
      await repository.updateRuleAlerts(true);

      final settings = await repository.loadSettings();

      expect(settings.autoIndexEnabled, isFalse);
      expect(settings.indexSchedule, equals('daily'));
      expect(settings.defaultSearchMode, equals('semantic'));
      expect(settings.themeMode, equals('dark'));
      expect(settings.notificationsEnabled, isTrue);
      expect(settings.ruleAlertsEnabled, isTrue);
    });

    test('handles invalid JSON gracefully', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('app_settings', 'invalid json{{{');

      final settings = await repository.loadSettings();

      // Should return defaults on error
      expect(settings.autoIndexEnabled, isTrue);
      expect(settings.indexSchedule, equals('manual'));
    });

    test('JSON serialization round-trip preserves data', () async {
      const original = AppSettings(
        autoIndexEnabled: false,
        indexSchedule: 'weekly',
        defaultSearchMode: 'visual',
        themeMode: 'light',
        notificationsEnabled: true,
        ruleAlertsEnabled: true,
        cacheSizeMB: 42,
        indexedFilesCount: 123,
      );

      await repository.saveSettings(original);
      final loaded = await repository.loadSettings();

      expect(loaded.autoIndexEnabled, equals(original.autoIndexEnabled));
      expect(loaded.indexSchedule, equals(original.indexSchedule));
      expect(loaded.defaultSearchMode, equals(original.defaultSearchMode));
      expect(loaded.themeMode, equals(original.themeMode));
      expect(
        loaded.notificationsEnabled,
        equals(original.notificationsEnabled),
      );
      expect(loaded.ruleAlertsEnabled, equals(original.ruleAlertsEnabled));
      expect(loaded.cacheSizeMB, equals(original.cacheSizeMB));
      expect(loaded.indexedFilesCount, equals(original.indexedFilesCount));
    });
  });
}
