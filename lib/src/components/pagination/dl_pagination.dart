// lib/src/components/pagination/dl_pagination.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// Light / dark visual modes (for white vs black backgrounds).
enum DLPaginationMode { light, dark }

/// Single pagination dot.
///
/// - Tap area: 16x16
/// - Circle:   8x8, centered, 4px padding around
/// - Colors:
///   * light mode: selected = black,   default = grey500
///   * dark mode:  selected = white,   default = grey500 with opacity
class DLPaginationDot extends StatelessWidget {
  const DLPaginationDot({
    super.key,
    required this.selected,
    this.mode = DLPaginationMode.dark,
  });

  final bool selected;
  final DLPaginationMode mode;

  static const double _circleSize = 8;
  static const double _padding = 4;
  static const double _tapSize = _circleSize + _padding * 2; // 16

  @override
  Widget build(BuildContext context) {
    final bool isDark = mode == DLPaginationMode.dark;

    Color base;
    if (isDark) {
      base = selected ? DLColors.white : DLColors.grey500.withOpacity(0.8);
    } else {
      base = selected ? DLColors.black : DLColors.grey500;
    }

    return SizedBox(
      width: _tapSize,
      height: _tapSize,
      child: Center(
        child: Container(
          width: _circleSize,
          height: _circleSize,
          decoration: BoxDecoration(color: base, borderRadius: DLRadii.brFull),
        ),
      ),
    );
  }
}

/// Row of pagination dots (2–5).
///
/// - `count`: number of dots (2–5)
/// - `activeIndex`: which dot is selected (0-based)
/// - `expanded`:
///    * false → row only takes the space needed by the dots
///    * true  → row stretches to full available width
class DLPagination extends StatelessWidget {
  const DLPagination({
    super.key,
    required this.count,
    required this.activeIndex,
    this.mode = DLPaginationMode.dark,
    this.expanded = false,
  }) : assert(count >= 2 && count <= 5),
       assert(activeIndex >= 0 && activeIndex < count);

  final int count;
  final int activeIndex;
  final DLPaginationMode mode;
  final bool expanded;

  static const double _dotTapSize = 16;
  static const double _gap = 8;

  double get _minWidth =>
      count * _dotTapSize + (count - 1) * _gap; // just for info

  @override
  Widget build(BuildContext context) {
    final dots = <Widget>[];
    for (var i = 0; i < count; i++) {
      dots.add(DLPaginationDot(selected: i == activeIndex, mode: mode));
      if (!expanded && i != count - 1) {
        dots.add(const SizedBox(width: _gap));
      }
    }

    final row = Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: expanded
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      children: dots,
    );

    final widget = expanded
        ? SizedBox(height: _dotTapSize, width: double.infinity, child: row)
        : row;

    return Semantics(
      label: 'Pagination, page ${activeIndex + 1} of $count',
      child: widget,
    );
  }
}
