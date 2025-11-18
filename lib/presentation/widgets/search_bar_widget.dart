// FILO Search Bar Widget
// Refs: ui_blueprint_ultra_ultra.md lines 38-62 (Search Bar Complete Anatomy)

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Search bar widget matching ui_blueprint_ultra_ultra.md specifications
/// Height: 48dp, Radius: 12dp, Icons: 20dp
class SearchBarWidget extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;

  const SearchBarWidget({
    super.key,
    this.hintText = 'Search files...',
    this.onChanged,
    this.onTap,
    this.readOnly = false,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 180),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
        if (_isFocused) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      });
    });

    _controller.addListener(() {
      setState(() {}); // Rebuild to show/hide clear button
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _clearText() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    // ui_blueprint_ultra_ultra.md: Height 48dp, Radius 12dp
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: _isFocused
              ? AppColors
                    .surfaceElevated // Focused state
              : AppColors.surface, // Idle state
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isFocused
              ? [
                  // 2dp mid shadow when focused
                  BoxShadow(
                    color: Colors.black.withOpacity(0.14),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                  ),
                ]
              : null,
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          style: AppTypography.bodyM,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTypography.bodyM.copyWith(
              color: AppColors.textSecondary.withOpacity(
                _isFocused ? 0.4 : 0.6, // Placeholder opacity per spec
              ),
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 20, // Leading icon 20dp per spec
              color: AppColors.textSecondary,
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      size: 20, // Trailing icon 20dp per spec
                      color: AppColors.textSecondary,
                    ),
                    onPressed: _clearText,
                  )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSpacing.paddingMedium,
              vertical: AppSpacing.xl,
            ),
          ),
          cursorColor: AppColors.accentTeal500, // Accent teal cursor per spec
        ),
      ),
    );
  }
}
