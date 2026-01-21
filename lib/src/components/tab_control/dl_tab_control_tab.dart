import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

enum DLTabControlTabState { selected, defaultState, disabled }

class DLTabControlTab extends StatelessWidget {
  const DLTabControlTab({
    super.key,
    required this.label,
    this.state = DLTabControlTabState.defaultState,
    this.badge = false,
    this.onTap,
  });

  final String label;
  final DLTabControlTabState state;

  /// If true → show a small dot badge (keep it simple; no DLBadge.dot).
  final bool badge;

  final VoidCallback? onTap;

  bool get _isDisabled =>
      state == DLTabControlTabState.disabled || onTap == null;

  static const Color _defaultLabelColor = Color(0xFF757575);

  Color _labelColor() {
    switch (state) {
      case DLTabControlTabState.selected:
        return DLColors.black;
      case DLTabControlTabState.defaultState:
        return _defaultLabelColor;
      case DLTabControlTabState.disabled:
        return _defaultLabelColor;
    }
  }

  TextDecoration _textDecoration() {
    return state == DLTabControlTabState.disabled
        ? TextDecoration.lineThrough
        : TextDecoration.none;
  }

  Color _underlineColor() {
    // Per Figma: selected underline black, others grey
    return state == DLTabControlTabState.selected
        ? DLColors.black
        : DLColors.grey200;
  }

  @override
  Widget build(BuildContext context) {
    // Figma: height 56, padding t/b 16, l/r 8, underline 2px
    const height = 56.0;
    const underlineH = 2.0;
    const pad = EdgeInsets.symmetric(horizontal: 8, vertical: 16);

    final content = SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Main content (text + optional dot badge)
          Padding(
            padding: pad,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        // Swap to your typography token if available
                        fontSize: 14,
                        height: 1.2,
                        letterSpacing: 0.2,
                        color: _labelColor(),
                        decoration: _textDecoration(),
                      ),
                    ),
                  ),
                  if (badge) ...[
                    const SizedBox(width: 8),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: DLColors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Per-tab underline (always visible)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(height: underlineH, color: _underlineColor()),
          ),
        ],
      ),
    );

    return Semantics(
      button: true,
      enabled: !_isDisabled,
      selected: state == DLTabControlTabState.selected,
      child: Material(
        color: Colors.transparent,
        child: InkWell(onTap: _isDisabled ? null : onTap, child: content),
      ),
    );
  }
}
