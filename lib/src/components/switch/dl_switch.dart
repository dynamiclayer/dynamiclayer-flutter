// lib/src/components/switch/dl_switch.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

class DLSwitch extends StatelessWidget {
  const DLSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.semanticLabel,
  });

  /// Current value of the switch.
  final bool value;

  /// Called when the user toggles the switch.
  final ValueChanged<bool>? onChanged;

  /// If false → ignore taps (visuals stay the same for now).
  final bool enabled;

  /// Optional semantics label.
  final String? semanticLabel;

  static const double _trackWidth = 50;
  static const double _trackHeight = 32;
  static const double _thumbSize = 24;
  static const Duration _duration = Duration(milliseconds: 100);
  static const Curve _curve = Curves.easeOut;

  bool get _isDisabled => !enabled || onChanged == null;

  Color get _trackColor {
    if (value) {
      // active
      return DLColors.black;
    }
    // default
    return DLColors.grey200;
  }

  void _handleTap() {
    if (_isDisabled) return;
    onChanged?.call(!value);
  }

  @override
  Widget build(BuildContext context) {
    final thumb = Container(
      width: _thumbSize,
      height: _thumbSize,
      decoration: const BoxDecoration(
        color: DLColors.white,
        shape: BoxShape.circle,
      ),
    );

    final track = AnimatedContainer(
      duration: _duration,
      curve: _curve,
      width: _trackWidth,
      height: _trackHeight,
      decoration: BoxDecoration(
        color: _trackColor,
        borderRadius: DLRadii.brFull,
      ),
      padding: const EdgeInsets.all(4), // 32 - 24 = 8 → 4px top/bottom/side
      child: AnimatedAlign(
        duration: _duration,
        curve: _curve,
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: thumb,
      ),
    );

    final interactive = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _isDisabled ? null : _handleTap,
      child: track,
    );

    return Semantics(
      button: true,
      toggled: value,
      enabled: !_isDisabled,
      label: semanticLabel,
      child: interactive,
    );
  }
}
