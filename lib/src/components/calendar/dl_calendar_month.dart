// lib/src/components/calendar/dl_calendar_month.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';
import 'dl_calendar_item.dart';

/// Simple month calendar using DLCalendarItem cells.
/// Layout:
/// - Days 1..N laid out in rows of 7 (no weekday shift).
class DLCalendarMonth extends StatefulWidget {
  const DLCalendarMonth({
    super.key,
    required this.month,
    this.initialSelectedDay,
    this.onDaySelected,
    this.disabledPredicate,
    this.spacing = 8,
    this.runSpacing = 8,
  });

  /// Month to display – year & month are used, day is ignored.
  ///
  /// Example: DateTime(2024, 5) → May 2024
  final DateTime month;

  /// Day number (1..daysInMonth) that starts as active.
  final int? initialSelectedDay;

  /// Called when user taps a day.
  /// Gives back a full DateTime for that day.
  final ValueChanged<DateTime>? onDaySelected;

  /// Optional predicate to mark specific days as disabled.
  /// Example: (date) => date.isBefore(DateTime.now())
  final bool Function(DateTime date)? disabledPredicate;

  /// Horizontal spacing between items.
  final double spacing;

  /// Vertical spacing between rows.
  final double runSpacing;

  @override
  State<DLCalendarMonth> createState() => _DLCalendarMonthState();
}

class _DLCalendarMonthState extends State<DLCalendarMonth> {
  int? _activeDay;
  late final int _daysInMonth;

  @override
  void initState() {
    super.initState();
    _daysInMonth = DateTime(widget.month.year, widget.month.month + 1, 0).day;
    _activeDay = widget.initialSelectedDay;
  }

  DateTime _dayToDate(int day) =>
      DateTime(widget.month.year, widget.month.month, day);

  DLCalendarItemState _stateForDay(int day) {
    final date = _dayToDate(day);

    if (widget.disabledPredicate?.call(date) == true) {
      return DLCalendarItemState.disabled;
    }

    if (_activeDay == day) {
      return DLCalendarItemState.active;
    }

    // All other days are just default (plain text)
    return DLCalendarItemState.normal;
  }

  void _handleTapDay(int day) {
    final date = _dayToDate(day);

    if (widget.disabledPredicate?.call(date) == true) {
      return;
    }

    setState(() {
      // Only one active day at any time
      _activeDay = day;
    });

    widget.onDaySelected?.call(date);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      children: List.generate(_daysInMonth, (index) {
        final day = index + 1;
        final state = _stateForDay(day);
        return DLCalendarItem(
          day: day,
          state: state,
          onTap: () => _handleTapDay(day),
        );
      }),
    );
  }
}
