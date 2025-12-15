// lib/src/components/calendar/dl_calendar_month.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';
import 'dl_calendar_item.dart';

/// Simple month calendar using DLCalendarItem cells.
/// Layout:
/// - Days 1..N laid out in rows of 7 (no weekday shift).
/// - No spacing between cells (full calendar "block").
/// - Range selection: tap start, then tap end -> selects all days in between.
class DLCalendarMonth extends StatefulWidget {
  const DLCalendarMonth({
    super.key,
    required this.month,
    this.initialSelectedDay,
    this.onDaySelected,
    this.onRangeSelected,
    this.disabledPredicate,
  });

  /// Month to display – year & month are used, day is ignored.
  final DateTime month;

  /// Backwards-compatible: first active day.
  /// If you provide this, it becomes the initial "start" day.
  final int? initialSelectedDay;

  /// Called when user taps a day.
  /// Gives back a full DateTime for that day.
  final ValueChanged<DateTime>? onDaySelected;

  /// Called when a full range is selected (start + end).
  /// Range is inclusive.
  final ValueChanged<DateTimeRange>? onRangeSelected;

  /// Optional predicate to mark specific days as disabled.
  final bool Function(DateTime date)? disabledPredicate;

  @override
  State<DLCalendarMonth> createState() => _DLCalendarMonthState();
}

class _DLCalendarMonthState extends State<DLCalendarMonth> {
  late final int _daysInMonth;

  int? _rangeStartDay;
  int? _rangeEndDay;

  @override
  void initState() {
    super.initState();
    _daysInMonth = DateTime(widget.month.year, widget.month.month + 1, 0).day;
    _rangeStartDay = widget.initialSelectedDay;
    _rangeEndDay = null;
  }

  DateTime _dayToDate(int day) =>
      DateTime(widget.month.year, widget.month.month, day);

  bool _isDisabledDay(int day) {
    final date = _dayToDate(day);
    return widget.disabledPredicate?.call(date) == true;
  }

  bool _isInSelectedRange(int day) {
    if (_rangeStartDay == null) return false;

    // Single selection (start only)
    if (_rangeEndDay == null) return day == _rangeStartDay;

    final a = _rangeStartDay!;
    final b = _rangeEndDay!;
    final start = a < b ? a : b;
    final end = a < b ? b : a;

    return day >= start && day <= end;
  }

  bool _isRangeEndpoint(int day) {
    if (_rangeStartDay == null) return false;
    if (_rangeEndDay == null) return day == _rangeStartDay;
    return day == _rangeStartDay || day == _rangeEndDay;
  }

  DLCalendarItemState _stateForDay(int day) {
    if (_isDisabledDay(day)) return DLCalendarItemState.disabled;

    if (_isInSelectedRange(day)) {
      // Endpoints are active (black), middle is selected (grey bg)
      return _isRangeEndpoint(day)
          ? DLCalendarItemState.active
          : DLCalendarItemState.selected;
    }

    return DLCalendarItemState.normal;
  }

  void _handleTapDay(int day) {
    if (_isDisabledDay(day)) return;

    final tappedDate = _dayToDate(day);

    setState(() {
      // If no start yet, set start.
      if (_rangeStartDay == null) {
        _rangeStartDay = day;
        _rangeEndDay = null;
      }
      // If start exists but no end yet, set end (if different).
      else if (_rangeEndDay == null) {
        if (day == _rangeStartDay) {
          // tapping same day keeps single-day selection
          _rangeEndDay = null;
        } else {
          _rangeEndDay = day;
        }
      }
      // If we already have a range, start a new range from this tap.
      else {
        _rangeStartDay = day;
        _rangeEndDay = null;
      }
    });

    widget.onDaySelected?.call(tappedDate);

    if (_rangeStartDay != null && _rangeEndDay != null) {
      final a = _dayToDate(_rangeStartDay!);
      final b = _dayToDate(_rangeEndDay!);

      final start = a.isBefore(b) ? a : b;
      final end = a.isBefore(b) ? b : a;

      widget.onRangeSelected?.call(DateTimeRange(start: start, end: end));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _daysInMonth,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 0, // no spacing (tight block)
        mainAxisSpacing: 0, // no spacing (tight block)
        childAspectRatio: 1, // square cell
      ),
      itemBuilder: (context, index) {
        final day = index + 1;
        final state = _stateForDay(day);

        return DLCalendarItem(
          day: day,
          state: state,
          onTap: () => _handleTapDay(day),
        );
      },
    );
  }
}
