// FILO Rule Builder Screen
// Refs: feature_specs_ultra.md lines 39-70, interaction_flow_ultra_ultra.md lines 33-40

import 'package:flutter/material.dart';
import '../../core/rules/rule_engine.dart';
import '../../core/rules/rule_parser.dart';
import '../../data/models/rule_model.dart';
import '../../data/models/condition_model.dart';
import '../../data/models/action_model.dart';
import '../../data/db/database.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/condition_builder_widget.dart';
import '../widgets/action_editor_widget.dart';
import '../widgets/rule_preview_widget.dart';

/// Rule Builder Screen
///
/// Allows users to create automation rules via:
/// - Manual path: Add conditions + actions
/// - AI-assisted path: Natural language → generated rule
///
/// Per feature_specs_ultra.md:
/// - Validation layers: Schema, Safety check, Preview
/// - Safety classes: low, medium, high
/// - Stepper height: 40dp
class RuleBuilderScreen extends StatefulWidget {
  final FiloDatabase database;
  final RuleModel? existingRule; // For editing existing rules

  const RuleBuilderScreen({
    super.key,
    required this.database,
    this.existingRule,
  });

  @override
  State<RuleBuilderScreen> createState() => _RuleBuilderScreenState();
}

class _RuleBuilderScreenState extends State<RuleBuilderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late RuleEngine _ruleEngine;

  // Manual rule building state
  String _ruleName = '';
  String _triggerType = 'file_added'; // Default trigger
  final List<ConditionModel> _conditions = [];
  final List<ActionModel> _actions = [];

  // AI-assisted state
  final TextEditingController _aiPromptController = TextEditingController();
  String? _generatedRuleJson;
  RuleModel? _previewRule;
  String? _validationError;
  String? _safetyWarning;

  // Preview state
  bool _showPreview = false;
  List<String> _previewResults = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _ruleEngine = RuleEngine(widget.database);

    // Load existing rule if editing
    if (widget.existingRule != null) {
      _loadExistingRule(widget.existingRule!);
    }
  }

  void _loadExistingRule(RuleModel rule) {
    setState(() {
      _ruleName =
          rule.id; // Using id as name since RuleModel has no name property
      _triggerType = rule.trigger.type;
      _conditions.clear();
      // Conditions are at rule level, not trigger level
      if (rule.conditions.isNotEmpty) {
        _conditions.addAll(rule.conditions.first.conditions);
      }
      _actions.clear();
      _actions.addAll(rule.actions);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _aiPromptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.existingRule != null ? 'Edit Rule' : 'Create Rule'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Manual', icon: Icon(Icons.build_outlined)),
            Tab(text: 'AI Assisted', icon: Icon(Icons.auto_awesome)),
          ],
        ),
        actions: [
          // Save button
          TextButton.icon(
            onPressed: _canSave() ? _saveRule : null,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save'),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildManualBuilder(), _buildAIBuilder()],
      ),
    );
  }

  /// Manual rule builder UI
  Widget _buildManualBuilder() {
    return Row(
      children: [
        // Left side: Rule configuration
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppSpacing.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rule name input
                _buildRuleNameField(),
                SizedBox(height: AppSpacing.spaceBetweenSections),

                // Trigger section
                _buildTriggerSection(),
                SizedBox(height: AppSpacing.spaceBetweenSections),

                // Conditions section
                _buildConditionsSection(),
                SizedBox(height: AppSpacing.spaceBetweenSections),

                // Actions section
                _buildActionsSection(),
                SizedBox(height: AppSpacing.spaceBetweenSections),

                // Safety indicator
                _buildSafetyIndicator(),
              ],
            ),
          ),
        ),

        // Divider
        const VerticalDivider(width: 1),

        // Right side: Preview panel
        Expanded(flex: 2, child: _buildPreviewPanel()),
      ],
    );
  }

  /// AI-assisted rule builder UI
  Widget _buildAIBuilder() {
    return Column(
      children: [
        // AI prompt input
        Padding(
          padding: EdgeInsets.all(AppSpacing.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Describe your automation rule',
                style: AppTypography.headingS,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _aiPromptController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText:
                      'e.g., "Move all PDF files from Downloads to Documents folder"',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: AppColors.surface,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _generateAIRule,
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Generate Rule'),
              ),
            ],
          ),
        ),

        // Generated rule display
        if (_generatedRuleJson != null) ...[
          const Divider(),
          Expanded(
            child: Row(
              children: [
                // Generated JSON
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(AppSpacing.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Generated Rule', style: AppTypography.headingS),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: SelectableText(
                            _generatedRuleJson!,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalDivider(width: 1),
                // Preview
                Expanded(flex: 1, child: _buildPreviewPanel()),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRuleNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rule Name', style: AppTypography.headingS),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: 'e.g., Organize Documents',
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: AppColors.surface,
          ),
          onChanged: (value) => setState(() => _ruleName = value),
        ),
      ],
    );
  }

  Widget _buildTriggerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trigger', style: AppTypography.headingS),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _triggerType,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: AppColors.surface,
          ),
          items: const [
            DropdownMenuItem(value: 'file_added', child: Text('File Added')),
            DropdownMenuItem(
              value: 'file_modified',
              child: Text('File Modified'),
            ),
            DropdownMenuItem(value: 'manual', child: Text('Manual Trigger')),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() => _triggerType = value);
            }
          },
        ),
      ],
    );
  }

  Widget _buildConditionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Conditions', style: AppTypography.headingS),
            TextButton.icon(
              onPressed: _addCondition,
              icon: const Icon(Icons.add),
              label: const Text('Add Condition'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_conditions.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.border,
                style: BorderStyle.solid,
              ),
            ),
            child: const Center(child: Text('No conditions added yet')),
          )
        else
          ..._conditions.asMap().entries.map((entry) {
            return ConditionBuilderWidget(
              condition: entry.value,
              onUpdate: (updated) => _updateCondition(entry.key, updated),
              onDelete: () => _deleteCondition(entry.key),
            );
          }),
      ],
    );
  }

  Widget _buildActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Actions', style: AppTypography.headingS),
            TextButton.icon(
              onPressed: _addAction,
              icon: const Icon(Icons.add),
              label: const Text('Add Action'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_actions.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(child: Text('No actions added yet')),
          )
        else
          ..._actions.asMap().entries.map((entry) {
            return ActionEditorWidget(
              action: entry.value,
              onUpdate: (updated) => _updateAction(entry.key, updated),
              onDelete: () => _deleteAction(entry.key),
            );
          }),
      ],
    );
  }

  Widget _buildSafetyIndicator() {
    final safetyClass = _calculateSafetyClass();
    final color = _getSafetyColor(safetyClass);
    final icon = _getSafetyIcon(safetyClass);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Safety: ${safetyClass.toUpperCase()}',
                  style: AppTypography.bodyM.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_safetyWarning != null) ...[
                  const SizedBox(height: 4),
                  Text(_safetyWarning!, style: AppTypography.bodySM),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewPanel() {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.all(AppSpacing.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Preview', style: AppTypography.headingS),
              ElevatedButton.icon(
                onPressed: _runPreview,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Test'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _previewRule != null
                ? RulePreviewWidget(
                    rule: _previewRule!,
                    previewResults: _previewResults,
                  )
                : const Center(child: Text('Configure rule to see preview')),
          ),
        ],
      ),
    );
  }

  // Helper methods

  void _addCondition() {
    setState(() {
      _conditions.add(
        ConditionModel(type: 'filename_regex', operator: 'contains', value: ''),
      );
    });
  }

  void _updateCondition(int index, ConditionModel updated) {
    setState(() {
      _conditions[index] = updated;
      _validateRule();
    });
  }

  void _deleteCondition(int index) {
    setState(() {
      _conditions.removeAt(index);
      _validateRule();
    });
  }

  void _addAction() {
    setState(() {
      _actions.add(ActionModel(type: 'move', params: {}));
    });
  }

  void _updateAction(int index, ActionModel updated) {
    setState(() {
      _actions[index] = updated;
      _validateRule();
    });
  }

  void _deleteAction(int index) {
    setState(() {
      _actions.removeAt(index);
      _validateRule();
    });
  }

  void _validateRule() {
    // Build current rule and validate
    if (_conditions.isEmpty || _actions.isEmpty) {
      setState(() {
        _validationError = null;
        _previewRule = null;
      });
      return;
    }

    try {
      final rule = _buildCurrentRule();
      // TODO: Add validation logic from F8
      setState(() {
        _validationError = null;
        _previewRule = rule;
      });
    } catch (e) {
      setState(() {
        _validationError = e.toString();
        _previewRule = null;
      });
    }
  }

  RuleModel _buildCurrentRule() {
    return RuleModel(
      id:
          widget.existingRule?.id ??
          'rule_${DateTime.now().millisecondsSinceEpoch}',
      trigger: RuleTrigger(type: _triggerType),
      conditions: [ConditionGroup(operator: 'AND', conditions: _conditions)],
      actions: _actions,
      metadata: RuleMetadata(
        createdAt: DateTime.now(),
        createdBy: 'manual',
        safetyClass: _calculateSafetyClass(),
      ),
    );
  }

  String _calculateSafetyClass() {
    // Calculate based on actions
    final hasMove = _actions.any((a) => a.type == 'move');
    final hasRename = _actions.any((a) => a.type == 'rename');
    final hasMultipleActions = _actions.length > 2;

    if (hasMove && hasMultipleActions) {
      _safetyWarning = 'This rule will move files and perform multiple actions';
      return 'high';
    } else if (hasMove || hasRename) {
      _safetyWarning = 'This rule will modify files';
      return 'medium';
    } else {
      _safetyWarning = null;
      return 'low';
    }
  }

  Color _getSafetyColor(String safetyClass) {
    switch (safetyClass) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
      default:
        return Colors.green;
    }
  }

  IconData _getSafetyIcon(String safetyClass) {
    switch (safetyClass) {
      case 'high':
        return Icons.warning;
      case 'medium':
        return Icons.info_outline;
      case 'low':
      default:
        return Icons.check_circle_outline;
    }
  }

  bool _canSave() {
    return _ruleName.isNotEmpty &&
        _conditions.isNotEmpty &&
        _actions.isNotEmpty &&
        _validationError == null;
  }

  Future<void> _saveRule() async {
    final rule = _buildCurrentRule();
    // TODO: Save to database
    if (mounted) {
      Navigator.pop(context, rule);
    }
  }

  Future<void> _runPreview() async {
    if (_previewRule == null) return;

    // TODO: Run preview with F8 rule engine
    final results = await _ruleEngine.previewRule(_previewRule!);

    setState(() {
      _previewResults = results.matchedFiles.map((m) => m.uri).toList();
    });
  }

  Future<void> _generateAIRule() async {
    final prompt = _aiPromptController.text.trim();
    if (prompt.length < 4) {
      // Per spec: minimum 4 characters
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prompt too short (min 4 characters)')),
      );
      return;
    }

    // TODO: Call AI service to generate rule JSON
    // For now, show placeholder
    setState(() {
      _generatedRuleJson = '{\n  "id": "ai_generated",\n  "trigger": {...}\n}';
    });
  }
}
