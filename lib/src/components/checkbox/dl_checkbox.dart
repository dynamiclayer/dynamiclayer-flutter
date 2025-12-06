// lib/src/components/checkbox/dl_checkbox.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// DLCheckbox
///
/// Visual mapping to your spec / screenshot:
/// - value == false, enabled:
///     • 24x24 square
///     • transparent background
///     • grey border
/// - value == true, enabled:
///     • black background
///     • no border
///     • white checkmark
/// - value == null, enabled (indeterminate):
///     • black background
///     • no border
///     • white minus
/// - enabled == false (any value):
///     • grey300 background
///     • no border
///     • white minus (disabled indicator)
///
/// API:
/// - value: bool?            (null = indeterminate)
/// - onChanged: ValueChanged<bool?>?
/// - enabled: bool
class DLCheckbox extends StatelessWidget {
  const DLCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.semanticLabel,
  });

  /// true  = checked
  /// false = unchecked
  /// null  = indeterminate
  final bool? value;

  /// Called when the checkbox is tapped (if enabled).
  final ValueChanged<bool?>? onChanged;

  /// Whether the control is interactive.
  final bool enabled;

  final String? semanticLabel;

  static const double _size = 24.0;
  static const double _borderRadius = 4.0;

  bool get _isDisabled => !enabled || onChanged == null;

  Color _background() {
    if (_isDisabled) {
      return DLColors.grey300; // disabled
    }

    if (value == true || value == null) {
      // checked or indeterminate
      return DLColors.black;
    }

    // unchecked
    return Colors.transparent;
  }

  Color? _borderColor() {
    if (_isDisabled) return null;

    if (value == true || value == null) {
      return null; // filled states have no border
    }

    // unchecked
    return DLColors.grey300;
  }

  Widget? _icon() {
    // Disabled: always show minus (per screenshot)
    if (_isDisabled) {
      return _minusIcon(color: DLColors.white);
    }

    if (value == true) {
      // Checkmark
      return _checkIcon(color: DLColors.white);
    }

    if (value == null) {
      // Indeterminate
      return _minusIcon(color: DLColors.white);
    }

    // unchecked: no icon
    return null;
  }

  Widget _checkIcon({required Color color}) {
    return Icon(Icons.check_rounded, size: 16, color: color);
  }

  Widget _minusIcon({required Color color}) {
    return Icon(Icons.remove_rounded, size: 16, color: color);
  }

  void _handleTap() {
    if (_isDisabled) return;

    // Behaviour similar to Flutter's tristate Checkbox:
    // false -> true -> false (if value is bool)
    // null  -> true  (if starting from null)
    bool? next;
    if (value == null) {
      next = true;
    } else {
      next = !value!;
    }

    onChanged?.call(next);
  }

  @override
  Widget build(BuildContext context) {
    final bg = _background();
    final borderColor = _borderColor();
    final icon = _icon();

    Widget box = Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(_borderRadius),
        border: borderColor != null
            ? Border.all(color: borderColor, width: DLBorderWidth.w1_5)
            : null,
      ),
      child: icon == null ? null : Center(child: icon),
    );

    box = Semantics(
      container: true,
      checked: value == true,
      enabled: !_isDisabled,
      label: semanticLabel ?? 'Checkbox',
      child: box,
    );

    if (_isDisabled) {
      return box;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _handleTap,
      child: box,
    );
  }
}
