// FILO Settings Data Model
// Per Phase 5 Task 1: App settings with SharedPreferences persistence

class AppSettings {
  // Indexing preferences
  final bool autoIndexEnabled;
  final String indexSchedule; // 'manual', 'daily', 'weekly'

  // Search preferences
  final String defaultSearchMode; // 'text', 'visual', 'semantic'

  // Appearance
  final String themeMode; // 'light', 'dark', 'system'

  // Notifications
  final bool notificationsEnabled;
  final bool ruleAlertsEnabled;

  // Storage stats (read-only)
  final int cacheSizeMB;
  final int indexedFilesCount;

  const AppSettings({
    this.autoIndexEnabled = true,
    this.indexSchedule = 'manual',
    this.defaultSearchMode = 'text',
    this.themeMode = 'system',
    this.notificationsEnabled = true,
    this.ruleAlertsEnabled = true,
    this.cacheSizeMB = 0,
    this.indexedFilesCount = 0,
  });

  AppSettings copyWith({
    bool? autoIndexEnabled,
    String? indexSchedule,
    String? defaultSearchMode,
    String? themeMode,
    bool? notificationsEnabled,
    bool? ruleAlertsEnabled,
    int? cacheSizeMB,
    int? indexedFilesCount,
  }) {
    return AppSettings(
      autoIndexEnabled: autoIndexEnabled ?? this.autoIndexEnabled,
      indexSchedule: indexSchedule ?? this.indexSchedule,
      defaultSearchMode: defaultSearchMode ?? this.defaultSearchMode,
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      ruleAlertsEnabled: ruleAlertsEnabled ?? this.ruleAlertsEnabled,
      cacheSizeMB: cacheSizeMB ?? this.cacheSizeMB,
      indexedFilesCount: indexedFilesCount ?? this.indexedFilesCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'autoIndexEnabled': autoIndexEnabled,
      'indexSchedule': indexSchedule,
      'defaultSearchMode': defaultSearchMode,
      'themeMode': themeMode,
      'notificationsEnabled': notificationsEnabled,
      'ruleAlertsEnabled': ruleAlertsEnabled,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      autoIndexEnabled: json['autoIndexEnabled'] as bool? ?? true,
      indexSchedule: json['indexSchedule'] as String? ?? 'manual',
      defaultSearchMode: json['defaultSearchMode'] as String? ?? 'text',
      themeMode: json['themeMode'] as String? ?? 'system',
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      ruleAlertsEnabled: json['ruleAlertsEnabled'] as bool? ?? true,
    );
  }
}
