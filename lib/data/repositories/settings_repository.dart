// FILO Settings Repository
// Per Phase 5 Task 1: Settings persistence with SharedPreferences

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_settings.dart';

class SettingsRepository {
  static const String _settingsKey = 'app_settings';

  Future<AppSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsJson = prefs.getString(_settingsKey);

    if (settingsJson == null) {
      return const AppSettings(); // Return defaults
    }

    try {
      final map = json.decode(settingsJson) as Map<String, dynamic>;
      return AppSettings.fromJson(map);
    } catch (e) {
      // If parsing fails, return defaults
      return const AppSettings();
    }
  }

  Future<void> saveSettings(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    final settingsJson = json.encode(settings.toJson());
    await prefs.setString(_settingsKey, settingsJson);
  }

  Future<void> updateAutoIndex(bool enabled) async {
    final settings = await loadSettings();
    final updated = settings.copyWith(autoIndexEnabled: enabled);
    await saveSettings(updated);
  }

  Future<void> updateIndexSchedule(String schedule) async {
    final settings = await loadSettings();
    final updated = settings.copyWith(indexSchedule: schedule);
    await saveSettings(updated);
  }

  Future<void> updateDefaultSearchMode(String mode) async {
    final settings = await loadSettings();
    final updated = settings.copyWith(defaultSearchMode: mode);
    await saveSettings(updated);
  }

  Future<void> updateThemeMode(String mode) async {
    final settings = await loadSettings();
    final updated = settings.copyWith(themeMode: mode);
    await saveSettings(updated);
  }

  Future<void> updateNotifications(bool enabled) async {
    final settings = await loadSettings();
    final updated = settings.copyWith(notificationsEnabled: enabled);
    await saveSettings(updated);
  }

  Future<void> updateRuleAlerts(bool enabled) async {
    final settings = await loadSettings();
    final updated = settings.copyWith(ruleAlertsEnabled: enabled);
    await saveSettings(updated);
  }

  Future<void> clearSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_settingsKey);
  }
}
