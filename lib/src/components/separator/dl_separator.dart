import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart'; // gives access to DLColors.grey200

enum DLSeparatorDirection { horizontal, vertical }

/// The separator widget implementation (uses solid grey.200 by default).
class DLSeparator extends StatelessWidget {
  const DLSeparator({
    super.key,
    this.direction = DLSeparatorDirection.horizontal,
    this.length,
    this.thickness = 1.0,
    this.color, // if null, falls back to DLColors.grey200
    this.radius,
    this.margin,
  });

  final DLSeparatorDirection direction;
  final double? length;
  final double thickness;
  final Color? color;
  final BorderRadiusGeometry? radius;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final isH = direction == DLSeparatorDirection.horizontal;

    // ✅ Always use a solid token color by default (no opacity blending).
    final c = color ?? DLColors.grey200;

    final line = SizedBox(
      width: isH ? (length ?? double.infinity) : thickness,
      height: isH ? thickness : (length ?? double.infinity),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: c,
          borderRadius: radius ?? BorderRadius.circular(thickness / 2),
        ),
      ),
    );

    if (margin != null) {
      return Padding(padding: margin!, child: line);
    }
    return line;
  }
}
