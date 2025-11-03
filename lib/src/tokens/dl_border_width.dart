import 'package:flutter/material.dart';

/// Border width tokens (px-based) + quick helpers.
///
/// Token mapping (from your spec):
/// 0px   → w0
/// 0.5px → w0_5
/// 1px   → w1
/// 1.5px → w1_5
/// 2px   → w2
/// 3px   → w3
/// 4px   → w4
class DLBorderWidth {
  DLBorderWidth._();

  // Raw values
  static const double w0 = 0.0;
  static const double w0_5 = 0.5;
  static const double w1 = 1.0;
  static const double w1_5 = 1.5;
  static const double w2 = 2.0;
  static const double w3 = 3.0;
  static const double w4 = 4.0;

  /// Convenience: create a BorderSide with the given width & color.
  static BorderSide side(double width, {Color color = Colors.black}) =>
      BorderSide(width: width, color: color);

  /// Convenience: uniform border on all sides.
  static BoxBorder all(double width, {Color color = Colors.black}) =>
      Border.fromBorderSide(side(width, color: color));

  /// Convenience: only specific sides.
  static BoxBorder only({
    double left = w0,
    double top = w0,
    double right = w0,
    double bottom = w0,
    Color color = Colors.black,
  }) {
    return Border(
      left: side(left, color: color),
      top: side(top, color: color),
      right: side(right, color: color),
      bottom: side(bottom, color: color),
    );
  }
}
