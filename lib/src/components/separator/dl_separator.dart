import 'package:flutter/material.dart';

enum DLSeparatorDirection { horizontal, vertical }

/// The separator widget implementation.
class DLSeparator extends StatelessWidget {
  const DLSeparator({
    super.key,
    this.direction = DLSeparatorDirection.horizontal,
    this.length,
    this.thickness = 1.0,
    this.color,
    this.opacity = 1.0,
    this.radius,
    this.margin,
  });

  final DLSeparatorDirection direction;
  final double? length;
  final double thickness;
  final Color? color;
  final double opacity;
  final BorderRadiusGeometry? radius;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final isH = direction == DLSeparatorDirection.horizontal;
    final c = (color ?? Theme.of(context).dividerColor).withOpacity(
      opacity.clamp(0.0, 1.0),
    );

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
