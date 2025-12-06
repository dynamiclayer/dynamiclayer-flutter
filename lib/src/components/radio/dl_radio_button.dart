// lib/src/components/radio/dl_radio_button.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

class DLRadioButton extends StatelessWidget {
  const DLRadioButton({
    super.key,
    required this.selected,
    this.enabled = true,
    this.onChanged,
    this.semanticLabel,
  });

  /// Whether this radio is currently selected (active state).
  final bool selected;

  /// If false → shows disabled visuals and ignores taps.
  final bool enabled;

  /// Called when user taps the radio.
  /// For a single radio, you usually call onChanged(true) and handle group
  /// logic in the parent.
  final ValueChanged<bool>? onChanged;

  /// Optional semantics label.
  final String? semanticLabel;

  static const double _size = 24.0;

  bool get _isDisabled => !enabled || onChanged == null;

  BoxDecoration _decoration() {
    if (_isDisabled) {
      // Disabled: light grey fill + grey border, no inner dot
      return BoxDecoration(
        color: DLColors.grey100,
        shape: BoxShape.circle,
        border: Border.all(color: DLColors.grey200, width: DLBorderWidth.w1),
      );
    }

    if (selected) {
      // Active: solid black circle (inner dot is drawn separately)
      return const BoxDecoration(color: DLColors.black, shape: BoxShape.circle);
    }

    // Default: white center, grey border
    return BoxDecoration(
      color: DLColors.white,
      shape: BoxShape.circle,
      border: Border.all(color: DLColors.grey200, width: DLBorderWidth.w1),
    );
  }

  Widget _buildInnerDot() {
    if (!selected || _isDisabled) {
      // No dot for default or disabled in your spec
      return const SizedBox.shrink();
    }

    // White inner dot inside black outer circle
    return Center(
      child: Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          color: DLColors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  void _handleTap() {
    if (_isDisabled) return;
    onChanged?.call(true);
  }

  @override
  Widget build(BuildContext context) {
    final radio = Container(
      width: _size,
      height: _size,
      decoration: _decoration(),
      child: _buildInnerDot(),
    );

    final interactive = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _handleTap,
      child: radio,
    );

    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      enabled: !_isDisabled,
      label: semanticLabel,
      child: interactive,
    );
  }
}
