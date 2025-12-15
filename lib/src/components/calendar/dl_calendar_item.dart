// lib/src/components/calendar/dl_calendar_item.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// Visual states, mapped from your spec:
/// - normal   -> "default"
/// - unselect -> "unselect"
/// - selected -> "select"
/// - active   -> "active"
/// - disabled -> "disabled"
enum DLCalendarItemState { normal, unselect, selected, active, disabled }

class DLCalendarItem extends StatelessWidget {
  const DLCalendarItem({
    super.key,
    required this.day,
    this.state = DLCalendarItemState.normal,
    this.onTap,
  });

  /// Day label to display (usually 1..31).
  final int day;

  final DLCalendarItemState state;

  /// Called when the cell is tapped (if not disabled).
  final VoidCallback? onTap;

  static const double _size = 48.0;
  static const double _padding = DLSpacing.p12;

  bool get _isDisabled => state == DLCalendarItemState.disabled;

  Color _backgroundColor() {
    switch (state) {
      case DLCalendarItemState.normal:
      case DLCalendarItemState.unselect:
      case DLCalendarItemState.disabled:
        return DLColors.white; // default & unselect & disabled
      case DLCalendarItemState.selected:
        return DLColors.grey100; // "select"
      case DLCalendarItemState.active:
        return DLColors.black; // "active"
    }
  }

  Color _textColor() {
    switch (state) {
      case DLCalendarItemState.normal:
      case DLCalendarItemState.selected:
        return DLColors.black;
      case DLCalendarItemState.active:
        return DLColors.white;
      case DLCalendarItemState.unselect:
        return DLColors.grey500;
      case DLCalendarItemState.disabled:
        return DLColors.grey300;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bg = _backgroundColor();
    final fg = _textColor();

    Widget cell = Container(
      width: _size,
      height: _size,
      padding: const EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: bg,
        // No border radius: square corners
        borderRadius: BorderRadius.zero,
      ),
      child: Center(
        child: Text(
          '$day',
          // Medium instead of Regular
          style: DLTypos.textBaseMedium(color: fg),
        ),
      ),
    );

    if (_isDisabled || onTap == null) return cell;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: cell,
    );
  }
}
