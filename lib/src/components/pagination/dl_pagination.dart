// lib/src/components/pagination/dl_pagination.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// Light / dark visual modes (for white vs black backgrounds).
enum DLPaginationMode { light, dark }

/// Single pagination dot.
///
/// Spec (per structure screenshot):
/// - Tap area: 16x16
/// - Circle:   12x12, centered
/// - Padding:  2px on all sides (inside 16x16)
class DLPaginationDot extends StatelessWidget {
  const DLPaginationDot({
    super.key,
    required this.selected,
    this.mode = DLPaginationMode.dark,
  });

  final bool selected;
  final DLPaginationMode mode;

  static const double _tapSize = DLSpacing.p16;
  static const double _circleSize = DLSpacing.p12;
  static const double _padding = DLSpacing.p2;

  @override
  Widget build(BuildContext context) {
    final isDark = mode == DLPaginationMode.dark;

    final Color base = isDark
        ? (selected ? DLColors.white : DLColors.grey500.withOpacity(0.8))
        : (selected ? DLColors.black : DLColors.grey500);

    return SizedBox(
      width: _tapSize,
      height: _tapSize,
      child: Padding(
        padding: const EdgeInsets.all(_padding),
        child: Center(
          child: Container(
            width: _circleSize,
            height: _circleSize,
            decoration: BoxDecoration(
              color: base,
              borderRadius: DLRadii.brFull,
            ),
          ),
        ),
      ),
    );
  }
}

/// Row of pagination dots (2–5).
///
/// - Gap between dots (between 16x16 tap targets): 4px
/// - `expanded`:
///    * false → row hugs content
///    * true  → row takes full width (dots still keep fixed 4px gaps; alignment
///             should be handled by parent via Align if needed)
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

  static const double _dotTapSize = DLSpacing.p16;
  static const double _gap = DLSpacing.p4;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < count; i++) {
      children.add(DLPaginationDot(selected: i == activeIndex, mode: mode));
      if (i != count - 1) children.add(const SizedBox(width: _gap));
    }

    final row = Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: children,
    );

    return Semantics(
      label: 'Pagination, page ${activeIndex + 1} of $count',
      child: expanded
          ? SizedBox(height: _dotTapSize, width: double.infinity, child: row)
          : row,
    );
  }
}
