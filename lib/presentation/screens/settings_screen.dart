// FILO Settings Screen
// Per Phase 5 Task 1: Complete settings with 7 sections
// Refs: screens/settings_ultra.md, phase5_plan.md Task 1

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../../data/models/app_settings.dart';
import '../../data/repositories/settings_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Settings Screen
///
/// 7 sections per spec:
/// 1. Account (placeholder)
/// 2. Indexing preferences
/// 3. Search preferences
/// 4. Appearance (theme)
/// 5. Storage management
/// 6. Notifications
/// 7. About & info
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsRepository _repository = SettingsRepository();
  AppSettings _settings = const AppSettings();
  String _appVersion = 'Loading...';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _loadAppVersion();
  }

  Future<void> _loadSettings() async {
    final settings = await _repository.loadSettings();
    setState(() {
      _settings = settings;
      _isLoading = false;
    });
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = '${packageInfo.version}+${packageInfo.buildNumber}';
    });
  }

  Future<void> _updateSettings(AppSettings settings) async {
    await _repository.saveSettings(settings);
    setState(() {
      _settings = settings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Settings'), elevation: 0),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                // Section 1: Account (Placeholder)
                _buildSectionHeader('Account'),
                _buildAccountPlaceholder(),

                SizedBox(height: AppSpacing.spaceBetweenSections),

                // Section 2: Indexing
                _buildSectionHeader('Indexing'),
                _buildAutoIndexTile(),
                _buildIndexScheduleTile(),
                _buildReIndexButton(),

                SizedBox(height: AppSpacing.spaceBetweenSections),

                // Section 3: Search
                _buildSectionHeader('Search'),
                _buildSearchModeTile(),
                _buildClearSearchHistoryTile(),

                SizedBox(height: AppSpacing.spaceBetweenSections),

                // Section 4: Appearance
                _buildSectionHeader('Appearance'),
                _buildThemeModeTile(),

                SizedBox(height: AppSpacing.spaceBetweenSections),

                // Section 5: Storage
                _buildSectionHeader('Storage'),
                _buildStorageInfo(),
                _buildClearCacheTile(),
                _buildClearIndexTile(),

                SizedBox(height: AppSpacing.spaceBetweenSections),

                // Section 6: Notifications
                _buildSectionHeader('Notifications'),
                _buildNotificationsTile(),
                _buildRuleAlertsTile(),

                SizedBox(height: AppSpacing.spaceBetweenSections),

                // Section 7: About
                _buildSectionHeader('About'),
                _buildVersionTile(),
                _buildLicensesTile(),
                _buildPrivacyPolicyTile(),
                _buildTermsOfServiceTile(),

                SizedBox(height: AppSpacing.xxxl),
              ],
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingMedium,
        vertical: AppSpacing.paddingSmall,
      ),
      child: Text(
        title,
        style: AppTypography.headingS.copyWith(color: AppColors.accentTeal500),
      ),
    );
  }

  // Section 1: Account
  Widget _buildAccountPlaceholder() {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: const Text('Sign in to sync'),
      subtitle: const Text('Coming soon'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account sync coming in future update')),
        );
      },
    );
  }

  // Section 2: Indexing
  Widget _buildAutoIndexTile() {
    return SwitchListTile(
      title: const Text('Auto-index files'),
      subtitle: const Text('Automatically index new files'),
      value: _settings.autoIndexEnabled,
      onChanged: (value) {
        _updateSettings(_settings.copyWith(autoIndexEnabled: value));
      },
      secondary: const Icon(Icons.auto_awesome),
    );
  }

  Widget _buildIndexScheduleTile() {
    return ListTile(
      leading: const Icon(Icons.schedule),
      title: const Text('Index schedule'),
      subtitle: Text(_formatSchedule(_settings.indexSchedule)),
      trailing: const Icon(Icons.arrow_drop_down),
      onTap: () => _showSchedulePicker(),
    );
  }

  String _formatSchedule(String schedule) {
    switch (schedule) {
      case 'manual':
        return 'Manual only';
      case 'daily':
        return 'Daily at midnight';
      case 'weekly':
        return 'Weekly on Sunday';
      default:
        return 'Manual only';
    }
  }

  Future<void> _showSchedulePicker() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Index Schedule'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Manual only'),
              value: 'manual',
              groupValue: _settings.indexSchedule,
              onChanged: (value) => Navigator.pop(context, value),
            ),
            RadioListTile<String>(
              title: const Text('Daily at midnight'),
              value: 'daily',
              groupValue: _settings.indexSchedule,
              onChanged: (value) => Navigator.pop(context, value),
            ),
            RadioListTile<String>(
              title: const Text('Weekly on Sunday'),
              value: 'weekly',
              groupValue: _settings.indexSchedule,
              onChanged: (value) => Navigator.pop(context, value),
            ),
          ],
        ),
      ),
    );

    if (selected != null) {
      _updateSettings(_settings.copyWith(indexSchedule: selected));
    }
  }

  Widget _buildReIndexButton() {
    return ListTile(
      leading: const Icon(Icons.refresh),
      title: const Text('Re-index all files'),
      subtitle: const Text('Rebuild the entire file index'),
      onTap: () => _confirmReIndex(),
    );
  }

  Future<void> _confirmReIndex() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Re-index All Files?'),
        content: const Text(
          'This will rebuild the entire file index. This may take several minutes.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Re-index'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Re-indexing started...')));
      // TODO: Integrate with FileIndexingService
    }
  }

  // Section 3: Search
  Widget _buildSearchModeTile() {
    return ListTile(
      leading: const Icon(Icons.search),
      title: const Text('Default search mode'),
      subtitle: Text(_formatSearchMode(_settings.defaultSearchMode)),
      trailing: const Icon(Icons.arrow_drop_down),
      onTap: () => _showSearchModePicker(),
    );
  }

  String _formatSearchMode(String mode) {
    switch (mode) {
      case 'text':
        return 'Text search (fastest)';
      case 'visual':
        return 'Visual search (AI-powered)';
      case 'semantic':
        return 'Semantic search (most accurate)';
      default:
        return 'Text search';
    }
  }

  Future<void> _showSearchModePicker() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Default Search Mode'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Text search'),
              subtitle: const Text('Fastest, keyword-based'),
              value: 'text',
              groupValue: _settings.defaultSearchMode,
              onChanged: (value) => Navigator.pop(context, value),
            ),
            RadioListTile<String>(
              title: const Text('Visual search'),
              subtitle: const Text('AI-powered image recognition'),
              value: 'visual',
              groupValue: _settings.defaultSearchMode,
              onChanged: (value) => Navigator.pop(context, value),
            ),
            RadioListTile<String>(
              title: const Text('Semantic search'),
              subtitle: const Text('Natural language understanding'),
              value: 'semantic',
              groupValue: _settings.defaultSearchMode,
              onChanged: (value) => Navigator.pop(context, value),
            ),
          ],
        ),
      ),
    );

    if (selected != null) {
      _updateSettings(_settings.copyWith(defaultSearchMode: selected));
    }
  }

  Widget _buildClearSearchHistoryTile() {
    return ListTile(
      leading: const Icon(Icons.history),
      title: const Text('Clear search history'),
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Search history cleared')));
        // TODO: Implement search history clearing
      },
    );
  }

  // Section 4: Appearance
  Widget _buildThemeModeTile() {
    return ListTile(
      leading: const Icon(Icons.palette),
      title: const Text('Theme'),
      subtitle: Text(_formatThemeMode(_settings.themeMode)),
      trailing: const Icon(Icons.arrow_drop_down),
      onTap: () => _showThemePicker(),
    );
  }

  String _formatThemeMode(String mode) {
    switch (mode) {
      case 'light':
        return 'Light';
      case 'dark':
        return 'Dark';
      case 'system':
        return 'System default';
      default:
        return 'System default';
    }
  }

  Future<void> _showThemePicker() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Light'),
              value: 'light',
              groupValue: _settings.themeMode,
              onChanged: (value) => Navigator.pop(context, value),
            ),
            RadioListTile<String>(
              title: const Text('Dark'),
              value: 'dark',
              groupValue: _settings.themeMode,
              onChanged: (value) => Navigator.pop(context, value),
            ),
            RadioListTile<String>(
              title: const Text('System default'),
              value: 'system',
              groupValue: _settings.themeMode,
              onChanged: (value) => Navigator.pop(context, value),
            ),
          ],
        ),
      ),
    );

    if (selected != null) {
      _updateSettings(_settings.copyWith(themeMode: selected));
      // TODO: Apply theme change immediately
    }
  }

  // Section 5: Storage
  Widget _buildStorageInfo() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.storage),
          title: const Text('Cache size'),
          subtitle: Text('${_settings.cacheSizeMB} MB'),
        ),
        ListTile(
          leading: const Icon(Icons.folder),
          title: const Text('Indexed files'),
          subtitle: Text('${_settings.indexedFilesCount} files'),
        ),
      ],
    );
  }

  Widget _buildClearCacheTile() {
    return ListTile(
      leading: const Icon(Icons.cleaning_services),
      title: const Text('Clear cache'),
      onTap: () => _confirmClearCache(),
    );
  }

  Future<void> _confirmClearCache() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache?'),
        content: const Text('This will free up storage space.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Cache cleared')));
      // TODO: Implement cache clearing
    }
  }

  Widget _buildClearIndexTile() {
    return ListTile(
      leading: const Icon(Icons.delete_forever),
      title: const Text('Clear index'),
      subtitle: const Text('Remove all indexed data'),
      onTap: () => _confirmClearIndex(),
    );
  }

  Future<void> _confirmClearIndex() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Index?'),
        content: const Text(
          'This will remove all indexed file data. You will need to re-index your files.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Index cleared')));
      // TODO: Implement index clearing
    }
  }

  // Section 6: Notifications
  Widget _buildNotificationsTile() {
    return SwitchListTile(
      title: const Text('Enable notifications'),
      subtitle: const Text('Receive app notifications'),
      value: _settings.notificationsEnabled,
      onChanged: (value) {
        _updateSettings(_settings.copyWith(notificationsEnabled: value));
      },
      secondary: const Icon(Icons.notifications),
    );
  }

  Widget _buildRuleAlertsTile() {
    return SwitchListTile(
      title: const Text('Rule execution alerts'),
      subtitle: const Text('Notify when rules are executed'),
      value: _settings.ruleAlertsEnabled,
      onChanged: (value) {
        _updateSettings(_settings.copyWith(ruleAlertsEnabled: value));
      },
      secondary: const Icon(Icons.rule),
    );
  }

  // Section 7: About
  Widget _buildVersionTile() {
    return ListTile(
      leading: const Icon(Icons.info),
      title: const Text('App version'),
      subtitle: Text(_appVersion),
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: _appVersion));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Version copied to clipboard')),
        );
      },
    );
  }

  Widget _buildLicensesTile() {
    return ListTile(
      leading: const Icon(Icons.article),
      title: const Text('Open source licenses'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        showLicensePage(
          context: context,
          applicationName: 'FILO',
          applicationVersion: _appVersion,
        );
      },
    );
  }

  Widget _buildPrivacyPolicyTile() {
    return ListTile(
      leading: const Icon(Icons.privacy_tip),
      title: const Text('Privacy policy'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Privacy policy coming soon')),
        );
        // TODO: Open privacy policy URL
      },
    );
  }

  Widget _buildTermsOfServiceTile() {
    return ListTile(
      leading: const Icon(Icons.description),
      title: const Text('Terms of service'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Terms of service coming soon')),
        );
        // TODO: Open terms of service URL
      },
    );
  }
}
